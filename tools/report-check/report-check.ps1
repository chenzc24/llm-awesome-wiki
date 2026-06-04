param(
    [string] $Workspace = ".",
    [string] $ReportsDir = "reports",
    [string] $Report = "report-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "report-check"
$toolPhase = "Phase 6.5 report surface validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]

$validRoundStatuses = @("pass", "fail", "needs-review")
$validCheckResults = @("pass", "fail", "needs-review", "not-enabled", "not-run")
$validCheckCategories = @("deterministic", "manual-protocol", "human-review")
$validClosureDecisions = @("close-pass", "close-with-review", "do-not-close")
$validClaimStatuses = @("draft", "supported", "weak", "unsupported", "contested", "generated-derived", "reviewed-generated", "needs-review", "not-in-scope", "stale")
$validReviewStatuses = @("open", "in-review", "resolved", "dismissed", "carried-forward", "blocked", "stale")
$validBlockingLevels = @("blocking", "nonblocking", "informational")
$validQueueStatuses = @("active", "needs-review", "blocked", "closed")

function Resolve-ReportPath {
    param([string] $Path)
    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }
    return (Join-Path (Get-Location).Path $Path)
}

function Resolve-WorkspaceFile {
    param(
        [string] $WorkspacePath,
        [string] $RelativePath
    )

    $localPath = $RelativePath -replace "/", [System.IO.Path]::DirectorySeparatorChar
    return (Join-Path $WorkspacePath $localPath)
}

function Convert-ToWorkspaceRelativePath {
    param(
        [string] $WorkspacePath,
        [string] $Path
    )

    $workspaceFull = [System.IO.Path]::GetFullPath($WorkspacePath).TrimEnd([char[]]@('\', '/'))
    $pathFull = [System.IO.Path]::GetFullPath($Path)
    if (-not $pathFull.StartsWith($workspaceFull, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $Path
    }

    $relative = $pathFull.Substring($workspaceFull.Length).TrimStart([char[]]@('\', '/'))
    return ($relative -replace "\\", "/")
}

function Normalize-EnumValue {
    param([string] $Value)

    return $Value.Trim().Trim([char]'`').Trim().ToLowerInvariant()
}

function Test-PlaceholderValue {
    param([string] $Value)

    $text = $Value.Trim().ToLowerInvariant()
    return ($text -eq "" -or $text -match "replace this row|replace-me|pass/fail|yes/no|open/in-review")
}

function Test-Section {
    param(
        [string] $Content,
        [string] $Section
    )

    return ($Content -match "(?im)^##\s+$([regex]::Escape($Section))\s*$")
}

function Require-Sections {
    param(
        [string] $Label,
        [string] $Content,
        [string[]] $Sections
    )

    foreach ($section in $Sections) {
        if (-not (Test-Section $Content $section)) {
            $script:failures.Add("${Label}: missing section '$section'.")
        }
    }
}

function Get-FieldValue {
    param(
        [string] $Content,
        [string] $FieldName
    )

    $escaped = [regex]::Escape($FieldName)
    $match = [regex]::Match($Content, "(?im)^-\s*$escaped\s*:\s*(.+?)\s*$")
    if (-not $match.Success) {
        return ""
    }

    return $match.Groups[1].Value.Trim()
}

function Split-MarkdownRow {
    param([string] $Line)

    $trimmed = $Line.Trim()
    if ($trimmed.StartsWith("|")) {
        $trimmed = $trimmed.Substring(1)
    }
    if ($trimmed.EndsWith("|")) {
        $trimmed = $trimmed.Substring(0, $trimmed.Length - 1)
    }
    return @($trimmed -split "\|" | ForEach-Object { $_.Trim() })
}

function Test-MarkdownSeparator {
    param([string] $Line)

    if (-not $Line.Trim().StartsWith("|")) {
        return $false
    }

    $cells = Split-MarkdownRow $Line
    if ($cells.Count -eq 0) {
        return $false
    }
    foreach ($cell in $cells) {
        if ($cell -notmatch "^:?-{3,}:?$") {
            return $false
        }
    }
    return $true
}

function Read-MarkdownTables {
    param([string[]] $Lines)

    $tables = New-Object System.Collections.Generic.List[object]
    for ($i = 0; $i -lt ($Lines.Count - 1); $i++) {
        if ($Lines[$i].Trim().StartsWith("|") -and (Test-MarkdownSeparator $Lines[$i + 1])) {
            $headers = @(Split-MarkdownRow $Lines[$i] | ForEach-Object { $_.ToLowerInvariant() })
            $rows = New-Object System.Collections.Generic.List[object]

            for ($j = $i + 2; $j -lt $Lines.Count; $j++) {
                $line = $Lines[$j]
                if (-not $line.Trim().StartsWith("|")) {
                    break
                }

                $cells = @(Split-MarkdownRow $line)
                $row = [ordered]@{
                    line_number = $j + 1
                }
                for ($k = 0; $k -lt $headers.Count; $k++) {
                    $value = ""
                    if ($k -lt $cells.Count) {
                        $value = $cells[$k]
                    }
                    $row[$headers[$k]] = $value
                }
                $rows.Add([pscustomobject]$row)
            }

            $tables.Add([pscustomobject]@{
                Headers = $headers
                Rows = $rows
            })
        }
    }

    return $tables
}

function Find-Table {
    param(
        [object[]] $Tables,
        [string[]] $RequiredHeaders
    )

    foreach ($table in $Tables) {
        $missing = @($RequiredHeaders | Where-Object { $table.Headers -notcontains $_ })
        if ($missing.Count -eq 0) {
            return $table
        }
    }
    return $null
}

function Get-Cell {
    param(
        [object] $Row,
        [string] $Name
    )

    $property = $Row.PSObject.Properties[$Name]
    if ($null -eq $property -or $null -eq $property.Value) {
        return ""
    }
    return [string]$property.Value
}

function Test-SourceRefList {
    param([string] $Value)

    if (Test-PlaceholderValue $Value) {
        return $false
    }
    return ($Value -match "[A-Za-z0-9_.\-/]+#[A-Za-z0-9_.\-/]+")
}

function Test-IdList {
    param([string] $Value)

    if (Test-PlaceholderValue $Value) {
        return $false
    }
    return ($Value -match "[A-Za-z0-9_.\-/]+")
}

function Check-CompareReport {
    param(
        [string] $Label,
        [string] $Content,
        [object[]] $Tables
    )

    Require-Sections $Label $Content @(
        "Round Scope",
        "Status Summary",
        "Input Artifacts",
        "Check Matrix",
        "Decision And Next Actions"
    )

    $status = Normalize-EnumValue (Get-FieldValue $Content "Status")
    if ($validRoundStatuses -notcontains $status) {
        $script:failures.Add("${Label}: compare report Status must be pass/fail/needs-review.")
    }

    if ($status -eq "pass" -and $Content -match "compare gate not enabled") {
        $script:failures.Add("${Label}: pass cannot be used when compare gate is not enabled.")
    }

    $matrix = Find-Table $Tables @("check", "category", "result", "blocking", "evidence")
    if ($null -eq $matrix) {
        $script:failures.Add("${Label}: missing Check Matrix table.")
        return
    }

    foreach ($row in $matrix.Rows) {
        $check = Get-Cell $row "check"
        $category = Normalize-EnumValue (Get-Cell $row "category")
        $result = Normalize-EnumValue (Get-Cell $row "result")
        $blocking = Normalize-EnumValue (Get-Cell $row "blocking")
        $line = Get-Cell $row "line_number"

        if (Test-PlaceholderValue $check) {
            $script:reviewFindings.Add("${Label}: check matrix row $line still looks like a placeholder.")
            continue
        }
        if ($validCheckCategories -notcontains $category) {
            $script:failures.Add("${Label}: check matrix row $line has invalid category '$category'.")
        }
        if ($validCheckResults -notcontains $result) {
            $script:failures.Add("${Label}: check matrix row $line has invalid result '$result'.")
        }
        if ($blocking -notin @("yes", "no")) {
            $script:failures.Add("${Label}: check matrix row $line blocking must be yes/no.")
        }
        if ($status -eq "pass" -and $result -in @("fail", "needs-review", "not-enabled", "not-run")) {
            $script:failures.Add("${Label}: report status pass conflicts with check '$check' result '$result'.")
        }
        if ($status -eq "pass" -and $blocking -eq "yes") {
            $script:failures.Add("${Label}: report status pass conflicts with blocking check '$check'.")
        }
    }
}

function Check-ClaimEvidenceMap {
    param(
        [string] $Label,
        [string] $Content,
        [object[]] $Tables
    )

    Require-Sections $Label $Content @(
        "Evidence Map",
        "Claim Map",
        "Review Handoff",
        "Result"
    )

    $evidenceTable = Find-Table $Tables @("evidence_id", "source_ref", "evidence_kind")
    if ($null -eq $evidenceTable) {
        $script:failures.Add("${Label}: missing Evidence Map table.")
    }
    else {
        foreach ($row in $evidenceTable.Rows) {
            $evidenceId = Get-Cell $row "evidence_id"
            $sourceRef = Get-Cell $row "source_ref"
            $line = Get-Cell $row "line_number"
            if (-not (Test-IdList $evidenceId)) {
                $script:reviewFindings.Add("${Label}: evidence row $line has blank or placeholder evidence_id.")
            }
            if (-not (Test-SourceRefList $sourceRef)) {
                $script:failures.Add("${Label}: evidence row $line source_ref must use <source_id>#<anchor_id> form.")
            }
        }
    }

    $claimTable = Find-Table $Tables @("claim_id", "claim", "status", "evidence_ids")
    if ($null -eq $claimTable) {
        $script:failures.Add("${Label}: missing Claim Map table.")
        return
    }

    foreach ($row in $claimTable.Rows) {
        $claimId = Get-Cell $row "claim_id"
        $status = Normalize-EnumValue (Get-Cell $row "status")
        $evidenceIds = Get-Cell $row "evidence_ids"
        $reviewIds = Get-Cell $row "review_item_ids"
        $line = Get-Cell $row "line_number"

        if (-not (Test-IdList $claimId)) {
            $script:reviewFindings.Add("${Label}: claim row $line has blank or placeholder claim_id.")
        }
        if ($validClaimStatuses -notcontains $status) {
            $script:failures.Add("${Label}: claim row $line has invalid status '$status'.")
        }
        if ($status -eq "supported" -and -not (Test-IdList $evidenceIds)) {
            $script:failures.Add("${Label}: supported claim row $line must have evidence_ids.")
        }
        if ($status -in @("weak", "unsupported", "contested", "generated-derived", "needs-review", "stale") -and -not (Test-IdList $reviewIds)) {
            $script:reviewFindings.Add("${Label}: claim row $line with status '$status' should route to review_item_ids.")
        }
    }
}

function Check-ReviewQueue {
    param(
        [string] $Label,
        [string] $Content,
        [object[]] $Tables
    )

    Require-Sections $Label $Content @(
        "Scope",
        "Open Review Items",
        "Carried Forward",
        "Notes"
    )

    $queueStatus = Normalize-EnumValue (Get-FieldValue $Content "Queue status")
    if ($queueStatus -ne "" -and $validQueueStatuses -notcontains $queueStatus) {
        $script:failures.Add("${Label}: Queue status must be active/needs-review/blocked/closed.")
    }

    $openItems = Find-Table $Tables @("review_item_id", "status", "blocking_level", "decision_needed")
    if ($null -eq $openItems) {
        $script:failures.Add("${Label}: missing Open Review Items table.")
    }
    else {
        foreach ($row in $openItems.Rows) {
            $reviewId = Get-Cell $row "review_item_id"
            $status = Normalize-EnumValue (Get-Cell $row "status")
            $blocking = Normalize-EnumValue (Get-Cell $row "blocking_level")
            $decisionNeeded = Get-Cell $row "decision_needed"
            $line = Get-Cell $row "line_number"

            if (-not (Test-IdList $reviewId)) {
                $script:reviewFindings.Add("${Label}: review row $line has blank or placeholder review_item_id.")
            }
            if ($validReviewStatuses -notcontains $status) {
                $script:failures.Add("${Label}: review row $line has invalid status '$status'.")
            }
            if ($validBlockingLevels -notcontains $blocking) {
                $script:failures.Add("${Label}: review row $line has invalid blocking_level '$blocking'.")
            }
            if ($status -in @("open", "in-review", "blocked", "stale") -and (Test-PlaceholderValue $decisionNeeded)) {
                $script:reviewFindings.Add("${Label}: active review row $line needs decision_needed.")
            }
        }
    }

    $carried = Find-Table $Tables @("review_item_id", "blocking_level", "blocks_pass")
    if ($null -ne $carried) {
        foreach ($row in $carried.Rows) {
            $reviewId = Get-Cell $row "review_item_id"
            $blocking = Normalize-EnumValue (Get-Cell $row "blocking_level")
            $blocksPass = Normalize-EnumValue (Get-Cell $row "blocks_pass")
            $line = Get-Cell $row "line_number"

            if (Test-PlaceholderValue $reviewId) {
                continue
            }
            if ($validBlockingLevels -notcontains $blocking) {
                $script:failures.Add("${Label}: carried-forward row $line has invalid blocking_level '$blocking'.")
            }
            if ($blocksPass -notin @("yes", "no")) {
                $script:failures.Add("${Label}: carried-forward row $line blocks_pass must be yes/no.")
            }
            if ($blocking -eq "blocking" -and $blocksPass -ne "yes") {
                $script:failures.Add("${Label}: blocking carried-forward review '$reviewId' must block pass.")
            }
        }
    }
}

function Check-ValidationNote {
    param(
        [string] $Label,
        [string] $Content
    )

    Require-Sections $Label $Content @(
        "Round",
        "Checks Performed",
        "Compare Status",
        "Round Closure",
        "Result"
    )

    $status = Normalize-EnumValue (Get-FieldValue $Content "Status")
    $closure = Normalize-EnumValue (Get-FieldValue $Content "Closure decision")
    $compareStatus = Normalize-EnumValue (Get-FieldValue $Content "Compare status")

    if ($status -ne "" -and $validRoundStatuses -notcontains $status) {
        $script:failures.Add("${Label}: Status must be pass/fail/needs-review.")
    }
    if ($closure -ne "" -and $validClosureDecisions -notcontains $closure) {
        $script:failures.Add("${Label}: Closure decision must be close-pass/close-with-review/do-not-close.")
    }
    if ($compareStatus -ne "" -and $compareStatus -notin @("pass", "fail", "needs-review", "compare gate not enabled")) {
        $script:failures.Add("${Label}: Compare status has invalid value '$compareStatus'.")
    }
    if ($closure -eq "close-pass" -and $compareStatus -ne "pass") {
        $script:failures.Add("${Label}: close-pass requires Compare status pass.")
    }
    if ($status -eq "pass" -and $compareStatus -eq "compare gate not enabled") {
        $script:failures.Add("${Label}: pass cannot be used when compare gate is not enabled.")
    }
}

function Convert-TextList {
    param([System.Collections.IEnumerable] $Items)

    $list = @($Items)
    if ($list.Count -eq 0) {
        return "- none"
    }
    return (($list | ForEach-Object { "- $_" }) -join [Environment]::NewLine)
}

$reportPath = Resolve-ReportPath $Report
$reportDir = Split-Path -Parent $reportPath
if ($reportDir -and -not (Test-Path -LiteralPath $reportDir)) {
    New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
}

try {
    $workspacePath = (Resolve-Path -LiteralPath $Workspace).Path
    $checksRun.Add("workspace path exists")
}
catch {
    $workspacePath = $Workspace
    $failures.Add("Workspace path does not exist: $Workspace")
}

$reportsPath = $null
$reportsChecked = 0
$classifiedReports = New-Object System.Collections.Generic.List[string]

if ($failures.Count -eq 0) {
    $reportsPath = Resolve-WorkspaceFile $workspacePath $ReportsDir
    if (-not (Test-Path -LiteralPath $reportsPath -PathType Container)) {
        $reviewFindings.Add("Reports directory does not exist: $ReportsDir")
    }
    else {
        $checksRun.Add("reports directory exists")
        $markdownReports = @(Get-ChildItem -LiteralPath $reportsPath -Recurse -Filter "*.md" -File | Where-Object {
            -not $_.Name.EndsWith(".template.md") -and $_.Name -ne "README.md"
        })

        foreach ($file in $markdownReports) {
            $label = Convert-ToWorkspaceRelativePath $workspacePath $file.FullName
            $normalizedPath = ($label -replace "\\", "/").ToLowerInvariant()
            $content = Get-Content -Raw -LiteralPath $file.FullName
            $tables = @(Read-MarkdownTables @(Get-Content -LiteralPath $file.FullName))
            $matched = $false

            if ($normalizedPath -match "reports/compare/" -or $file.Name.ToLowerInvariant() -match "compare-report") {
                $reportsChecked += 1
                $matched = $true
                $classifiedReports.Add("compare: $label")
                Check-CompareReport $label $content $tables
            }
            if ($normalizedPath -match "claim-evidence" -or $file.Name.ToLowerInvariant() -match "claim-evidence") {
                $reportsChecked += 1
                $matched = $true
                $classifiedReports.Add("claim-evidence: $label")
                Check-ClaimEvidenceMap $label $content $tables
            }
            if ($normalizedPath -match "review-queue" -or $file.Name.ToLowerInvariant() -match "review-queue") {
                $reportsChecked += 1
                $matched = $true
                $classifiedReports.Add("review-queue: $label")
                Check-ReviewQueue $label $content $tables
            }
            if ($normalizedPath -match "reports/validation/" -or $file.Name.ToLowerInvariant() -match "validation-note") {
                $reportsChecked += 1
                $matched = $true
                $classifiedReports.Add("validation-note: $label")
                Check-ValidationNote $label $content
            }

            if (-not $matched) {
                $warnings.Add("Unclassified report ignored: $label")
            }
        }

        if ($reportsChecked -eq 0) {
            $reviewFindings.Add("No compare, claim/evidence, review queue, or validation-note reports found.")
        }
        $checksRun.Add("report files discovered and classified")
    }
}

$status = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $status = "fail"
    $exitCode = 1
    $nextActions.Add("Fix deterministic report-surface failures and rerun report-check.")
}
elseif ($reviewFindings.Count -gt 0) {
    $status = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review report findings before treating report surfaces as complete.")
}
else {
    $nextActions.Add("Proceed to round closure validation or the next Phase 6 checker target.")
}

$checksRunText = Convert-TextList $checksRun
$classifiedReportsText = Convert-TextList $classifiedReports
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions

$reportContent = @"
# Report Check Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Reports directory: $ReportsDir
- Started: $started
- Status: $status
- Exit code: $exitCode
- Reports checked: $reportsChecked

## Checks Run

$checksRunText

## Classified Reports

$classifiedReportsText

## Failures

$failuresText

## Review Findings

$reviewText

## Warnings

$warningsText

## Next Actions

$nextActionsText

## Non-Goals

- Does not extract claims from wiki pages or raw files.
- Does not decide semantic truth.
- Does not rewrite reports.
- Does not generate wiki pages.
- Does not close rounds.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "report-check: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

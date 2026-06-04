param(
    [string] $Workspace = ".",
    [string] $ReportsDir = "reports",
    [string] $WikiDir = "wiki",
    [string] $Report = "round-closure-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "round-closure-check"
$toolPhase = "Phase 6.6 round closure validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]

$validStatuses = @("pass", "fail", "needs-review")
$validCompareStatuses = @("pass", "fail", "needs-review", "compare gate not enabled")
$validClosureDecisions = @("close-pass", "close-with-review", "do-not-close")

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

function Normalize-Value {
    param([string] $Value)

    return $Value.Trim().Trim([char]'`').Trim().ToLowerInvariant()
}

function Test-PlaceholderValue {
    param([string] $Value)

    $text = $Value.Trim().ToLowerInvariant()
    return ($text -eq "" -or $text -match "replace|yes/no|`,| or ")
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

function Test-Yes {
    param([string] $Value)
    return ((Normalize-Value $Value) -eq "yes")
}

function Test-No {
    param([string] $Value)
    return ((Normalize-Value $Value) -eq "no")
}

function Test-RecordedPathExists {
    param(
        [string] $WorkspacePath,
        [string] $RecordedPath
    )

    $clean = $RecordedPath.Trim()
    if ($clean -eq "" -or $clean -match "^none$|^n/a$") {
        return $true
    }
    if ($clean.Contains(" ")) {
        $clean = ($clean -split "\s+")[0]
    }
    if ($clean.StartsWith("[") -and $clean.Contains("](")) {
        $match = [regex]::Match($clean, "\]\(([^)]+)\)")
        if ($match.Success) {
            $clean = $match.Groups[1].Value
        }
    }
    $clean = ($clean -split "#", 2)[0].Trim().Trim("<", ">")
    if ($clean -eq "") {
        return $true
    }
    if ([System.IO.Path]::IsPathRooted($clean)) {
        return (Test-Path -LiteralPath $clean)
    }

    $path = Resolve-WorkspaceFile $WorkspacePath $clean
    return (Test-Path -LiteralPath $path)
}

function Require-Field {
    param(
        [string] $Label,
        [string] $FieldName,
        [string] $Value
    )

    if (Test-PlaceholderValue $Value) {
        $script:failures.Add("${Label}: required closure field '$FieldName' is missing or placeholder.")
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

$closureNotesChecked = 0
$reportsPath = $null
$wikiPath = $null
$indexContent = ""
$logContent = ""

if ($failures.Count -eq 0) {
    $reportsPath = Resolve-WorkspaceFile $workspacePath $ReportsDir
    $wikiPath = Resolve-WorkspaceFile $workspacePath $WikiDir

    if (-not (Test-Path -LiteralPath $reportsPath -PathType Container)) {
        $reviewFindings.Add("Reports directory does not exist: $ReportsDir")
    }
    else {
        $checksRun.Add("reports directory exists")
    }

    $indexPath = Join-Path $wikiPath "index.md"
    $logPath = Join-Path $wikiPath "log.md"

    if (Test-Path -LiteralPath $indexPath) {
        $indexContent = Get-Content -Raw -LiteralPath $indexPath
        $checksRun.Add("wiki index read")
    }
    else {
        $failures.Add("wiki/index.md is required for closure validation.")
    }

    if (Test-Path -LiteralPath $logPath) {
        $logContent = Get-Content -Raw -LiteralPath $logPath
        $checksRun.Add("wiki log read")
    }
    else {
        $failures.Add("wiki/log.md is required for closure validation.")
    }
}

if ($failures.Count -eq 0 -and (Test-Path -LiteralPath $reportsPath -PathType Container)) {
    $validationNotes = @(Get-ChildItem -LiteralPath $reportsPath -Recurse -Filter "*.md" -File | Where-Object {
        -not $_.Name.EndsWith(".template.md") -and (
            $_.FullName.ToLowerInvariant() -match "\\validation\\" -or
            $_.Name.ToLowerInvariant() -match "validation-note"
        )
    })

    if ($validationNotes.Count -eq 0) {
        $reviewFindings.Add("No validation notes found under reports/.")
    }

    foreach ($note in $validationNotes) {
        $closureNotesChecked += 1
        $label = Convert-ToWorkspaceRelativePath $workspacePath $note.FullName
        $content = Get-Content -Raw -LiteralPath $note.FullName

        $status = Normalize-Value (Get-FieldValue $content "Status")
        $closure = Normalize-Value (Get-FieldValue $content "Closure decision")
        $compareStatus = Normalize-Value (Get-FieldValue $content "Compare status")
        $compareReport = Get-FieldValue $content "Compare report"
        $reviewQueue = Get-FieldValue $content "Review queue"
        $roundCanClose = Get-FieldValue $content "Round can close"
        $advanceNormally = Get-FieldValue $content "Round can advance normally"
        $advanceWithReview = Get-FieldValue $content "Round can advance with review"
        $reason = Get-FieldValue $content "Reason"
        $nextAction = Get-FieldValue $content "Next round or next action"
        $compareSupports = Get-FieldValue $content "Compare report status supports closure"
        $reviewSupports = Get-FieldValue $content "Review queue status supports closure"
        $indexSupports = Get-FieldValue $content "Index status supports closure"
        $overviewSupports = Get-FieldValue $content "Overview status supports closure"
        $logSupports = Get-FieldValue $content "Wiki log status supports closure"
        $blockingReview = Get-FieldValue $content "Blocking review items"
        $blockingCarried = Get-FieldValue $content "Blocking carried-forward review"
        $nonblockingCarried = Get-FieldValue $content "Nonblocking carried-forward review"
        $carriedForwardReason = Get-FieldValue $content "Carried-forward reason and next action"

        Require-Field $label "Status" $status
        Require-Field $label "Closure decision" $closure
        Require-Field $label "Compare status" $compareStatus
        Require-Field $label "Reason" $reason
        Require-Field $label "Next round or next action" $nextAction

        if ($validStatuses -notcontains $status) {
            $failures.Add("${label}: Status must be pass/fail/needs-review.")
        }
        if ($validClosureDecisions -notcontains $closure) {
            $failures.Add("${label}: Closure decision must be close-pass/close-with-review/do-not-close.")
        }
        if ($validCompareStatuses -notcontains $compareStatus) {
            $failures.Add("${label}: Compare status has invalid value '$compareStatus'.")
        }
        if (-not (Test-RecordedPathExists $workspacePath $compareReport)) {
            $failures.Add("${label}: referenced compare report does not exist: $compareReport")
        }
        if (-not (Test-RecordedPathExists $workspacePath $reviewQueue)) {
            $failures.Add("${label}: referenced review queue does not exist: $reviewQueue")
        }

        if ($closure -eq "close-pass") {
            if ($status -ne "pass") {
                $failures.Add("${label}: close-pass requires Status pass.")
            }
            if ($compareStatus -ne "pass") {
                $failures.Add("${label}: close-pass requires Compare status pass.")
            }
            foreach ($pair in @(
                @("Round can close", $roundCanClose),
                @("Round can advance normally", $advanceNormally),
                @("Compare report status supports closure", $compareSupports),
                @("Review queue status supports closure", $reviewSupports),
                @("Index status supports closure", $indexSupports),
                @("Overview status supports closure", $overviewSupports),
                @("Wiki log status supports closure", $logSupports)
            )) {
                if (-not (Test-Yes $pair[1])) {
                    $failures.Add("${label}: close-pass requires '$($pair[0])' to be yes.")
                }
            }
            if (-not (Test-No $advanceWithReview)) {
                $reviewFindings.Add("${label}: close-pass should normally set 'Round can advance with review' to no.")
            }
            if (-not (Test-PlaceholderValue $blockingReview) -and (Normalize-Value $blockingReview) -notin @("none", "0", "no")) {
                $failures.Add("${label}: close-pass cannot have blocking review items.")
            }
            if (-not (Test-PlaceholderValue $blockingCarried) -and (Normalize-Value $blockingCarried) -notin @("none", "0", "no")) {
                $failures.Add("${label}: close-pass cannot have blocking carried-forward review.")
            }
        }
        elseif ($closure -eq "close-with-review") {
            if ($status -ne "needs-review") {
                $failures.Add("${label}: close-with-review requires Status needs-review.")
            }
            if ($compareStatus -ne "needs-review") {
                $failures.Add("${label}: close-with-review requires Compare status needs-review.")
            }
            if (-not (Test-Yes $roundCanClose)) {
                $failures.Add("${label}: close-with-review requires Round can close yes.")
            }
            if (-not (Test-Yes $advanceWithReview)) {
                $failures.Add("${label}: close-with-review requires Round can advance with review yes.")
            }
            if (Test-PlaceholderValue $nonblockingCarried -and Test-PlaceholderValue $carriedForwardReason) {
                $failures.Add("${label}: close-with-review requires carried-forward review reason and next action.")
            }
            if (-not (Test-PlaceholderValue $blockingCarried) -and (Normalize-Value $blockingCarried) -notin @("none", "0", "no")) {
                $failures.Add("${label}: close-with-review cannot carry blocking review as nonblocking closure.")
            }
            if ($compareReport -ne "" -and $indexContent -notmatch [regex]::Escape($compareReport)) {
                $reviewFindings.Add("${label}: close-with-review should keep active compare report discoverable from wiki/index.md.")
            }
            if ($reviewQueue -ne "" -and $indexContent -notmatch [regex]::Escape($reviewQueue)) {
                $reviewFindings.Add("${label}: close-with-review should keep active review queue discoverable from wiki/index.md.")
            }
        }
        elseif ($closure -eq "do-not-close") {
            if (Test-Yes $roundCanClose) {
                $failures.Add("${label}: do-not-close cannot set Round can close yes.")
            }
            if (Test-Yes $advanceNormally) {
                $failures.Add("${label}: do-not-close cannot set Round can advance normally yes.")
            }
        }

        if ($compareStatus -eq "compare gate not enabled" -and $closure -eq "close-pass") {
            $failures.Add("${label}: compare gate not enabled is not close-pass.")
        }

        if ($logContent -notmatch [regex]::Escape($closure)) {
            $reviewFindings.Add("${label}: wiki/log.md does not visibly record closure decision '$closure'.")
        }
    }

    $checksRun.Add("validation notes inspected")
}

$statusOut = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $statusOut = "fail"
    $exitCode = 1
    $nextActions.Add("Fix deterministic round closure failures and rerun round-closure-check.")
}
elseif ($reviewFindings.Count -gt 0) {
    $statusOut = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review closure findings before treating rounds as closed.")
}
else {
    $nextActions.Add("Proceed to fixtures or the next Phase 6 checker target.")
}

$checksRunText = Convert-TextList $checksRun
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions

$reportContent = @"
# Round Closure Check Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Reports directory: $ReportsDir
- Wiki directory: $WikiDir
- Started: $started
- Status: $statusOut
- Exit code: $exitCode
- Validation notes checked: $closureNotesChecked

## Checks Run

$checksRunText

## Failures

$failuresText

## Review Findings

$reviewText

## Warnings

$warningsText

## Next Actions

$nextActionsText

## Non-Goals

- Does not close rounds.
- Does not rewrite validation notes, reports, or wiki pages.
- Does not resolve review items.
- Does not decide semantic truth.
- Does not generate reports.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "round-closure-check: $statusOut (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

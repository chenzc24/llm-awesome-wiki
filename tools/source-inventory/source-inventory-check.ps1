param(
    [string] $Workspace = ".",
    [string] $Inventory = "raw/source-inventory.md",
    [string] $RawDir = "raw/sources",
    [string] $Report = "source-inventory-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "source-inventory-check"
$toolPhase = "Phase 6.3 source inventory validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]

$validStatuses = @("new", "ready", "processed", "changed", "ignored", "failed", "needs-review")
$validHashStates = @("pending", "not-hashable", "manifest")
$requiredColumns = @(
    "source_id",
    "raw_path",
    "source_kind",
    "raw_sha256",
    "added_at",
    "status",
    "packet_path",
    "review_required",
    "notes"
)

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

function Test-WorkspaceRelativePath {
    param(
        [string] $Path,
        [string] $RequiredPrefix
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $false
    }
    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $false
    }
    if ($Path.Contains("\")) {
        return $false
    }

    $parts = $Path -split "/"
    if ($parts -contains "..") {
        return $false
    }

    if (-not [string]::IsNullOrWhiteSpace($RequiredPrefix)) {
        if ($Path -ne $RequiredPrefix -and -not $Path.StartsWith("$RequiredPrefix/")) {
            return $false
        }
    }

    return $true
}

function Test-Sha256 {
    param([string] $Value)
    return ($Value -match "^[A-Fa-f0-9]{64}$")
}

function Convert-ReviewFlag {
    param([string] $Value)
    $normalized = $Value.Trim().ToLowerInvariant()
    if ($normalized -in @("yes", "true", "1")) {
        return $true
    }
    if ($normalized -in @("no", "false", "0", "")) {
        return $false
    }
    return $null
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

function Read-MarkdownTable {
    param([string] $Path)

    $lines = @(Get-Content -LiteralPath $Path)
    for ($i = 0; $i -lt ($lines.Count - 1); $i++) {
        if ($lines[$i].Trim().StartsWith("|") -and (Test-MarkdownSeparator $lines[$i + 1])) {
            $headers = @(Split-MarkdownRow $lines[$i])
            $rows = New-Object System.Collections.Generic.List[object]

            for ($j = $i + 2; $j -lt $lines.Count; $j++) {
                $line = $lines[$j]
                if (-not $line.Trim().StartsWith("|")) {
                    break
                }

                $cells = @(Split-MarkdownRow $line)
                if ($cells.Count -lt 1) {
                    continue
                }

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

            return [pscustomobject]@{
                Headers = $headers
                Rows = $rows
            }
        }
    }

    return [pscustomobject]@{
        Headers = @()
        Rows = @()
    }
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

$inventoryPath = $null
if ($failures.Count -eq 0) {
    if ([System.IO.Path]::IsPathRooted($Inventory)) {
        $inventoryPath = $Inventory
    }
    else {
        $inventoryPath = Resolve-WorkspaceFile $workspacePath $Inventory
    }

    if (-not (Test-Path -LiteralPath $inventoryPath)) {
        $templateInventory = Resolve-WorkspaceFile $workspacePath "raw/source-inventory.template.md"
        if ($Inventory -eq "raw/source-inventory.md" -and (Test-Path -LiteralPath $templateInventory)) {
            $inventoryPath = $templateInventory
            $reviewFindings.Add("Using template inventory because raw/source-inventory.md was not found: raw/source-inventory.template.md")
        }
        else {
            $failures.Add("Inventory file does not exist: $Inventory")
        }
    }
}

$rowsChecked = 0
if ($failures.Count -eq 0) {
    $checksRun.Add("inventory file exists")
    $table = Read-MarkdownTable $inventoryPath

    if ($table.Headers.Count -eq 0) {
        $failures.Add("Inventory file does not contain a Markdown table.")
    }
    else {
        $checksRun.Add("inventory Markdown table parsed")
        foreach ($required in $requiredColumns) {
            if ($table.Headers -notcontains $required) {
                $failures.Add("Inventory table is missing required column: $required")
            }
        }

        $seenIds = @{}
        foreach ($row in $table.Rows) {
            $rowsChecked += 1
            $line = Get-Cell $row "line_number"
            $sourceId = (Get-Cell $row "source_id").Trim()
            $rawPath = (Get-Cell $row "raw_path").Trim()
            $sourceKind = (Get-Cell $row "source_kind").Trim()
            $rawHash = (Get-Cell $row "raw_sha256").Trim()
            $status = (Get-Cell $row "status").Trim()
            $packetPath = (Get-Cell $row "packet_path").Trim()
            $reviewValue = (Get-Cell $row "review_required").Trim()
            $notes = (Get-Cell $row "notes").Trim()
            $label = if ($sourceId) { $sourceId } else { "line $line" }

            if ([string]::IsNullOrWhiteSpace($sourceId)) {
                $failures.Add("Inventory row $line has blank source_id.")
            }
            elseif ($seenIds.ContainsKey($sourceId)) {
                $failures.Add("Duplicate source_id '$sourceId' on line $line; first seen on line $($seenIds[$sourceId]).")
            }
            else {
                $seenIds[$sourceId] = $line
            }

            if ($sourceId -match "\\|^\s*/" -or $sourceId -cne $sourceId.ToLowerInvariant()) {
                $reviewFindings.Add("${label}: source_id should be stable, workspace-relative, and preferably lowercase ASCII.")
            }

            if (-not (Test-WorkspaceRelativePath $rawPath "raw/sources")) {
                $failures.Add("${label}: raw_path must be workspace-relative under raw/sources/: $rawPath")
            }
            else {
                $rawFilePath = Resolve-WorkspaceFile $workspacePath $rawPath
                if ($status -ne "ignored" -and -not (Test-Path -LiteralPath $rawFilePath)) {
                    $failures.Add("${label}: raw_path does not exist: $rawPath")
                }
            }

            if ([string]::IsNullOrWhiteSpace($sourceKind)) {
                $failures.Add("${label}: source_kind is blank.")
            }

            if ($validStatuses -notcontains $status) {
                $failures.Add("${label}: unknown status '$status'.")
            }

            $reviewFlag = Convert-ReviewFlag $reviewValue
            if ($null -eq $reviewFlag) {
                $failures.Add("${label}: review_required must be yes/no/true/false, got '$reviewValue'.")
            }

            if ([string]::IsNullOrWhiteSpace($rawHash)) {
                $reviewFindings.Add("${label}: raw_sha256 is blank.")
            }
            elseif (-not (Test-Sha256 $rawHash) -and $validHashStates -notcontains $rawHash) {
                $failures.Add("${label}: raw_sha256 must be SHA-256 or one of pending/not-hashable/manifest, got '$rawHash'.")
            }
            elseif ($rawHash -eq "pending" -and $status -in @("ready", "processed")) {
                $reviewFindings.Add("${label}: status '$status' still has raw_sha256 pending.")
            }

            if ((Test-Sha256 $rawHash) -and (Test-WorkspaceRelativePath $rawPath "raw/sources")) {
                $rawFilePath = Resolve-WorkspaceFile $workspacePath $rawPath
                if ((Test-Path -LiteralPath $rawFilePath) -and -not (Get-Item -LiteralPath $rawFilePath).PSIsContainer) {
                    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $rawFilePath).Hash.ToLowerInvariant()
                    if ($actualHash -ne $rawHash.ToLowerInvariant()) {
                        $failures.Add("${label}: raw_sha256 mismatch for $rawPath.")
                    }
                }
            }

            if ($status -eq "processed" -and [string]::IsNullOrWhiteSpace($packetPath)) {
                $failures.Add("${label}: processed row must have packet_path.")
            }

            if (-not [string]::IsNullOrWhiteSpace($packetPath)) {
                if (-not (Test-WorkspaceRelativePath $packetPath "raw/derived")) {
                    $failures.Add("${label}: packet_path must be workspace-relative under raw/derived/: $packetPath")
                }
                elseif ($status -eq "processed") {
                    $packetFilePath = Resolve-WorkspaceFile $workspacePath $packetPath
                    if (-not (Test-Path -LiteralPath $packetFilePath)) {
                        $failures.Add("${label}: processed packet_path does not exist: $packetPath")
                    }
                }
            }

            if ($status -in @("failed", "needs-review")) {
                if ($reviewFlag -ne $true) {
                    $failures.Add("${label}: status '$status' must set review_required to yes/true.")
                }
                if ([string]::IsNullOrWhiteSpace($notes)) {
                    $reviewFindings.Add("${label}: status '$status' should explain review reason in notes.")
                }
            }

            if ($sourceKind -eq "unknown" -and $reviewFlag -ne $true) {
                $reviewFindings.Add("${label}: unknown source_kind should require review.")
            }
        }
    }
}

$status = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $status = "fail"
    $exitCode = 1
    $nextActions.Add("Fix deterministic inventory failures and rerun source-inventory-check.")
}
elseif ($reviewFindings.Count -gt 0) {
    $status = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review inventory findings before treating intake as complete.")
}
else {
    $nextActions.Add("Proceed to source packet lint or the next workspace validation step.")
}

$checksRunText = Convert-TextList $checksRun
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions

$reportContent = @"
# Source Inventory Check Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Inventory: $inventoryPath
- Raw directory: $RawDir
- Started: $started
- Status: $status
- Exit code: $exitCode
- Rows checked: $rowsChecked

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

- Does not parse raw document content.
- Does not write source packets.
- Does not run extractors, OCR, VLM, MinerU, or MCP adapters.
- Does not generate wiki pages.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "source-inventory-check: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

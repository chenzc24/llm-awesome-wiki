param(
    [string] $Workspace = ".",
    [ValidateSet("smoke", "all", "schemas", "source", "wiki", "reports", "closure", "fixtures")]
    [string] $Mode = "smoke",
    [string] $Report = "workspace-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "workspace-check"
$toolPhase = "Phase 6.5 runtime with schema, source, wiki, and report checks"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$checksNotImplemented = New-Object System.Collections.Generic.List[string]
$findings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]
$status = "pass"
$exitCode = 0

$reportPath = $Report
if (-not [System.IO.Path]::IsPathRooted($reportPath)) {
    $reportPath = Join-Path (Get-Location).Path $reportPath
}

$reportDir = Split-Path -Parent $reportPath
if ($reportDir -and -not (Test-Path -LiteralPath $reportDir)) {
    New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
}

function Add-NotImplemented {
    param([string] $CheckName)
    $checksNotImplemented.Add($CheckName)
}

function Merge-ChildResult {
    param(
        [string] $CheckName,
        [int] $ChildExitCode,
        [string] $ChildReportPath
    )

    $checksRun.Add($CheckName)

    if ($ChildExitCode -eq 0) {
        $findings.Add("$CheckName passed. Report: $ChildReportPath")
    }
    elseif ($ChildExitCode -eq 1) {
        if ($exitCode -ne 3) {
            $script:status = "fail"
            $script:exitCode = 1
        }
        $findings.Add("$CheckName failed. Report: $ChildReportPath")
    }
    elseif ($ChildExitCode -eq 2) {
        if ($exitCode -eq 0) {
            $script:status = "needs-review"
            $script:exitCode = 2
        }
        $findings.Add("$CheckName needs review. Report: $ChildReportPath")
    }
    else {
        $script:status = "error"
        $script:exitCode = 3
        $findings.Add("$CheckName runtime error. Report: $ChildReportPath")
    }
}

try {
    $workspacePath = (Resolve-Path -LiteralPath $Workspace).Path
    $checksRun.Add("workspace path exists")
}
catch {
    $workspacePath = $Workspace
    $status = "error"
    $exitCode = 3
    $findings.Add("Workspace path does not exist: $Workspace")
}

if ($exitCode -eq 0) {
    if ($Mode -in @("schemas", "all")) {
        $schemaScript = Join-Path $PSScriptRoot "..\schema-check\schema-check.ps1"
        $schemaReportPath = Join-Path $reportDir "schema-check-report.md"

        if (-not (Test-Path -LiteralPath $schemaScript)) {
            $status = "error"
            $exitCode = 3
            $findings.Add("Missing schema-check script: $schemaScript")
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $schemaScript -Workspace $workspacePath -Report $schemaReportPath | Out-Host
            $schemaExitCode = $LASTEXITCODE
            Merge-ChildResult "schema and structured-field validation" $schemaExitCode $schemaReportPath
        }
    }

    if ($Mode -in @("source", "all")) {
        $inventoryScript = Join-Path $PSScriptRoot "..\source-inventory\source-inventory-check.ps1"
        $packetScript = Join-Path $PSScriptRoot "..\source-packet-lint\source-packet-lint.ps1"
        $inventoryReportPath = Join-Path $reportDir "source-inventory-check-report.md"
        $packetReportPath = Join-Path $reportDir "source-packet-lint-report.md"

        if (-not (Test-Path -LiteralPath $inventoryScript)) {
            $status = "error"
            $exitCode = 3
            $findings.Add("Missing source-inventory-check script: $inventoryScript")
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $inventoryScript -Workspace $workspacePath -Report $inventoryReportPath | Out-Host
            $inventoryExitCode = $LASTEXITCODE
            Merge-ChildResult "source inventory check" $inventoryExitCode $inventoryReportPath
        }

        if (-not (Test-Path -LiteralPath $packetScript)) {
            $status = "error"
            $exitCode = 3
            $findings.Add("Missing source-packet-lint script: $packetScript")
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $packetScript -Workspace $workspacePath -Report $packetReportPath | Out-Host
            $packetExitCode = $LASTEXITCODE
            Merge-ChildResult "source packet lint" $packetExitCode $packetReportPath
        }
    }

    if ($Mode -in @("wiki", "all")) {
        $wikiLintScript = Join-Path $PSScriptRoot "..\wiki-lint\wiki-lint.ps1"
        $wikiLintReportPath = Join-Path $reportDir "wiki-lint-report.md"

        if (-not (Test-Path -LiteralPath $wikiLintScript)) {
            $status = "error"
            $exitCode = 3
            $findings.Add("Missing wiki-lint script: $wikiLintScript")
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $wikiLintScript -Workspace $workspacePath -Report $wikiLintReportPath | Out-Host
            $wikiLintExitCode = $LASTEXITCODE
            Merge-ChildResult "wiki lint and navigation validation" $wikiLintExitCode $wikiLintReportPath
        }
    }

    if ($Mode -in @("reports", "all")) {
        $reportCheckScript = Join-Path $PSScriptRoot "..\report-check\report-check.ps1"
        $reportCheckReportPath = Join-Path $reportDir "report-check-report.md"

        if (-not (Test-Path -LiteralPath $reportCheckScript)) {
            $status = "error"
            $exitCode = 3
            $findings.Add("Missing report-check script: $reportCheckScript")
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $reportCheckScript -Workspace $workspacePath -Report $reportCheckReportPath | Out-Host
            $reportCheckExitCode = $LASTEXITCODE
            Merge-ChildResult "report surface validation" $reportCheckExitCode $reportCheckReportPath
        }
    }

    if ($Mode -eq "smoke") {
        Add-NotImplemented "round closure check"
        Add-NotImplemented "fixture runner"
        $nextActions.Add("Run workspace-check with -Mode schemas or -Mode source for implemented Phase 6 validators.")
    }
    elseif ($Mode -eq "all") {
        Add-NotImplemented "round closure check"
        Add-NotImplemented "fixture runner"
    }
    elseif ($Mode -notin @("schemas", "source", "wiki", "reports")) {
        Add-NotImplemented "$Mode check"
    }

    if ($exitCode -eq 0 -and $Mode -ne "smoke" -and $checksNotImplemented.Count -gt 0) {
        $status = "needs-review"
        $exitCode = 2
        $findings.Add("Requested mode includes checks that are not implemented yet.")
    }

    if ($exitCode -eq 0) {
        $nextActions.Add("Proceed to the next Phase 6 checker target.")
    }
    elseif ($exitCode -eq 2) {
        $nextActions.Add("Review not-implemented checks before treating the workspace as fully validated.")
    }
}
else {
    $nextActions.Add("Fix configuration or runtime error and rerun workspace-check.")
}

$checksRunText = if ($checksRun.Count -gt 0) {
    ($checksRun | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$checksNotImplementedText = if ($checksNotImplemented.Count -gt 0) {
    ($checksNotImplemented | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$findingsText = if ($findings.Count -gt 0) {
    ($findings | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$nextActionsText = if ($nextActions.Count -gt 0) {
    ($nextActions | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$reportContent = @"
# Workspace Check Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Mode: $Mode
- Started: $started
- Status: $status
- Exit code: $exitCode

## Checks Run

$checksRunText

## Checks Not Implemented

$checksNotImplementedText

## Findings

$findingsText

## Next Actions

$nextActionsText

## Non-Goals

- Does not run extractors.
- Does not parse raw binary documents.
- Does not generate source packets or wiki pages.
- Does not resolve semantic review.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "workspace-check: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

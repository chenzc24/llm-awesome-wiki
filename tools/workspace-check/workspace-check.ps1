param(
    [string] $Workspace = ".",
    [ValidateSet("smoke", "all", "schemas", "source", "wiki", "reports", "closure", "fixtures")]
    [string] $Mode = "smoke",
    [string] $Report = "workspace-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "workspace-check"
$toolPhase = "Phase 6.1 runtime skeleton"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$checksNotImplemented = New-Object System.Collections.Generic.List[string]
$findings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]
$status = "pass"
$exitCode = 0

function Add-NotImplemented {
    param([string] $CheckName)
    $checksNotImplemented.Add($CheckName)
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
    Add-NotImplemented "schema and structured-field validation"
    Add-NotImplemented "source inventory check"
    Add-NotImplemented "source packet check"
    Add-NotImplemented "wiki lint"
    Add-NotImplemented "claim audit"
    Add-NotImplemented "compare report check"
    Add-NotImplemented "review queue check"
    Add-NotImplemented "round closure check"
    Add-NotImplemented "fixture runner"
    $nextActions.Add("Implement Phase 6.2 schema and structured-field validation.")
}
else {
    $nextActions.Add("Fix configuration or runtime error and rerun workspace-check.")
}

$reportPath = $Report
if (-not [System.IO.Path]::IsPathRooted($reportPath)) {
    $reportPath = Join-Path (Get-Location).Path $reportPath
}

$reportDir = Split-Path -Parent $reportPath
if ($reportDir -and -not (Test-Path -LiteralPath $reportDir)) {
    New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
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

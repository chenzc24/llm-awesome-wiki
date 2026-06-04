param(
    [string] $Workspace = ".",
    [ValidateSet("smoke", "all", "schemas", "source", "wiki", "reports", "closure", "fixtures")]
    [string] $Mode = "smoke",
    [string] $Report = "workspace-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "workspace-check"
$toolPhase = "Phase 6.2 runtime with schema-check integration"
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
            $checksRun.Add("schema and structured-field validation")

            if ($schemaExitCode -eq 0) {
                $findings.Add("Schema check passed. Report: $schemaReportPath")
            }
            elseif ($schemaExitCode -eq 1) {
                $status = "fail"
                $exitCode = 1
                $findings.Add("Schema check failed. Report: $schemaReportPath")
            }
            elseif ($schemaExitCode -eq 2) {
                if ($exitCode -eq 0) {
                    $status = "needs-review"
                    $exitCode = 2
                }
                $findings.Add("Schema check needs review. Report: $schemaReportPath")
            }
            else {
                $status = "error"
                $exitCode = 3
                $findings.Add("Schema check runtime error. Report: $schemaReportPath")
            }
        }
    }

    if ($Mode -eq "smoke") {
        Add-NotImplemented "schema and structured-field validation"
        Add-NotImplemented "source inventory check"
        Add-NotImplemented "source packet check"
        Add-NotImplemented "wiki lint"
        Add-NotImplemented "claim audit"
        Add-NotImplemented "compare report check"
        Add-NotImplemented "review queue check"
        Add-NotImplemented "round closure check"
        Add-NotImplemented "fixture runner"
        $nextActions.Add("Run workspace-check with -Mode schemas for Phase 6.2 validation.")
    }
    elseif ($Mode -eq "all") {
        Add-NotImplemented "source inventory check"
        Add-NotImplemented "source packet check"
        Add-NotImplemented "wiki lint"
        Add-NotImplemented "claim audit"
        Add-NotImplemented "compare report check"
        Add-NotImplemented "review queue check"
        Add-NotImplemented "round closure check"
        Add-NotImplemented "fixture runner"
    }
    elseif ($Mode -ne "schemas") {
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

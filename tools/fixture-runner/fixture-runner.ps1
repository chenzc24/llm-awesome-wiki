param(
    [string] $FixtureRoot = "tests/fixtures/phase6",
    [string] $Report = "fixture-runner-report.md",
    [switch] $KeepTemp
)

$ErrorActionPreference = "Stop"

$toolName = "fixture-runner"
$toolPhase = "Phase 6.7 scenario fixture validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]
$scenarioResults = New-Object System.Collections.Generic.List[string]

$toolScripts = @{
    "wiki-lint" = "tools/wiki-lint/wiki-lint.ps1"
    "report-check" = "tools/report-check/report-check.ps1"
    "round-closure-check" = "tools/round-closure-check/round-closure-check.ps1"
    "workspace-check" = "tools/workspace-check/workspace-check.ps1"
}

function Resolve-RepoFile {
    param([string] $RelativePath)
    if ([System.IO.Path]::IsPathRooted($RelativePath)) {
        return $RelativePath
    }
    return (Join-Path (Get-Location).Path ($RelativePath -replace "/", [System.IO.Path]::DirectorySeparatorChar))
}

function Resolve-ReportPath {
    param([string] $Path)
    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }
    return (Join-Path (Get-Location).Path $Path)
}

function Convert-TextList {
    param([System.Collections.IEnumerable] $Items)

    $list = @($Items)
    if ($list.Count -eq 0) {
        return "- none"
    }
    return (($list | ForEach-Object { "- $_" }) -join [Environment]::NewLine)
}

function Get-ReportStatus {
    param([string] $Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return ""
    }
    $content = Get-Content -Raw -LiteralPath $Path
    $match = [regex]::Match($content, "(?im)^-\s*Status\s*:\s*(.+?)\s*$")
    if ($match.Success) {
        return $match.Groups[1].Value.Trim().ToLowerInvariant()
    }
    return ""
}

function Remove-TempDirectorySafely {
    param([string] $Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return
    }
    $resolved = (Resolve-Path -LiteralPath $Path).Path
    $tempPrefix = ([System.IO.Path]::GetTempPath()).TrimEnd([System.IO.Path]::DirectorySeparatorChar)
    if (-not $resolved.StartsWith($tempPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove fixture temp directory outside OS temp: $resolved"
    }
    Remove-Item -LiteralPath $resolved -Recurse -Force
}

$reportPath = Resolve-ReportPath $Report
$reportDir = Split-Path -Parent $reportPath
if ($reportDir -and -not (Test-Path -LiteralPath $reportDir)) {
    New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
}

$fixtureRootPath = Resolve-RepoFile $FixtureRoot
if (-not (Test-Path -LiteralPath $fixtureRootPath -PathType Container)) {
    $failures.Add("Fixture root does not exist: $FixtureRoot")
}
else {
    $checksRun.Add("fixture root exists")
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("llm-awesome-wiki-fixtures-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
$scenariosRun = 0

try {
    if ($failures.Count -eq 0) {
        $scenarioFiles = @(Get-ChildItem -LiteralPath $fixtureRootPath -Recurse -Filter "scenario.json" -File)
        if ($scenarioFiles.Count -eq 0) {
            $failures.Add("No scenario.json files found under $FixtureRoot.")
        }

        foreach ($scenarioFile in $scenarioFiles) {
            $scenario = Get-Content -Raw -LiteralPath $scenarioFile.FullName | ConvertFrom-Json
            $name = [string]$scenario.name
            $tool = [string]$scenario.tool
            $mode = [string]$scenario.mode
            $expectedExit = [int]$scenario.expected_exit_code
            $expectedStatus = ([string]$scenario.expected_status).ToLowerInvariant()
            $scenarioDir = Split-Path -Parent $scenarioFile.FullName
            $workspaceSource = Join-Path $scenarioDir "workspace"
            $scenarioTemp = Join-Path $tempRoot $name
            $scenarioReport = Join-Path $tempRoot "$name-report.md"

            $scenariosRun += 1

            if ([string]::IsNullOrWhiteSpace($name)) {
                $failures.Add("$($scenarioFile.FullName): scenario name is required.")
                continue
            }
            if (-not $toolScripts.ContainsKey($tool)) {
                $failures.Add("${name}: unknown tool '$tool'.")
                continue
            }
            if (-not (Test-Path -LiteralPath $workspaceSource -PathType Container)) {
                $failures.Add("${name}: workspace directory is missing.")
                continue
            }

            Copy-Item -LiteralPath $workspaceSource -Destination $scenarioTemp -Recurse -Force
            $scriptPath = Resolve-RepoFile $toolScripts[$tool]
            if (-not (Test-Path -LiteralPath $scriptPath)) {
                $failures.Add("${name}: tool script does not exist: $scriptPath")
                continue
            }

            if ($tool -eq "workspace-check") {
                if ([string]::IsNullOrWhiteSpace($mode)) {
                    $failures.Add("${name}: workspace-check scenarios must set mode.")
                    continue
                }
                & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -Workspace $scenarioTemp -Mode $mode -Report $scenarioReport | Out-Host
            }
            else {
                & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -Workspace $scenarioTemp -Report $scenarioReport | Out-Host
            }

            $actualExit = $LASTEXITCODE
            $actualStatus = Get-ReportStatus $scenarioReport
            $result = "pass"

            if ($actualExit -ne $expectedExit) {
                $result = "fail"
                $failures.Add("${name}: expected exit $expectedExit but got $actualExit.")
            }
            if ($actualStatus -ne $expectedStatus) {
                $result = "fail"
                $failures.Add("${name}: expected status '$expectedStatus' but got '$actualStatus'.")
            }

            $scenarioResults.Add("| $name | $tool | $expectedExit | $actualExit | $expectedStatus | $actualStatus | $result |")
        }

        $checksRun.Add("scenario files executed")
    }
}
finally {
    if (-not $KeepTemp) {
        Remove-TempDirectorySafely $tempRoot
    }
}

$status = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $status = "fail"
    $exitCode = 1
    $nextActions.Add("Fix failing fixture scenarios and rerun fixture-runner.")
}
elseif ($reviewFindings.Count -gt 0) {
    $status = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review fixture-runner findings before treating fixtures as complete.")
}
else {
    $nextActions.Add("Proceed to Phase 6 closure review.")
}

$checksRunText = Convert-TextList $checksRun
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions
$scenarioTableText = if ($scenarioResults.Count -gt 0) {
    "| scenario | tool | expected_exit | actual_exit | expected_status | actual_status | result |" + [Environment]::NewLine +
    "| --- | --- | --- | --- | --- | --- | --- |" + [Environment]::NewLine +
    (($scenarioResults | ForEach-Object { $_ }) -join [Environment]::NewLine)
}
else {
    "No scenarios executed."
}

$reportContent = @"
# Fixture Runner Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Fixture root: $fixtureRootPath
- Started: $started
- Status: $status
- Exit code: $exitCode
- Scenarios run: $scenariosRun

## Scenario Results

$scenarioTableText

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

- Does not run extractors.
- Does not parse raw binary documents.
- Does not resolve semantic review.
- Does not generate source packets or wiki pages.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "fixture-runner: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

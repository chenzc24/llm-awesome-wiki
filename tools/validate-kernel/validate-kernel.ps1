$ErrorActionPreference = "Stop"

$root = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$failures = New-Object System.Collections.Generic.List[string]

function Require-Path {
    param([string] $RelativePath)

    $path = Join-Path $root $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        $failures.Add("Missing required path: $RelativePath")
    }
}

function Reject-RootPath {
    param([string] $RelativePath)

    $path = Join-Path $root $RelativePath
    if (Test-Path -LiteralPath $path) {
        $failures.Add("Root repository must not contain active workspace path: $RelativePath")
    }
}

$requiredPaths = @(
    "README.md",
    "AGENTS.md",
    "docs\top-level-design\system-architecture-plan.md",
    "docs\phase-plans\phase-1-workspace-kernel.md",
    "docs\phase-plans\phase-1.1-workspace-kernel-closure.md",
    "docs\phase-plans\phase-1.2-document-corpus-default.md",
    "docs\phase-plans\phase-1.3-workspace-kernel-golden-path.md",
    "rules\raw-to-source-packet.md",
    "rules\source-packet-to-wiki.md",
    "rules\wiki-index-contract.md",
    "rules\compare-gate-contract.md",
    "rules\distillation-rounds.md",
    "rules\maintenance-workflow.md",
    "contracts\schemas\source-inventory.schema.json",
    "contracts\schemas\source-packet.schema.json",
    "contracts\schemas\evidence-record.schema.json",
    "contracts\schemas\claim-record.schema.json",
    "contracts\schemas\wiki-page.schema.json",
    "contracts\schemas\wiki-index.schema.json",
    "contracts\schemas\compare-report.schema.json",
    "contracts\schemas\review-item.schema.json",
    "templates\workspace-kernel\AGENTS.md",
    "templates\workspace-kernel\README.md",
    "templates\workspace-kernel\purpose.md",
    "templates\workspace-kernel\schema.md",
    "templates\workspace-kernel\plan\README.md",
    "templates\workspace-kernel\plan\log.md",
    "templates\workspace-kernel\plan\first-round-plan.template.md",
    "templates\workspace-kernel\raw\README.md",
    "templates\workspace-kernel\raw\source-inventory.template.md",
    "templates\workspace-kernel\raw\source-packet.template.md",
    "templates\workspace-kernel\raw\sources",
    "templates\workspace-kernel\raw\sources\README.md",
    "templates\workspace-kernel\raw\derived",
    "templates\workspace-kernel\raw\derived\README.md",
    "templates\workspace-kernel\wiki\index.md",
    "templates\workspace-kernel\wiki\overview.md",
    "templates\workspace-kernel\wiki\overview.template.md",
    "templates\workspace-kernel\wiki\log.md",
    "templates\workspace-kernel\wiki\sources\README.md",
    "templates\workspace-kernel\wiki\sources\source-page.template.md",
    "templates\workspace-kernel\wiki\chapters\README.md",
    "templates\workspace-kernel\wiki\chapters\chapter-page.template.md",
    "templates\workspace-kernel\reports",
    "templates\workspace-kernel\reports\README.md",
    "templates\workspace-kernel\reports\first-round-validation-note.template.md",
    "templates\workspace-kernel\tools\README.md",
    "templates\workspace-kernel\contracts\README.md",
    "tools\validate-kernel\README.md",
    "tools\shared\README.md",
    "tools\shared\report-conventions.md",
    "tools\workspace-check\README.md",
    "tools\workspace-check\workspace-check.ps1",
    "tools\schema-check\README.md",
    "tools\schema-check\schema-check.ps1",
    "tools\source-inventory\README.md",
    "tools\wiki-lint\README.md",
    "tools\compare-gate\README.md",
    "tools\claim-audit\README.md",
    "tools\scaffold-workspace\README.md",
    "tests\README.md",
    "tests\fixtures\README.md"
)

foreach ($relativePath in $requiredPaths) {
    Require-Path $relativePath
}

foreach ($rootOnlyPath in @("raw", "wiki", "reports", "schema.md", "schemas")) {
    Reject-RootPath $rootOnlyPath
}

$schemaDir = Join-Path $root "contracts\schemas"
if (Test-Path -LiteralPath $schemaDir) {
    $schemaFiles = Get-ChildItem -LiteralPath $schemaDir -Filter "*.schema.json"
    if ($schemaFiles.Count -lt 8) {
        $failures.Add("Expected at least 8 schema files under contracts/schemas.")
    }

    foreach ($schemaFile in $schemaFiles) {
        try {
            Get-Content -LiteralPath $schemaFile.FullName -Raw | ConvertFrom-Json | Out-Null
        }
        catch {
            $failures.Add("Invalid JSON schema: $($schemaFile.FullName)")
        }
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Error $failure
    }
    exit 1
}

Write-Host "validate-kernel: OK"

param(
    [string] $Workspace = ".",
    [string] $SchemaDir = "contracts/schemas",
    [string] $Report = "schema-check-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "schema-check"
$toolPhase = "Phase 6.2 schema and structured-field validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checked = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]
$status = "pass"
$exitCode = 0

$requiredSchemaFiles = @(
    "source-inventory.schema.json",
    "source-packet.schema.json",
    "evidence-record.schema.json",
    "claim-record.schema.json",
    "wiki-page.schema.json",
    "wiki-index.schema.json",
    "compare-report.schema.json",
    "review-item.schema.json"
)

function Get-PropertyValue {
    param(
        [object] $Object,
        [string] $Name
    )

    if ($null -eq $Object) {
        return $null
    }

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }

    return $property.Value
}

function Get-JsonPath {
    param(
        [object] $Object,
        [string] $Path
    )

    $current = $Object
    foreach ($segment in $Path.Split(".")) {
        $current = Get-PropertyValue -Object $current -Name $segment
        if ($null -eq $current) {
            return $null
        }
    }

    return $current
}

function Require-JsonPath {
    param(
        [object] $Schema,
        [string] $SchemaName,
        [string] $Path
    )

    $value = Get-JsonPath -Object $Schema -Path $Path
    if ($null -eq $value) {
        $failures.Add("$SchemaName missing required JSON path: $Path")
    }
}

function Require-EnumValues {
    param(
        [object] $Schema,
        [string] $SchemaName,
        [string] $Path,
        [string[]] $ExpectedValues
    )

    $enumValues = Get-JsonPath -Object $Schema -Path $Path
    if ($null -eq $enumValues) {
        $failures.Add("$SchemaName missing enum path: $Path")
        return
    }

    foreach ($expectedValue in $ExpectedValues) {
        if ($enumValues -notcontains $expectedValue) {
            $failures.Add("$SchemaName enum $Path missing value: $expectedValue")
        }
    }
}

function Require-ObjectProperties {
    param(
        [object] $Schema,
        [string] $SchemaName,
        [string] $Path,
        [string[]] $PropertyNames
    )

    $properties = Get-JsonPath -Object $Schema -Path $Path
    if ($null -eq $properties) {
        $failures.Add("$SchemaName missing properties path: $Path")
        return
    }

    foreach ($propertyName in $PropertyNames) {
        if ($null -eq (Get-PropertyValue -Object $properties -Name $propertyName)) {
            $failures.Add("$SchemaName missing property $propertyName at $Path")
        }
    }
}

try {
    $workspacePath = (Resolve-Path -LiteralPath $Workspace).Path
}
catch {
    $status = "error"
    $exitCode = 3
    $workspacePath = $Workspace
    $failures.Add("Workspace path does not exist: $Workspace")
}

$schemas = @{}

if ($exitCode -eq 0) {
    $schemaPath = Join-Path $workspacePath $SchemaDir
    if (-not (Test-Path -LiteralPath $schemaPath)) {
        $status = "fail"
        $exitCode = 1
        $failures.Add("Missing schema directory: $SchemaDir")
    }
    else {
        foreach ($schemaFileName in $requiredSchemaFiles) {
            $schemaFilePath = Join-Path $schemaPath $schemaFileName
            if (-not (Test-Path -LiteralPath $schemaFilePath)) {
                $failures.Add("Missing required schema file: $schemaFileName")
                continue
            }

            try {
                $schema = Get-Content -LiteralPath $schemaFilePath -Raw | ConvertFrom-Json
                $schemas[$schemaFileName] = $schema
                $checked.Add($schemaFileName)

                foreach ($metadataPath in @('$schema', '$id', 'title', 'type', 'properties')) {
                    Require-JsonPath -Schema $schema -SchemaName $schemaFileName -Path $metadataPath
                }
            }
            catch {
                $failures.Add("Invalid JSON schema file: $schemaFileName")
            }
        }
    }
}

if ($schemas.ContainsKey("source-inventory.schema.json")) {
    $schema = $schemas["source-inventory.schema.json"]
    Require-ObjectProperties -Schema $schema -SchemaName "source-inventory.schema.json" -Path "properties.sources.items.properties" -PropertyNames @(
        "source_id",
        "raw_path",
        "source_kind",
        "raw_sha256",
        "status",
        "packet_path",
        "review_required",
        "notes"
    )
    Require-EnumValues -Schema $schema -SchemaName "source-inventory.schema.json" -Path "properties.sources.items.properties.status.enum" -ExpectedValues @(
        "new",
        "ready",
        "processed",
        "changed",
        "ignored",
        "failed",
        "needs-review"
    )
}

if ($schemas.ContainsKey("source-packet.schema.json")) {
    $schema = $schemas["source-packet.schema.json"]
    Require-ObjectProperties -Schema $schema -SchemaName "source-packet.schema.json" -Path "properties" -PropertyNames @(
        "source_id",
        "raw_path",
        "raw_sha256",
        "source_kind",
        "inventory_status_at_extraction",
        "extraction_backend",
        "extraction_method",
        "extraction_version",
        "extraction_status",
        "modalities",
        "generated_fields",
        "known_gaps",
        "review_required",
        "review_reason",
        "derived_artifacts",
        "anchors"
    )
    Require-EnumValues -Schema $schema -SchemaName "source-packet.schema.json" -Path "properties.extraction_status.enum" -ExpectedValues @(
        "complete",
        "partial",
        "failed",
        "manual-review"
    )
}

if ($schemas.ContainsKey("claim-record.schema.json")) {
    $schema = $schemas["claim-record.schema.json"]
    Require-EnumValues -Schema $schema -SchemaName "claim-record.schema.json" -Path "properties.status.enum" -ExpectedValues @(
        "supported",
        "weak",
        "unsupported",
        "contested",
        "generated-derived",
        "reviewed-generated",
        "needs-review",
        "not-in-scope",
        "stale"
    )
}

if ($schemas.ContainsKey("compare-report.schema.json")) {
    $schema = $schemas["compare-report.schema.json"]
    Require-EnumValues -Schema $schema -SchemaName "compare-report.schema.json" -Path "properties.status.enum" -ExpectedValues @(
        "pass",
        "fail",
        "needs-review"
    )
    Require-EnumValues -Schema $schema -SchemaName "compare-report.schema.json" -Path "properties.checks.items.properties.status.enum" -ExpectedValues @(
        "pass",
        "fail",
        "needs-review",
        "not-enabled"
    )
}

if ($schemas.ContainsKey("review-item.schema.json")) {
    $schema = $schemas["review-item.schema.json"]
    Require-EnumValues -Schema $schema -SchemaName "review-item.schema.json" -Path "properties.status.enum" -ExpectedValues @(
        "open",
        "in-review",
        "resolved",
        "dismissed",
        "carried-forward",
        "blocked",
        "stale"
    )
    Require-EnumValues -Schema $schema -SchemaName "review-item.schema.json" -Path "properties.blocking_level.enum" -ExpectedValues @(
        "blocking",
        "nonblocking",
        "informational"
    )
}

if ($failures.Count -gt 0 -and $exitCode -eq 0) {
    $status = "fail"
    $exitCode = 1
}

if ($failures.Count -eq 0) {
    $nextActions.Add("Proceed to Phase 6.3 source inventory and source packet checks.")
}
else {
    $nextActions.Add("Fix schema structure or enum mismatches and rerun schema-check.")
}

$reportPath = $Report
if (-not [System.IO.Path]::IsPathRooted($reportPath)) {
    $reportPath = Join-Path (Get-Location).Path $reportPath
}

$reportDir = Split-Path -Parent $reportPath
if ($reportDir -and -not (Test-Path -LiteralPath $reportDir)) {
    New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
}

$checkedText = if ($checked.Count -gt 0) {
    ($checked | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$findingsText = if ($failures.Count -gt 0) {
    ($failures | ForEach-Object { "- $_" }) -join [Environment]::NewLine
}
else {
    "- none"
}

$nextActionsText = ($nextActions | ForEach-Object { "- $_" }) -join [Environment]::NewLine

$reportContent = @"
# Schema Check Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Schema directory: $SchemaDir
- Started: $started
- Status: $status
- Exit code: $exitCode

## Schema Files Checked

$checkedText

## Findings

$findingsText

## Next Actions

$nextActionsText

## Non-Goals

- Not a JSON Schema engine.
- Does not validate workspace instances.
- Does not run extractors.
- Does not parse raw binary documents.
- Does not generate source packets or wiki pages.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "schema-check: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

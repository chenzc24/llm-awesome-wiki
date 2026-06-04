param(
    [string] $Workspace = ".",
    [string] $Inventory = "raw/source-inventory.md",
    [string] $Packet = "",
    [string] $Report = "source-packet-lint-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "source-packet-lint"
$toolPhase = "Phase 6.3 source packet validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]

$validExtractionStatuses = @("complete", "partial", "failed", "manual-review")
$validHashStates = @("pending", "not-hashable", "manifest")
$requiredMetadataFields = @(
    "type",
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
    "derived_artifacts"
)
$requiredAnchorColumns = @(
    "anchor_id",
    "location",
    "content_kind",
    "label",
    "source_derived",
    "generated",
    "media_ref",
    "review_required"
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
    if (($Path -split "/") -contains "..") {
        return $false
    }
    if (-not [string]::IsNullOrWhiteSpace($RequiredPrefix)) {
        if ($Path -ne $RequiredPrefix -and -not $Path.StartsWith("$RequiredPrefix/")) {
            return $false
        }
    }
    return $true
}

function Test-SafeRelativePath {
    param([string] $Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $false
    }
    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $false
    }
    if ($Path.Contains("\")) {
        return $false
    }
    if (($Path -split "/") -contains "..") {
        return $false
    }
    return $true
}

function Test-Sha256 {
    param([string] $Value)
    return ($Value -match "^[A-Fa-f0-9]{64}$")
}

function Convert-ReviewFlag {
    param([object] $Value)

    if ($Value -is [bool]) {
        return [bool]$Value
    }

    $normalized = ([string]$Value).Trim().ToLowerInvariant()
    if ($normalized -in @("yes", "true", "1")) {
        return $true
    }
    if ($normalized -in @("no", "false", "0", "")) {
        return $false
    }
    return $null
}

function Convert-ToList {
    param([object] $Value)

    if ($null -eq $Value) {
        return @()
    }
    if ($Value -is [array]) {
        return @($Value | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
    }
    if ($Value -is [System.Collections.IEnumerable] -and -not ($Value -is [string])) {
        return @($Value | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) })
    }

    $text = ([string]$Value).Trim()
    if ($text -eq "" -or $text -eq "[]") {
        return @()
    }
    if ($text.StartsWith("[") -and $text.EndsWith("]")) {
        $inner = $text.Substring(1, $text.Length - 2).Trim()
        if ($inner -eq "") {
            return @()
        }
        return @($inner -split "," | ForEach-Object { $_.Trim().Trim("'").Trim('"') } | Where-Object { $_ })
    }
    return @($text)
}

function Test-EmptyValue {
    param([object] $Value)

    if ($null -eq $Value) {
        return $true
    }
    if ($Value -is [array]) {
        return (@($Value).Count -eq 0)
    }
    $text = ([string]$Value).Trim()
    return ($text -eq "" -or $text -eq "[]" -or $text -eq "replace-me")
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
            $headers = @(Split-MarkdownRow $Lines[$i])
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

function Read-InventoryPacketPaths {
    param([string] $Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    $tables = Read-MarkdownTables @(Get-Content -LiteralPath $Path)
    foreach ($table in $tables) {
        if ($table.Headers -contains "packet_path") {
            $paths = New-Object System.Collections.Generic.List[string]
            foreach ($row in $table.Rows) {
                $property = $row.PSObject.Properties["packet_path"]
                if ($null -ne $property) {
                    $value = ([string]$property.Value).Trim()
                    if (-not [string]::IsNullOrWhiteSpace($value)) {
                        $paths.Add($value)
                    }
                }
            }
            return @($paths)
        }
    }
    return @()
}

function Read-SimpleYaml {
    param([string[]] $Lines)

    $map = [ordered]@{}
    foreach ($line in $Lines) {
        $trimmed = $line.Trim()
        if ($trimmed -eq "" -or $trimmed.StartsWith("#")) {
            continue
        }
        if ($trimmed -match "^([A-Za-z0-9_-]+):\s*(.*)$") {
            $key = $matches[1]
            $value = $matches[2].Trim()
            if (($value.StartsWith("'") -and $value.EndsWith("'")) -or ($value.StartsWith('"') -and $value.EndsWith('"'))) {
                $value = $value.Substring(1, $value.Length - 2)
            }
            if ($value.StartsWith("[") -and $value.EndsWith("]")) {
                $map[$key] = @(Convert-ToList $value)
            }
            elseif ($value -in @("true", "false")) {
                $map[$key] = [System.Convert]::ToBoolean($value)
            }
            else {
                $map[$key] = $value
            }
        }
    }
    return $map
}

function Read-Frontmatter {
    param([string] $Path)

    $lines = @(Get-Content -LiteralPath $Path)
    if ($lines.Count -lt 3 -or $lines[0].Trim() -ne "---") {
        return $null
    }

    $frontmatter = New-Object System.Collections.Generic.List[string]
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq "---") {
            return (Read-SimpleYaml @($frontmatter))
        }
        $frontmatter.Add($lines[$i])
    }

    return $null
}

function Read-Metadata {
    param(
        [string] $PacketDir,
        [string] $SourcePath
    )

    $metadataJson = Join-Path $PacketDir "metadata.json"
    $metadataYml = Join-Path $PacketDir "metadata.yml"
    $metadataYaml = Join-Path $PacketDir "metadata.yaml"

    if (Test-Path -LiteralPath $metadataJson) {
        return [pscustomobject]@{
            Source = $metadataJson
            Data = (Get-Content -Raw -LiteralPath $metadataJson | ConvertFrom-Json)
        }
    }
    if (Test-Path -LiteralPath $metadataYml) {
        return [pscustomobject]@{
            Source = $metadataYml
            Data = (Read-SimpleYaml @(Get-Content -LiteralPath $metadataYml))
        }
    }
    if (Test-Path -LiteralPath $metadataYaml) {
        return [pscustomobject]@{
            Source = $metadataYaml
            Data = (Read-SimpleYaml @(Get-Content -LiteralPath $metadataYaml))
        }
    }
    if (Test-Path -LiteralPath $SourcePath) {
        $frontmatter = Read-Frontmatter $SourcePath
        if ($null -ne $frontmatter) {
            return [pscustomobject]@{
                Source = "$SourcePath frontmatter"
                Data = $frontmatter
            }
        }
    }

    return $null
}

function Get-MetadataValue {
    param(
        [object] $Metadata,
        [string] $Name
    )

    if ($null -eq $Metadata) {
        return $null
    }
    if ($Metadata -is [System.Collections.IDictionary]) {
        if ($Metadata.Contains($Name)) {
            return $Metadata[$Name]
        }
        return $null
    }

    $property = $Metadata.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }
    return $property.Value
}

function Test-MetadataFieldExists {
    param(
        [object] $Metadata,
        [string] $Name
    )

    if ($null -eq $Metadata) {
        return $false
    }
    if ($Metadata -is [System.Collections.IDictionary]) {
        return $Metadata.Contains($Name)
    }

    return ($null -ne $Metadata.PSObject.Properties[$Name])
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

$packetInputs = New-Object System.Collections.Generic.List[string]
if ($failures.Count -eq 0) {
    if (-not [string]::IsNullOrWhiteSpace($Packet)) {
        $packetInputs.Add($Packet)
    }
    else {
        $inventoryPath = if ([System.IO.Path]::IsPathRooted($Inventory)) {
            $Inventory
        }
        else {
            Resolve-WorkspaceFile $workspacePath $Inventory
        }

        if (-not (Test-Path -LiteralPath $inventoryPath) -and $Inventory -eq "raw/source-inventory.md") {
            $templateInventory = Resolve-WorkspaceFile $workspacePath "raw/source-inventory.template.md"
            if (Test-Path -LiteralPath $templateInventory) {
                $inventoryPath = $templateInventory
                $reviewFindings.Add("Using template inventory because raw/source-inventory.md was not found: raw/source-inventory.template.md")
            }
        }

        if (-not (Test-Path -LiteralPath $inventoryPath)) {
            $failures.Add("Inventory file does not exist and no packet was specified: $Inventory")
        }
        else {
            $checksRun.Add("inventory packet paths parsed")
            foreach ($path in (Read-InventoryPacketPaths $inventoryPath)) {
                $packetInputs.Add($path)
            }
            if ($packetInputs.Count -eq 0) {
                $reviewFindings.Add("No packet_path values found in inventory.")
            }
        }
    }
}

$packetsChecked = 0
foreach ($packetInput in $packetInputs) {
    $packetPath = if ([System.IO.Path]::IsPathRooted($packetInput)) {
        $packetInput
    }
    else {
        Resolve-WorkspaceFile $workspacePath $packetInput
    }

    $sourcePath = $null
    $packetDir = $null
    if (Test-Path -LiteralPath $packetPath -PathType Container) {
        $packetDir = $packetPath
        $sourcePath = Join-Path $packetDir "source.md"
    }
    else {
        $sourcePath = $packetPath
        $packetDir = Split-Path -Parent $packetPath
    }

    $packetLabel = $packetInput
    $packetsChecked += 1

    if (-not (Test-Path -LiteralPath $packetPath)) {
        $failures.Add("${packetLabel}: packet path does not exist.")
        continue
    }

    if (-not (Test-Path -LiteralPath $sourcePath)) {
        $failures.Add("${packetLabel}: source.md does not exist.")
        continue
    }

    if ((Split-Path -Leaf $sourcePath) -ne "source.md") {
        $reviewFindings.Add("${packetLabel}: packet source file is not named source.md.")
    }

    $checksRun.Add("source packet exists: $packetLabel")
    $metadataRecord = Read-Metadata $packetDir $sourcePath
    if ($null -eq $metadataRecord) {
        $failures.Add("${packetLabel}: metadata.json, metadata.yml, metadata.yaml, or source.md frontmatter is missing.")
        continue
    }
    $checksRun.Add("packet metadata parsed: $packetLabel")
    $metadata = $metadataRecord.Data

    foreach ($field in $requiredMetadataFields) {
        if (-not (Test-MetadataFieldExists $metadata $field)) {
            $failures.Add("${packetLabel}: missing metadata field '$field'.")
        }
    }

    $type = Get-MetadataValue $metadata "type"
    if ($null -ne $type -and ([string]$type).Trim() -ne "source-packet") {
        $failures.Add("${packetLabel}: metadata type must be source-packet.")
    }

    $sourceId = ([string](Get-MetadataValue $metadata "source_id")).Trim()
    $rawPath = ([string](Get-MetadataValue $metadata "raw_path")).Trim()
    $rawHash = ([string](Get-MetadataValue $metadata "raw_sha256")).Trim()
    $sourceKind = ([string](Get-MetadataValue $metadata "source_kind")).Trim()
    $extractionStatus = ([string](Get-MetadataValue $metadata "extraction_status")).Trim()
    $reviewFlag = Convert-ReviewFlag (Get-MetadataValue $metadata "review_required")
    $reviewReason = ([string](Get-MetadataValue $metadata "review_reason")).Trim()
    $knownGaps = @(Convert-ToList (Get-MetadataValue $metadata "known_gaps"))
    $generatedFields = @(Convert-ToList (Get-MetadataValue $metadata "generated_fields"))
    $derivedArtifacts = @(Convert-ToList (Get-MetadataValue $metadata "derived_artifacts"))
    $modalities = @(Convert-ToList (Get-MetadataValue $metadata "modalities"))

    if (Test-EmptyValue $sourceId) {
        $failures.Add("${packetLabel}: source_id is blank or placeholder.")
    }
    if (Test-EmptyValue $rawPath) {
        $failures.Add("${packetLabel}: raw_path is blank or placeholder.")
    }
    elseif (-not (Test-WorkspaceRelativePath $rawPath "raw/sources")) {
        $failures.Add("${packetLabel}: raw_path must be workspace-relative under raw/sources/: $rawPath")
    }

    if (Test-EmptyValue $sourceKind) {
        $failures.Add("${packetLabel}: source_kind is blank or placeholder.")
    }

    if ($validExtractionStatuses -notcontains $extractionStatus) {
        $failures.Add("${packetLabel}: extraction_status must be complete/partial/failed/manual-review, got '$extractionStatus'.")
    }

    if ($modalities.Count -eq 0) {
        $reviewFindings.Add("${packetLabel}: modalities is empty.")
    }

    if ([string]::IsNullOrWhiteSpace($rawHash)) {
        $reviewFindings.Add("${packetLabel}: raw_sha256 is blank.")
    }
    elseif (-not (Test-Sha256 $rawHash) -and $validHashStates -notcontains $rawHash) {
        $failures.Add("${packetLabel}: raw_sha256 must be SHA-256 or one of pending/not-hashable/manifest, got '$rawHash'.")
    }
    elseif ((Test-Sha256 $rawHash) -and (Test-WorkspaceRelativePath $rawPath "raw/sources")) {
        $rawFilePath = Resolve-WorkspaceFile $workspacePath $rawPath
        if ((Test-Path -LiteralPath $rawFilePath) -and -not (Get-Item -LiteralPath $rawFilePath).PSIsContainer) {
            $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $rawFilePath).Hash.ToLowerInvariant()
            if ($actualHash -ne $rawHash.ToLowerInvariant()) {
                $failures.Add("${packetLabel}: raw_sha256 mismatch for $rawPath.")
            }
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($sourceId)) {
        $expectedDir = [System.IO.Path]::GetFullPath((Resolve-WorkspaceFile $workspacePath "raw/derived/$sourceId")).TrimEnd("\", "/")
        $actualDir = [System.IO.Path]::GetFullPath($packetDir).TrimEnd("\", "/")
        if ($actualDir -ne $expectedDir) {
            $failures.Add("${packetLabel}: packet directory should be raw/derived/$sourceId.")
        }
    }

    $lines = @(Get-Content -LiteralPath $sourcePath)
    $anchorTable = $null
    foreach ($table in (Read-MarkdownTables $lines)) {
        if ($table.Headers -contains "anchor_id") {
            $anchorTable = $table
            break
        }
    }

    if ($null -eq $anchorTable) {
        if ($extractionStatus -in @("complete", "partial")) {
            $failures.Add("${packetLabel}: complete or partial packet must contain an anchor table.")
        }
        else {
            $reviewFindings.Add("${packetLabel}: no anchor table; acceptable only because extraction_status is '$extractionStatus'.")
        }
    }
    else {
        foreach ($column in $requiredAnchorColumns) {
            if ($anchorTable.Headers -notcontains $column) {
                $reviewFindings.Add("${packetLabel}: anchor table is missing recommended column '$column'.")
            }
        }

        $seenAnchors = @{}
        foreach ($anchor in $anchorTable.Rows) {
            $anchorIdProperty = $anchor.PSObject.Properties["anchor_id"]
            $anchorId = if ($null -eq $anchorIdProperty) { "" } else { ([string]$anchorIdProperty.Value).Trim() }
            $lineProperty = $anchor.PSObject.Properties["line_number"]
            $line = if ($null -eq $lineProperty) { "unknown" } else { $lineProperty.Value }

            if ([string]::IsNullOrWhiteSpace($anchorId)) {
                $failures.Add("${packetLabel}: anchor row on line $line has blank anchor_id.")
            }
            elseif ($seenAnchors.ContainsKey($anchorId)) {
                $failures.Add("${packetLabel}: duplicate anchor_id '$anchorId' on line $line; first seen on line $($seenAnchors[$anchorId]).")
            }
            else {
                $seenAnchors[$anchorId] = $line
            }

            if ($anchorId -match "\s|#|\\") {
                $reviewFindings.Add("${packetLabel}: anchor_id '$anchorId' should be citation-safe.")
            }

            $generatedProperty = $anchor.PSObject.Properties["generated"]
            $generated = if ($null -eq $generatedProperty) { $false } else { Convert-ReviewFlag $generatedProperty.Value }
            $anchorReviewProperty = $anchor.PSObject.Properties["review_required"]
            $anchorReview = if ($null -eq $anchorReviewProperty) { $false } else { Convert-ReviewFlag $anchorReviewProperty.Value }

            if ($generated -eq $true -and $generatedFields.Count -eq 0) {
                $reviewFindings.Add("${packetLabel}: generated anchor '$anchorId' exists but generated_fields is empty.")
            }
            if ($generated -eq $true -and $anchorReview -ne $true) {
                $reviewFindings.Add("${packetLabel}: generated anchor '$anchorId' should require review unless already justified elsewhere.")
            }
        }

        if ($anchorTable.Rows.Count -eq 0 -and $extractionStatus -in @("complete", "partial")) {
            $failures.Add("${packetLabel}: complete or partial packet has no anchors.")
        }
    }

    if ($extractionStatus -in @("partial", "failed", "manual-review")) {
        if ($knownGaps.Count -eq 0) {
            $failures.Add("${packetLabel}: extraction_status '$extractionStatus' requires known_gaps.")
        }
        if ($reviewFlag -ne $true) {
            $failures.Add("${packetLabel}: extraction_status '$extractionStatus' requires review_required true/yes.")
        }
        if (Test-EmptyValue $reviewReason) {
            $failures.Add("${packetLabel}: extraction_status '$extractionStatus' requires a useful review_reason.")
        }
    }
    elseif ($reviewFlag -eq $true -and (Test-EmptyValue $reviewReason)) {
        $reviewFindings.Add("${packetLabel}: review_required is true but review_reason is empty.")
    }
    elseif ($null -eq $reviewFlag) {
        $failures.Add("${packetLabel}: review_required must be yes/no/true/false.")
    }

    foreach ($artifact in $derivedArtifacts) {
        if (-not (Test-SafeRelativePath $artifact)) {
            $failures.Add("${packetLabel}: derived artifact path must be safe and relative: $artifact")
            continue
        }

        $workspaceArtifact = Resolve-WorkspaceFile $workspacePath $artifact
        $packetArtifact = Join-Path $packetDir ($artifact -replace "/", [System.IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath $workspaceArtifact) -and -not (Test-Path -LiteralPath $packetArtifact)) {
            $reviewFindings.Add("${packetLabel}: derived artifact reference does not exist locally: $artifact")
        }
    }
}

$status = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $status = "fail"
    $exitCode = 1
    $nextActions.Add("Fix deterministic source packet failures and rerun source-packet-lint.")
}
elseif ($reviewFindings.Count -gt 0) {
    $status = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review packet findings before treating packets as ready for wiki or compare work.")
}
else {
    $nextActions.Add("Proceed to evidence, wiki, compare, or the next validation step.")
}

$checksRunText = Convert-TextList $checksRun
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions

$reportContent = @"
# Source Packet Lint Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Packet input: $Packet
- Inventory: $Inventory
- Started: $started
- Status: $status
- Exit code: $exitCode
- Packets checked: $packetsChecked

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

- Does not parse raw binary documents.
- Does not run extractors, OCR, VLM, MinerU, or MCP adapters.
- Does not generate source packets.
- Does not decide semantic truth.
- Does not generate wiki pages.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "source-packet-lint: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

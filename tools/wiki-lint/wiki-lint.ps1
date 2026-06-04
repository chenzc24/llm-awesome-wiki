param(
    [string] $Workspace = ".",
    [string] $WikiDir = "wiki",
    [string] $Report = "wiki-lint-report.md"
)

$ErrorActionPreference = "Stop"

$toolName = "wiki-lint"
$toolPhase = "Phase 6.4 wiki lint and navigation validation"
$started = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$checksRun = New-Object System.Collections.Generic.List[string]
$failures = New-Object System.Collections.Generic.List[string]
$reviewFindings = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$nextActions = New-Object System.Collections.Generic.List[string]

$requiredFrontmatterFields = @("type", "title", "sources", "created", "updated")
$overviewMinimumSections = @(
    "Corpus Map",
    "Important Sources Or Decks",
    "Chapter Structure",
    "Current Coverage",
    "Known Gaps"
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

function Convert-ToWikiRelativePath {
    param(
        [string] $WikiPath,
        [string] $Path
    )

    $wikiFull = [System.IO.Path]::GetFullPath($WikiPath).TrimEnd([char[]]@('\', '/'))
    $pathFull = [System.IO.Path]::GetFullPath($Path)
    if (-not $pathFull.StartsWith($wikiFull, [System.StringComparison]::OrdinalIgnoreCase)) {
        return $Path
    }

    $relative = $pathFull.Substring($wikiFull.Length).TrimStart([char[]]@('\', '/'))
    return ($relative -replace "\\", "/")
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
            $map[$key] = $value
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

function Test-MapContains {
    param(
        [object] $Map,
        [string] $Name
    )

    if ($null -eq $Map) {
        return $false
    }
    if ($Map -is [System.Collections.IDictionary]) {
        return $Map.Contains($Name)
    }
    return ($null -ne $Map.PSObject.Properties[$Name])
}

function Get-MapValue {
    param(
        [object] $Map,
        [string] $Name
    )

    if ($null -eq $Map) {
        return $null
    }
    if ($Map -is [System.Collections.IDictionary]) {
        if ($Map.Contains($Name)) {
            return $Map[$Name]
        }
        return $null
    }

    $property = $Map.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }
    return $property.Value
}

function Get-WikiLinks {
    param([string] $Content)

    $links = New-Object System.Collections.Generic.List[string]
    $matches = [regex]::Matches($Content, "\[\[([^\]]+)\]\]")
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value.Trim()
        if ($target.Contains("|")) {
            $target = ($target -split "\|", 2)[0].Trim()
        }
        if (-not [string]::IsNullOrWhiteSpace($target)) {
            $links.Add($target)
        }
    }
    return @($links)
}

function Get-MarkdownLinks {
    param([string] $Content)

    $links = New-Object System.Collections.Generic.List[string]
    $matches = [regex]::Matches($Content, "(?<!\!)\[[^\]]+\]\(([^)]+)\)")
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value.Trim().Trim("<", ">")
        if (-not [string]::IsNullOrWhiteSpace($target)) {
            $links.Add($target)
        }
    }
    return @($links)
}

function Normalize-WikiTarget {
    param([string] $Target)

    $clean = $Target.Trim()
    if ($clean.Contains("#")) {
        $clean = ($clean -split "#", 2)[0].Trim()
    }
    if ($clean.EndsWith(".md")) {
        $clean = $clean.Substring(0, $clean.Length - 3)
    }
    $clean = $clean.TrimStart("/")
    if ($clean.StartsWith("wiki/")) {
        $clean = $clean.Substring(5)
    }
    return $clean
}

function Add-KeyedRecord {
    param(
        [hashtable] $Map,
        [string] $Key,
        [object] $Record
    )

    if ([string]::IsNullOrWhiteSpace($Key)) {
        return
    }
    if (-not $Map.ContainsKey($Key)) {
        $Map[$Key] = New-Object System.Collections.Generic.List[object]
    }
    foreach ($existing in $Map[$Key]) {
        if ($existing.FullPath -eq $Record.FullPath) {
            return
        }
    }
    $Map[$Key].Add($Record) | Out-Null
}

function Resolve-WikiLinkTarget {
    param(
        [string] $Target,
        [hashtable] $TargetMap
    )

    $clean = Normalize-WikiTarget $Target
    if ([string]::IsNullOrWhiteSpace($clean)) {
        return [pscustomobject]@{
            Status = "anchor-only"
            Record = $null
        }
    }

    $key = [string]$clean
    if (-not $TargetMap.ContainsKey($key)) {
        return [pscustomobject]@{
            Status = "missing"
            Record = $null
        }
    }

    $value = $TargetMap[$key]
    $recordsList = New-Object System.Collections.Generic.List[object]
    if ($value -is [System.Collections.IEnumerable] -and -not ($value -is [string])) {
        foreach ($item in $value) {
            $recordsList.Add($item) | Out-Null
        }
    }
    elseif ($null -ne $value) {
        $recordsList.Add($value) | Out-Null
    }
    $records = $recordsList.ToArray()
    if ($records.Count -gt 1) {
        return [pscustomobject]@{
            Status = "ambiguous"
            Record = $records[0]
        }
    }

    return [pscustomobject]@{
        Status = "resolved"
        Record = $records[0]
    }
}

function Test-ExternalLink {
    param([string] $Target)

    return ($Target -match "^(https?|mailto|tel):")
}

function Resolve-LocalMarkdownLink {
    param(
        [string] $Target,
        [string] $CurrentFile,
        [string] $WorkspacePath
    )

    if (Test-ExternalLink $Target) {
        return [pscustomobject]@{
            Status = "external"
            Path = $null
        }
    }

    $clean = ($Target -split "#", 2)[0].Trim()
    if ([string]::IsNullOrWhiteSpace($clean)) {
        return [pscustomobject]@{
            Status = "anchor-only"
            Path = $CurrentFile
        }
    }

    if ([System.IO.Path]::IsPathRooted($clean)) {
        return [pscustomobject]@{
            Status = "unsafe"
            Path = $clean
        }
    }

    $currentDir = Split-Path -Parent $CurrentFile
    $candidate = [System.IO.Path]::GetFullPath((Join-Path $currentDir ($clean -replace "/", [System.IO.Path]::DirectorySeparatorChar)))
    if (Test-Path -LiteralPath $candidate) {
        return [pscustomobject]@{
            Status = "resolved"
            Path = $candidate
        }
    }

    $workspaceCandidate = [System.IO.Path]::GetFullPath((Resolve-WorkspaceFile $WorkspacePath $clean))
    if (Test-Path -LiteralPath $workspaceCandidate) {
        return [pscustomobject]@{
            Status = "resolved"
            Path = $workspaceCandidate
        }
    }

    return [pscustomobject]@{
        Status = "missing"
        Path = $candidate
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

$wikiPath = $null
$indexPath = $null
$overviewPath = $null
$logPath = $null
$contentPages = New-Object System.Collections.Generic.List[object]
$specialPages = New-Object System.Collections.Generic.List[object]
$targetMap = @{}
$indexedWikiRelPaths = @{}
$pagesChecked = 0
$linksChecked = 0

if ($failures.Count -eq 0) {
    $wikiPath = Resolve-WorkspaceFile $workspacePath $WikiDir
    if (-not (Test-Path -LiteralPath $wikiPath -PathType Container)) {
        $failures.Add("Wiki directory does not exist: $WikiDir")
    }
    else {
        $checksRun.Add("wiki directory exists")
        $indexPath = Join-Path $wikiPath "index.md"
        $overviewPath = Join-Path $wikiPath "overview.md"
        $logPath = Join-Path $wikiPath "log.md"

        foreach ($special in @(
            [pscustomobject]@{ Name = "index"; Path = $indexPath },
            [pscustomobject]@{ Name = "overview"; Path = $overviewPath },
            [pscustomobject]@{ Name = "log"; Path = $logPath }
        )) {
            if (-not (Test-Path -LiteralPath $special.Path)) {
                $failures.Add("Missing special wiki file: wiki/$($special.Name).md")
            }
            else {
                $wikiRel = Convert-ToWikiRelativePath $wikiPath $special.Path
                $record = [pscustomobject]@{
                    FullPath = $special.Path
                    WorkspaceRel = Convert-ToWorkspaceRelativePath $workspacePath $special.Path
                    WikiRel = $wikiRel
                    WikiRelNoExt = $wikiRel.Substring(0, $wikiRel.Length - 3)
                    BaseName = [System.IO.Path]::GetFileNameWithoutExtension($special.Path)
                    IsSpecial = $true
                }
                $specialPages.Add($record)
                Add-KeyedRecord $targetMap $record.WikiRelNoExt $record
                Add-KeyedRecord $targetMap $record.BaseName $record
            }
        }

        $allMarkdown = @(Get-ChildItem -LiteralPath $wikiPath -Recurse -Filter "*.md" -File)
        foreach ($file in $allMarkdown) {
            $leaf = $file.Name
            if ($leaf -eq "README.md" -or $leaf.EndsWith(".template.md")) {
                continue
            }
            if ($file.FullName -in @($indexPath, $overviewPath, $logPath)) {
                continue
            }

            $wikiRel = Convert-ToWikiRelativePath $wikiPath $file.FullName
            $wikiRelNoExt = $wikiRel.Substring(0, $wikiRel.Length - 3)
            $record = [pscustomobject]@{
                FullPath = $file.FullName
                WorkspaceRel = Convert-ToWorkspaceRelativePath $workspacePath $file.FullName
                WikiRel = $wikiRel
                WikiRelNoExt = $wikiRelNoExt
                BaseName = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
                IsSpecial = $false
            }
            $contentPages.Add($record)
            Add-KeyedRecord $targetMap $record.WikiRelNoExt $record
            Add-KeyedRecord $targetMap $record.BaseName $record
        }

        $checksRun.Add("wiki pages discovered")
        if ($contentPages.Count -eq 0) {
            $reviewFindings.Add("No active content pages found under wiki/.")
        }
    }
}

if ($failures.Count -eq 0) {
    foreach ($page in $contentPages) {
        $pagesChecked += 1
        $label = $page.WorkspaceRel
        $frontmatter = Read-Frontmatter $page.FullPath
        if ($null -eq $frontmatter) {
            $failures.Add("${label}: missing YAML frontmatter.")
        }
        else {
            foreach ($field in $requiredFrontmatterFields) {
                if (-not (Test-MapContains $frontmatter $field)) {
                    $failures.Add("${label}: missing frontmatter field '$field'.")
                }
            }

            $pageType = ([string](Get-MapValue $frontmatter "type")).Trim()
            if ([string]::IsNullOrWhiteSpace($pageType)) {
                $failures.Add("${label}: frontmatter type is blank.")
            }
            elseif ($page.WikiRel.StartsWith("chapters/") -and $pageType -ne "chapter") {
                $reviewFindings.Add("${label}: page under wiki/chapters/ should normally use type 'chapter'.")
            }
            elseif ($page.WikiRel.StartsWith("sources/") -and $pageType -ne "source") {
                $reviewFindings.Add("${label}: page under wiki/sources/ should normally use type 'source'.")
            }

            foreach ($dateField in @("created", "updated")) {
                $dateValue = ([string](Get-MapValue $frontmatter $dateField)).Trim()
                if ($dateValue -eq "YYYY-MM-DD") {
                    $reviewFindings.Add("${label}: frontmatter $dateField still uses placeholder YYYY-MM-DD.")
                }
                elseif ($dateValue -ne "" -and $dateValue -notmatch "^\d{4}-\d{2}-\d{2}$") {
                    $reviewFindings.Add("${label}: frontmatter $dateField should use YYYY-MM-DD format.")
                }
            }
        }

        $content = Get-Content -Raw -LiteralPath $page.FullPath
        $outgoingLinks = 0
        foreach ($target in (Get-WikiLinks $content)) {
            $linksChecked += 1
            $resolution = Resolve-WikiLinkTarget $target $targetMap
            if ($resolution.Status -eq "missing") {
                $failures.Add("${label}: broken wikilink '[[$target]]'.")
            }
            elseif ($resolution.Status -eq "ambiguous") {
                $reviewFindings.Add("${label}: ambiguous wikilink '[[$target]]'.")
                $outgoingLinks += 1
            }
            elseif ($resolution.Status -eq "resolved") {
                $outgoingLinks += 1
            }
        }

        foreach ($target in (Get-MarkdownLinks $content)) {
            $linksChecked += 1
            $resolution = Resolve-LocalMarkdownLink $target $page.FullPath $workspacePath
            if ($resolution.Status -eq "missing") {
                $failures.Add("${label}: broken Markdown link '($target)'.")
            }
            elseif ($resolution.Status -eq "unsafe") {
                $failures.Add("${label}: Markdown link must not use absolute local path: $target")
            }
            elseif ($resolution.Status -in @("resolved", "external", "anchor-only")) {
                $outgoingLinks += 1
            }
        }

        if ($outgoingLinks -eq 0) {
            $reviewFindings.Add("${label}: content page has no outgoing wiki, local, or external links.")
        }
    }
    $checksRun.Add("content page frontmatter and links checked")
}

if ($failures.Count -eq 0 -and (Test-Path -LiteralPath $indexPath)) {
    $indexContent = Get-Content -Raw -LiteralPath $indexPath
    foreach ($target in (Get-WikiLinks $indexContent)) {
        $linksChecked += 1
        $resolution = Resolve-WikiLinkTarget $target $targetMap
        if ($resolution.Status -eq "missing") {
            $failures.Add("wiki/index.md: broken wikilink '[[$target]]'.")
        }
        elseif ($resolution.Status -eq "ambiguous") {
            $reviewFindings.Add("wiki/index.md: ambiguous wikilink '[[$target]]'.")
            if ($null -ne $resolution.Record) {
                $indexedWikiRelPaths[$resolution.Record.WikiRel] = $true
            }
        }
        elseif ($resolution.Status -eq "resolved") {
            $indexedWikiRelPaths[$resolution.Record.WikiRel] = $true
        }
    }

    foreach ($target in (Get-MarkdownLinks $indexContent)) {
        $linksChecked += 1
        $resolution = Resolve-LocalMarkdownLink $target $indexPath $workspacePath
        if ($resolution.Status -eq "missing") {
            $failures.Add("wiki/index.md: broken Markdown link '($target)'.")
        }
        elseif ($resolution.Status -eq "unsafe") {
            $failures.Add("wiki/index.md: Markdown link must not use absolute local path: $target")
        }
        elseif ($resolution.Status -eq "resolved") {
            $resolvedRel = Convert-ToWikiRelativePath $wikiPath $resolution.Path
            if ($resolvedRel.EndsWith(".md")) {
                $indexedWikiRelPaths[$resolvedRel] = $true
            }
        }
    }

    if (-not $indexedWikiRelPaths.ContainsKey("overview.md")) {
        $failures.Add("wiki/index.md: overview.md must be discoverable from the index.")
    }

    foreach ($page in $contentPages) {
        if (-not $indexedWikiRelPaths.ContainsKey($page.WikiRel)) {
            $failures.Add("wiki/index.md: content page is missing from index: $($page.WikiRel)")
        }
    }

    $checksRun.Add("index links and membership checked")
}

if ($failures.Count -eq 0 -and (Test-Path -LiteralPath $overviewPath)) {
    $overviewContent = Get-Content -Raw -LiteralPath $overviewPath
    foreach ($section in $overviewMinimumSections) {
        if ($overviewContent -notmatch "(?m)^##\s+$([regex]::Escape($section))") {
            $reviewFindings.Add("wiki/overview.md: expected overview section not found or renamed: $section")
        }
    }
    $checksRun.Add("overview maintenance sections checked")
}

if ($failures.Count -eq 0 -and (Test-Path -LiteralPath $logPath)) {
    $logContent = Get-Content -Raw -LiteralPath $logPath
    if ($logContent -notmatch "(?m)^##\s+\[\d{4}-\d{2}-\d{2}\]") {
        $reviewFindings.Add("wiki/log.md: no dated log entry heading found.")
    }
    $checksRun.Add("wiki log dated entry checked")
}

$status = "pass"
$exitCode = 0
if ($failures.Count -gt 0) {
    $status = "fail"
    $exitCode = 1
    $nextActions.Add("Fix deterministic wiki lint failures and rerun wiki-lint.")
}
elseif ($reviewFindings.Count -gt 0) {
    $status = "needs-review"
    $exitCode = 2
    $nextActions.Add("Review wiki lint findings before treating navigation as complete.")
}
else {
    $nextActions.Add("Proceed to compare/report validation or the next Phase 6 checker target.")
}

$checksRunText = Convert-TextList $checksRun
$failuresText = Convert-TextList $failures
$reviewText = Convert-TextList $reviewFindings
$warningsText = Convert-TextList $warnings
$nextActionsText = Convert-TextList $nextActions

$reportContent = @"
# Wiki Lint Report

## Summary

- Tool: $toolName
- Phase: $toolPhase
- Workspace: $workspacePath
- Wiki directory: $WikiDir
- Started: $started
- Status: $status
- Exit code: $exitCode
- Pages checked: $pagesChecked
- Links checked: $linksChecked

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

- Does not generate wiki pages.
- Does not rewrite links or frontmatter.
- Does not run compare gates.
- Does not inspect raw binary documents.
- Does not resolve semantic review.
"@

Set-Content -LiteralPath $reportPath -Value $reportContent -Encoding UTF8
Write-Host "wiki-lint: $status (exit $exitCode)"
Write-Host "report: $reportPath"
exit $exitCode

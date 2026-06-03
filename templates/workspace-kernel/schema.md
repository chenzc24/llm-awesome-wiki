# Workspace Schema

This file defines how the workspace is structured and how agents should write
wiki pages, reports, and source packets.

## Directory Contract

```text
raw/sources/      immutable source files
raw/derived/      source packets and extracted media
wiki/             maintained distilled knowledge
reports/          lint, compare, coverage, and review outputs
contracts/        copied or referenced machine contracts
plan/             target plans and maintenance log
tools/            workspace-local construction tools
```

## Wiki Page Types

| Type | Directory | Purpose |
| --- | --- | --- |
| source | `wiki/sources/` | Summary of one source packet or raw source |
| concept | `wiki/concepts/` | Stable idea, method, pattern, or phenomenon |
| entity | `wiki/entities/` | Named person, project, organization, dataset, or tool |
| comparison | `wiki/comparisons/` | Side-by-side analysis |
| synthesis | `wiki/synthesis/` | Cross-source conclusions |
| query | `wiki/queries/` | Open question or investigation thread |

## Frontmatter

Every wiki page should include:

```yaml
---
type: concept
title: Human Readable Title
sources: []
related: []
claim_ids: []
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

## Link Convention

Use one link style consistently. The default is wikilink syntax:

```text
[[page-slug]]
[[page-slug|Readable Label]]
```

## Logs And Reports

- `wiki/index.md` is the content navigation entry.
- `wiki/log.md` is the chronological maintenance log.
- `plan/log.md` is the workspace maintenance log for targets, validation, and
  commits.
- `reports/` contains compare, lint, coverage, and review outputs.
- A distillation round should not advance without a recorded validation result.

## Source Packet Minimum

Each packet under `raw/derived/<source-id>/` should include:

- `source.md`
- `metadata.json` or `metadata.yml`
- stable anchors
- extraction gaps when present
- generated fields clearly marked

## Round Status

A round may end as:

- `pass`: accepted and ready to advance
- `needs-review`: valid enough to keep, but blocked by human judgment
- `fail`: missing required files, broken links, unsupported claims, or invalid
  source coverage

# Workspace Schema

This file defines how the workspace is structured and how agents should write
source packets, claim/evidence maps, chapter-oriented wiki pages, reports, and
review items.

## Directory Contract

```text
raw/sources/      immutable source files
raw/derived/      source packets and extracted media
wiki/             maintained distilled knowledge
reports/          claim/evidence maps, lint, compare, coverage, and review outputs
contracts/        copied or referenced machine contracts
plan/             target plans and maintenance log
tools/            workspace-local construction tools
```

## Wiki Page Types

| Type | Directory | Purpose |
| --- | --- | --- |
| source | `wiki/sources/` | Summary of one source packet, deck, or raw source |
| chapter | `wiki/chapters/` | Human-readable distilled chapter or section |
| overview | `wiki/overview.md` | Current whole-corpus overview |
| synthesis | optional | Cross-source conclusions when needed |

Optional research-profile page types:

- `concept`
- `entity`
- `comparison`
- `query`

Do not create optional research pages by default. Use them only when they
improve long-term reuse, review, or downstream execution.

## Frontmatter

Every wiki page should include:

```yaml
---
type: chapter
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
- `reports/` contains claim/evidence maps, compare, lint, coverage, and review
  outputs.
- Wiki construction analysis reports belong under `reports/` or a configured
  validation/review report path before page generation begins.
- A distillation round should not advance without a recorded validation result.

## Source Packet Minimum

Each packet under `raw/derived/<source-id>/` should include:

- `source.md`
- `metadata.json` or `metadata.yml`
- stable anchors
- extraction gaps when present
- generated fields clearly marked

## Claim And Evidence Minimum

When a round creates important source-backed claims, record a concise
claim/evidence map under `reports/review/` or another configured review path.

The map should preserve:

- evidence references in `<source_id>#<anchor_id>` form
- claim status
- generated-evidence state when relevant
- unsupported, contested, stale, or needs-review claims
- review item references when human judgment is required

Do not use the claim/evidence map as the primary reading surface. Keep readable
knowledge in `wiki/chapters/` by default.

## Wiki Construction Analysis Minimum

Before writing or updating wiki pages from source packets, record construction
analysis in a visible report or plan note.

The analysis should preserve:

- source packets and claim/evidence maps read
- existing wiki pages inspected
- routing decisions
- target pages to create, update, merge, or leave unchanged
- review handoff for unsupported, contested, generated-derived, or
  judgment-heavy claims

## Round Status

A round may end as:

- `pass`: accepted and ready to advance
- `needs-review`: valid enough to keep, but blocked by human judgment
- `fail`: missing required files, broken links, unsupported claims, or invalid
  source coverage

# Workspace Schema

This file defines how the workspace is structured and how agents should write
source packets, semantic drafts, grounding notes, claim/evidence maps,
chapter-oriented wiki pages, reports, and review items.

Use `KERNEL-MANIFEST.md` to classify this workspace's runtime bundle. Runtime
work starts from `skills/llm-wiki-distill/SKILL.md` when skills are copied or
synchronized into the workspace. `rules/README.md` is the detailed reference
index, not the default runtime entrypoint.

## Directory Contract

```text
raw/sources/      immutable source files
raw/derived/      source packets and extracted media
wiki/             maintained distilled knowledge
reports/          claim/evidence maps, lint, compare, coverage, and review outputs
contracts/        copied or pinned machine contracts
plan/             target plans and maintenance log
tools/            workspace-local construction tools
skills/           runtime agent entrypoints copied or synchronized from system repo
rules/            detailed reference rules copied or synchronized from system repo
```

## Kernel Bundle State

Record the workspace's current kernel state here:

- skills source:
- rules source:
- contracts source:
- checker mode: development tool mode or portable tool mode
- system repo version or commit:

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
  validation/review report path before page generation begins. They should
  include semantic drafting and grounding status when wiki pages change.
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

Before writing or updating accepted wiki pages, record construction analysis in
a visible report or plan note. Follow the wiki surface workflow for semantic
drafting, grounding, page routing, index updates, overview refreshes, and wiki
log maintenance.

The analysis should preserve:

- source packets and claim/evidence maps read
- raw/rendered or external reading inputs used
- important semantic draft units
- grounding decisions for accepted, deferred, rejected, or reviewed content
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

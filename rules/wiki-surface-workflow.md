# Wiki Surface Workflow

This rule owns the Phase 4 wiki surface: page routing, default source/chapter
reading surface, index behavior, overview refresh, wiki log updates, optional
pages, merge rules, and review routing for wiki construction.

Use it before writing wiki prose and during every wiki-facing distillation
round.

## Purpose

Prevent wiki construction from drifting into duplicate packets, duplicate
claim/evidence maps, or fragmented research-object pages.

Required path:

```text
source packet
+ claim/evidence map when important claims are in scope
+ review queue when unresolved judgment exists
-> routing decision
-> wiki construction analysis
-> accepted wiki updates
-> index, overview, and log maintenance
```

## Inputs

Routing and surface maintenance should inspect:

- source packet metadata and anchors
- source structure, such as pages, slides, sections, chapters, or headings
- claim/evidence map when important claims are in scope
- review queue and unresolved judgment
- existing `wiki/overview.md`
- existing `wiki/index.md`
- existing source and chapter pages

## Default Reading Surface

For document and PPT corpora, route toward:

```text
wiki/overview.md
wiki/index.md
wiki/chapters/*
wiki/sources/*
reports/review/*
```

This preserves source and chapter readability while keeping audit artifacts
separate.

## Routing Table

| Input content | Default destination | Rule |
| --- | --- | --- |
| whole-corpus status, source groups, coverage state | `wiki/overview.md` | Keep concise; link to chapters, sources, and reports. |
| navigation for accepted pages | `wiki/index.md` | Keep content-oriented and scannable. |
| one source, deck, document, or packet identity | `wiki/sources/<source-id>.md` | Write a short source note, not packet content. |
| section, chapter, slide range, or teachable unit | `wiki/chapters/<chapter-slug>.md` | Main distilled knowledge surface. |
| evidence support, claim status, unresolved judgment | `reports/review/*` | Keep as audit/review support. |
| cross-source conclusion after chapter pages stabilize | optional synthesis page | Create only with a recorded reason. |
| concept, entity, comparison, or query object | optional research page | Defer unless it improves reuse, review, or downstream execution. |

## Source Page Rules

Use a source page when a workspace needs a short note about one source, deck,
document, or packet.

A source page should include:

- source identity or source ID
- packet path or source packet reference
- what the source contains
- structure summary
- links to chapter pages
- important gaps or review notes

A source page should not:

- repeat all extracted text
- repeat full packet metadata
- list every anchor unless that is genuinely useful for navigation
- become a polished copy of `raw/derived/<source-id>/source.md`

## Chapter Page Rules

Use chapter pages for the main distilled knowledge.

A chapter page should:

- preserve source order or a deliberate chapter structure
- cite source packet anchors for important claims
- use claim/evidence maps as support, not as the page body
- carry unresolved judgment into a gaps or review section
- stay compact enough for agents to scan

A chapter page should not:

- become a table of every claim and evidence item
- hide generated-evidence uncertainty
- merge unrelated source sections only because they share vocabulary
- split one source chapter into many object pages without a recorded reason

## Overview Role

`wiki/overview.md` is the current corpus map. It should help an agent or human
understand:

- what the workspace covers
- which source groups matter
- where the main chapter reading path begins
- what coverage is missing
- what high-level review questions remain
- which reports or review queues matter now

It should not be a final synthesis, a second source packet, a claim/evidence
report, a full index, or a chronological log.

Default overview sections:

- Corpus Map
- Important Sources Or Decks
- Chapter Structure
- Current Coverage
- Known Gaps And Review Items

Workspaces may rename sections, but the overview should remain concise and
scannable.

Refresh `wiki/overview.md` when a round changes:

- corpus purpose, scope, or audience
- major source groups or deck groups
- chapter structure or reading path
- coverage state
- high-level gaps or review themes
- accepted cross-source synthesis direction

Do not refresh it for small typo-only edits unless they affect navigation,
coverage, or accepted knowledge.

## Index Role

`wiki/index.md` is the primary navigation entry for agents and humans. It is
content-oriented, not chronological.

Required behavior:

- read `wiki/index.md` before answering questions or modifying wiki pages
- update it after every accepted wiki page creation, deletion, major retitle,
  move, or merge
- inspect it during every wiki construction round, even when no update is
  needed
- group entries by page type or domain-specific category
- keep each entry short enough for quick scanning
- treat missing index entries as lint findings
- treat stale entries as validation findings

Use a stable Markdown list shape:

```text
- [[page-slug]] - one-line purpose or summary
```

The workspace may use standard Markdown links instead of wikilinks, but it must
choose one convention in `schema.md` and apply it consistently.

Default document-corpus index sections:

- Overview
- Sources Or Decks
- Chapters
- Reports And Review
- Optional Synthesis

These are index sections, not mandatory folders. Domain workspaces may rename
or add sections, but should preserve a clear navigation route from source
material to chapter pages and review reports.

Research-style workspaces may add Concepts, Entities, Comparisons, Synthesis,
or Open Questions only when they improve long-term reuse, cross-source
synthesis, or review.

Index accepted pages and important active reports. Do not index every raw file,
every source packet anchor, every evidence row, or every claim row.

## Special Pages

The following pages are special and may be handled separately from normal
content-page indexing:

- `wiki/index.md`
- `wiki/log.md`
- `wiki/overview.md`

`overview.md` should still be discoverable from the index. `index.md` and
`log.md` do not need normal content entries.

## Wiki Log Role

`wiki/log.md` records chronological wiki-facing events.

A useful log entry should include:

- date
- change type
- target
- sources or source packets touched
- construction analysis path when wiki pages changed
- page decisions
- reports or validation notes
- review items created, resolved, or carried forward
- commit and push status when known

The log should not copy full reports, long explanations, source packet text, or
claim/evidence maps.

Update `wiki/log.md` when a round:

- creates, updates, merges, retitles, or deletes wiki pages
- inspects pages and records `leave-unchanged` decisions
- changes overview or index
- creates or updates reports that gate wiki acceptance
- changes review item status
- carries unresolved review forward

## Optional Page Rules

Optional synthesis pages are allowed when:

- multiple chapter pages already exist
- the synthesis has clear source-backed claims
- the page improves agent navigation or downstream reuse
- the reason for creating it is recorded

Optional research pages, such as concepts, entities, comparisons, and queries,
are allowed only when the corpus actually needs them. They are not default
output for large PPT or document corpora.

## Merge Rules

Before creating a new page:

1. Read `wiki/index.md`.
2. Search existing wiki pages for the intended topic or source.
3. Prefer updating an existing page when the scope matches.
4. Create a new page only when the scope is distinct.
5. Record the reason when page routing is not obvious.

## Review Routing

Route content to review instead of wiki prose when:

- support is missing
- evidence is generated and important
- sources conflict
- page scope is unclear
- a proposed page would duplicate an existing page
- a claim/evidence map says the claim is unsupported, contested, stale, or
  needs review

## Round Closure Surface Requirements

Before closing a wiki construction round, record:

- compare report path and status
- closure decision
- overview update status
- index update status
- wiki log entry status
- validation note path
- active reports or review queues linked from index when needed
- carried-forward review items
- next action or next round

If overview or index did not change, record that the round inspected them and
why no update was needed.

## Acceptance Criteria

- each proposed wiki update has a routing decision
- source pages remain short source notes
- chapter pages remain the primary distilled knowledge surface
- claim/evidence maps remain reports, not page bodies
- construction analysis records create, update, merge, report-only, needs-review,
  or leave-unchanged decisions
- optional synthesis or research pages have recorded reasons
- index entries make the default reading path visible
- every content page has one index entry unless treated as a special page
- every index entry resolves to an existing page
- section names match the workspace schema
- source/deck pages, chapter pages, reports, and optional research-profile
  pages are not mixed without a recorded reason
- overview remains a concise corpus map
- wiki log remains chronological and short
- stale navigation or log omissions become validation findings
- reports are linked instead of copied
- closure decisions remain discoverable from the validation note and wiki log

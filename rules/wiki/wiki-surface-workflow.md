# Wiki Surface Workflow

This rule owns page routing, the default source/chapter reading surface, index
behavior, overview refresh, wiki log updates, optional pages, merge rules, and
wiki-facing review routing.

Use it before writing wiki prose and during every wiki-facing distillation
round.

## Minimum Path

```text
source packet + optional claim/evidence/review inputs
-> routing decision
-> wiki construction analysis
-> accepted wiki updates
-> index, overview, and log maintenance
```

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

## Inputs

Routing and surface maintenance should inspect:

- source packet metadata and anchors
- source structure, such as pages, slides, sections, chapters, or headings
- claim/evidence map when important claims are in scope
- review queue when unresolved judgment exists
- existing `wiki/overview.md`
- existing `wiki/index.md`
- existing source and chapter pages

## Routing Table

| Input content | Default destination | Rule |
| --- | --- | --- |
| whole-corpus status, source groups, coverage state | `wiki/overview.md` | Keep concise; link to chapters, sources, and reports. |
| accepted page navigation | `wiki/index.md` | Keep content-oriented and scannable. |
| one source, deck, document, or packet identity | `wiki/sources/<source-id>.md` | Write a short source note, not packet content. |
| section, chapter, slide range, or teachable unit | `wiki/chapters/<chapter-slug>.md` | Main distilled knowledge surface. |
| evidence support, claim status, unresolved judgment | `reports/review/*` | Keep as audit/review support. |
| cross-source conclusion after chapter pages stabilize | optional synthesis page | Create only with a recorded reason. |
| concept, entity, comparison, or query object | optional research page | Defer unless it improves reuse, review, or downstream execution. |

## Source And Chapter Pages

Source pages are short notes about one source, deck, document, or packet. They
should include source identity, packet reference, structure summary, chapter
links, and important gaps or review notes. They should not repeat all extracted
text, full packet metadata, or every anchor.

Chapter pages are the main distilled knowledge surface. They should preserve
source order or deliberate chapter structure, cite packet anchors for important
claims, carry unresolved judgment into gaps/review sections, and stay compact
enough for agents to scan.

Chapter pages should not become claim/evidence tables, hide generated-evidence
uncertainty, merge unrelated source sections only by vocabulary, or split one
source chapter into many object pages without a recorded reason.

## Overview

`wiki/overview.md` is the current corpus map. It should answer:

- what the workspace covers
- which source groups matter
- where the main chapter path begins
- what coverage is missing
- what high-level review questions remain
- which reports or review queues matter now

Default sections:

- Corpus Map
- Important Sources Or Decks
- Chapter Structure
- Current Coverage
- Known Gaps And Review Items

Refresh the overview when scope, audience, major source groups, chapter
structure, coverage state, high-level gaps, review themes, or accepted
cross-source synthesis direction changes. Do not refresh it for typo-only edits
unless navigation, coverage, or accepted knowledge changes.

## Index

`wiki/index.md` is the primary content navigation entry. It is not the
chronological log.

Required behavior:

- read it before answering questions or modifying wiki pages
- update it after accepted page creation, deletion, major retitle, move, or
  merge
- inspect it during every wiki construction round
- group entries by page type or domain category
- keep entries short and scannable
- treat missing or stale entries as lint/validation findings

Use one link convention consistently, as configured in `schema.md`. A common
shape is:

```text
- [[page-slug]] - one-line purpose or summary
```

Default document-corpus sections:

- Overview
- Sources Or Decks
- Chapters
- Reports And Review
- Optional Synthesis

Research-style sections such as Concepts, Entities, Comparisons, Synthesis, or
Open Questions are optional and should appear only when they improve reuse,
review, or downstream execution.

Index accepted pages and important active reports. Do not index every raw file,
source packet anchor, evidence row, or claim row.

Special pages:

- `wiki/index.md`
- `wiki/log.md`
- `wiki/overview.md`

`overview.md` should still be discoverable from the index. `index.md` and
`log.md` do not need normal content entries.

## Wiki Log

`wiki/log.md` records chronological wiki-facing events. Entries should include
date, target, sources or packets touched, construction analysis path, page
decisions, reports or validation notes, review changes, and commit/push status
when known.

Update it when a round creates, updates, merges, retitles, deletes, or
explicitly leaves wiki pages unchanged; changes overview or index; creates
gating reports; changes review status; or carries unresolved review forward.

Keep the log short. Link reports instead of copying them.

## Optional Pages And Merge Rules

Optional synthesis pages are allowed only after relevant chapter pages exist,
the synthesis is source-backed, it improves navigation or downstream reuse, and
the reason is recorded.

Optional research pages such as concepts, entities, comparisons, and queries
are not default output for document/PPT corpora.

Before creating a new page:

1. Read `wiki/index.md`.
2. Search existing wiki pages for the intended topic or source.
3. Update an existing page when the scope matches.
4. Create a new page only when the scope is distinct.
5. Record the reason when routing is not obvious.

## Review Routing

Route content to review instead of wiki prose when support is missing, evidence
is generated and important, sources conflict, page scope is unclear, a proposed
page duplicates an existing page, or a claim/evidence map marks the claim as
unsupported, contested, stale, or needs review.

## Closure Surface

Before closing a wiki construction round, record compare report path and
status, closure decision, overview/index/log status, validation note path,
active report or review links when needed, carried-forward review items, and
next action or next round.

If overview or index did not change, record that the round inspected them and
why no update was needed.

## Acceptance Criteria

- proposed wiki updates have routing decisions
- source pages remain short source notes
- chapter pages remain the primary distilled knowledge surface
- claim/evidence maps remain reports, not page bodies
- construction analysis records page decisions
- optional synthesis or research pages have recorded reasons
- index entries make the default reading path visible
- content pages have index entries unless treated as special pages
- index entries resolve
- overview remains a concise corpus map
- wiki log remains chronological and short
- stale navigation or log omissions become validation findings
- reports are linked instead of copied
- closure decisions remain discoverable from validation note and wiki log

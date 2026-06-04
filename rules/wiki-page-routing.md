# Wiki Page Routing

Wiki page routing decides where source packet knowledge should live before an
agent writes or updates wiki prose.

Use this rule after source packets and, when available, claim/evidence maps are
ready. Use it before `source-packet-to-wiki` generation.

## Purpose

Prevent wiki construction from drifting into duplicate packets, duplicate
claim/evidence maps, or fragmented research-object pages.

Required path:

```text
source packet
+ claim/evidence map
+ review queue
-> routing decision
-> wiki construction analysis
-> accepted wiki updates
```

## Inputs

Routing should inspect:

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

This is the default surface because it preserves source and chapter
readability while keeping audit artifacts separate.

## Routing Table

| Input content | Default destination | Rule |
| --- | --- | --- |
| whole-corpus status, source groups, coverage state | `wiki/overview.md` | Keep concise; link to chapters, sources, and reports. |
| navigation for accepted pages | `wiki/index.md` | Keep content-oriented and scannable. |
| one source/deck/document identity | `wiki/sources/<source-id>.md` | Write a short source note, not packet content. |
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

## Overview Rules

Use `wiki/overview.md` as a corpus map.

It should answer:

- what the workspace covers
- which major sources or decks matter
- what the current chapter structure is
- what coverage is still missing
- what review questions affect the whole corpus

It should not be a final synthesis or a replacement for chapter pages.

## Index Rules

Use `wiki/index.md` as the navigation contract.

It should link accepted pages and active reports in a predictable order:

```text
Overview
Sources
Chapters
Reports And Review
Optional Synthesis
Optional Research Pages
```

Do not index every raw source, every source packet anchor, or every
claim/evidence row. Index pages and important active reports.

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

## Acceptance Criteria

- each proposed wiki update has a routing decision
- source pages remain short source notes
- chapter pages remain the primary distilled knowledge surface
- claim/evidence maps remain reports, not page bodies
- optional synthesis or research pages have recorded reasons
- index entries make the default reading path visible

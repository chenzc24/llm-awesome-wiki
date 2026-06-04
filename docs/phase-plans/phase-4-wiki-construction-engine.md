# Phase 4 Wiki Construction Engine

Phase 4 defines how source packets and the Phase 3 claim/evidence layer become
agent-readable, human-reviewable wiki pages.

This phase starts wiki construction workflow design. It does not implement a
wiki generator, wiki-lint tool, compare gate, schema hardening, validator, or
downstream `skill + tool` workflow.

## Position In The Pipeline

```text
raw source
-> source inventory
-> source packet
-> evidence and claim layer
-> wiki construction
-> compare and review gates
-> stable release/spec layer
-> later downstream skill + tool artifacts
```

Phase 4 consumes:

- valid source packets
- source packet anchors
- claim/evidence maps when important claims are in scope
- review queues and unresolved judgment from Phase 3
- existing wiki overview, index, source pages, and chapter pages

## Core Goal

The wiki should be the primary agent-readable knowledge layer.

For document and PPT corpora, the default reading path is:

```text
wiki/overview.md
-> wiki/index.md
-> wiki/chapters/*
-> wiki/sources/*
```

This default preserves source/chapter readability. It should not be replaced by
a fragmented concept/entity graph or by claim/evidence audit artifacts.

## Page Roles

| Page or artifact | Primary role |
| --- | --- |
| `wiki/overview.md` | Concise corpus map and current coverage picture. |
| `wiki/index.md` | Navigation contract for accepted wiki pages and active reports. |
| `wiki/chapters/*` | Main distilled knowledge surface. |
| `wiki/sources/*` | Short source or deck notes that point to packets and chapters. |
| `reports/review/*` | Claim/evidence maps, review queues, and unresolved judgment. |
| `reports/compare/*` | Later source/wiki/claim alignment reports. |
| optional synthesis pages | Cross-source conclusions after source/chapter pages are stable. |
| optional research pages | Concepts, entities, comparisons, or queries only when needed. |

## Phase 4.1 Active Scope

Phase 4.1 defines page routing and reading-surface rules.

It answers:

- when should content update `wiki/overview.md`?
- when should content create or update a source page?
- when should content create or update a chapter page?
- what belongs in reports/review instead of wiki pages?
- when is optional synthesis allowed?
- when should optional research pages stay deferred?
- how should index entries make the default reading path obvious?

Phase 4.1 intentionally stops before full source/chapter template hardening.
That belongs to Phase 4.2.

## Required Construction Flow

```text
source packet and claim/evidence input
-> page routing decision
-> wiki construction analysis
-> create or update accepted pages
-> update index and log
-> record validation or review handoff
```

Do not skip directly from source packet to final page prose.

## Design Constraints

- Source pages must not become second source packets.
- Chapter pages must not become claim/evidence tables.
- Claim/evidence maps remain audit and review support.
- Overview must remain concise enough to scan.
- Index must make accepted pages discoverable.
- Existing pages should be updated before duplicates are created.
- Optional synthesis should be introduced only when it improves cross-source
  understanding.
- Optional research pages should be introduced only when the corpus actually
  needs them.

## Person A Handoff

Person B should not edit `contracts/schemas/**` in Phase 4.1.

Potential Person A validation needs:

- page type validation for `overview`, `source`, `chapter`, and optional
  synthesis/research page types
- required frontmatter for source and chapter pages
- source reference shape in `sources`
- optional `claim_ids` and review item references
- index entry validation
- broken link checks between overview, index, source pages, and chapter pages

## Non-Goals

Phase 4.1 does not:

- generate wiki pages from real source packets
- harden all page templates
- implement wiki-lint or compare tools
- create schema or validator code
- create tests or fixtures
- make Obsidian required
- start downstream executable `skill + tool` work

## Completion Criteria

Phase 4.1 is complete when:

- page routing has an operational rule
- `source-packet-to-wiki` requires routing before generation
- index guidance supports the default reading path
- workspace wiki index and overview templates reflect the default surface
- source and chapter README guidance prevents source packet duplication and
  claim/evidence-map duplication
- logs record validation and commit status

## Next Subphase

After Phase 4.1, the next useful target is Phase 4.2: source/chapter page
template hardening.

Phase 4.2 should strengthen page templates and construction analysis reports,
but should keep the Phase 4.1 routing boundaries intact.

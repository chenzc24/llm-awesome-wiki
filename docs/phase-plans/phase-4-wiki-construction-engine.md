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

## Phase 4.1 Status

Status: complete from the Person B workflow-surface side.

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

## Phase 4.2 Status

Status: complete from the Person B workflow-surface side.

Phase 4.2 hardens source and chapter page templates.

It answers:

- what should a source page contain?
- what must a source page avoid duplicating?
- what should a chapter page contain?
- how should chapter pages use source packet anchors and claim/evidence maps?
- what construction analysis must be visible before generation?
- what review handoff remains outside wiki prose?

Phase 4.2 still does not implement a generator, validator, test fixture, or
wiki-lint command.

## Phase 4.3 Status

Status: complete from the Person B workflow-surface side.

Phase 4.3 defines the wiki construction round protocol.

It answers:

- how does a round choose a fixed input set?
- when must construction analysis be written?
- how are create, update, merge, leave-unchanged, report-only, and
  needs-review decisions recorded?
- when must `wiki/index.md` and `wiki/log.md` change?
- what must a validation note record?
- how does unresolved review carry forward?

Phase 4.3 still does not implement a generator, validator, compare gate,
fixture, or wiki-lint command.

## Phase 4.4 Status

Status: complete from the Person B workflow-surface side.

Phase 4.4 defines overview, index, and log maintenance.

It answers:

- when must `wiki/overview.md` refresh?
- how does `wiki/index.md` remain the navigation contract?
- what belongs in `wiki/log.md`?
- how are stale index entries and active reports handled?
- what overview/index/log status must validation notes record?

Phase 4.4 still does not implement a wiki-lint tool, compare gate, validator,
fixture, or link checker.

## Phase 4.5 Closure Status

Status: complete from the Person B workflow-surface side.

Phase 4.5 reviews Phase 4 against the core design principles and records the
Person A handoff for deterministic validation.

It confirms:

- the default wiki surface is source/chapter-oriented
- wiki construction uses routing and construction analysis before page prose
- claim/evidence maps remain audit support rather than the primary wiki
- overview, index, and log maintenance is part of round closure
- schema, validator, fixture, link check, and wiki-lint needs are handed to
  Person A or later implementation work

See `phase-4-closure-review.md` for the closure review and handoff details.

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

Person B should not edit `contracts/schemas/**` during Phase 4 workflow-surface
work unless a later target explicitly assigns that responsibility.

Potential Person A validation needs:

- page type validation for `overview`, `source`, `chapter`, and optional
  synthesis/research page types
- required frontmatter for source and chapter pages
- source reference shape in `sources`
- optional `claim_ids` and review item references
- index entry validation
- broken link checks between overview, index, source pages, and chapter pages
- overview refresh validation
- wiki log parseability
- validation note checks for overview, index, log, compare-gate status, stale
  entries, and unresolved review

The full Phase 4 handoff is recorded in `phase-4-closure-review.md`.

## Non-Goals

Current Phase 4 workflow-surface targets do not:

- generate wiki pages from real source packets
- harden all page templates
- implement wiki-lint or compare tools
- create schema or validator code
- create tests or fixtures
- make Obsidian required
- start downstream executable `skill + tool` work

## Phase 4.1 Completion Criteria

Phase 4.1 is complete when:

- page routing has an operational rule
- `source-packet-to-wiki` requires routing before generation
- index guidance supports the default reading path
- workspace wiki index and overview templates reflect the default surface
- source and chapter README guidance prevents source packet duplication and
  claim/evidence-map duplication
- logs record validation and commit status

## Phase 4.2 Completion Criteria

Phase 4.2 is complete when:

- source page template is clear, short, and anti-duplication oriented
- chapter page template is source-backed and readable
- construction analysis template exists before page generation
- report and schema guidance mention wiki construction analysis
- rules point agents to construction analysis after routing
- Phase 4.1 routing boundaries remain intact

## Phase 4.3 Completion Criteria

Phase 4.3 is complete when:

- wiki construction round protocol is documented
- `distillation-rounds.md` describes construction analysis and page
  create/update/merge decisions
- first-round plan and validation note templates require construction analysis
- workspace README, AGENTS, and wiki log guidance reflect the round rhythm
- compare status remains explicit when compare gates are not enabled

## Phase 4.4 Completion Criteria

Phase 4.4 is complete when:

- overview refresh triggers are documented
- index integrity rules are documented
- wiki log entry expectations are documented
- overview/index/log templates reflect their maintenance roles
- validation notes check overview/index/log status
- source-packet-to-wiki and distillation rounds mention overview/index/log
  closure requirements

## Phase 4.5 Completion Criteria

Phase 4.5 is complete when:

- Phase 4 closure review exists
- completed workflow surfaces from Phase 4.1 through Phase 4.4 are summarized
- design review confirms alignment with core principles
- Person A handoff lists schema, validator, fixture, and lint needs
- next phase boundary is Phase 5 compare gates and review workflow

## Next Phase Boundary

After Phase 4 closure, the next useful target is Phase 5: compare gates and
review workflow.

Phase 5 should define pass/fail/needs-review behavior for source coverage,
claim coverage, broken links, stale index entries, omissions, contradictions,
unresolved judgment, and round advancement. It should not start downstream
`skill + tool` work.

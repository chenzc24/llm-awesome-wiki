# Phase 5 Compare Gates And Review Workflow

Phase 5 defines how each distillation round produces checkable quality signals
before the workspace advances.

This phase is part of the knowledge-construction executable layer. It is not
downstream `skill + tool` generation, and it does not redesign the default
source/chapter wiki surface.

## Position In The Pipeline

```text
raw source
-> source inventory
-> source packet
-> evidence and claim layer
-> wiki construction
-> compare gates and review workflow
-> stable release/spec layer
-> later downstream skill + tool artifacts
```

Phase 5 consumes:

- source inventory
- source packet metadata and anchors
- claim/evidence maps when available
- review queues and unresolved judgment
- wiki construction analysis
- current `wiki/overview.md`
- current `wiki/index.md`
- current `wiki/log.md`
- accepted source, chapter, and optional synthesis/research wiki pages
- validation notes from construction rounds

## Core Goal

The compare gate protects raw-wiki alignment.

It should answer:

- which source packets and anchors were in scope?
- which source material is represented in accepted wiki pages?
- which important wiki claims cite source anchors or claim/evidence records?
- which modalities were skipped, generated, uncertain, or routed to review?
- which links, index entries, overview references, or log entries are stale?
- which omissions, contradictions, or unsupported statements need action?
- may the round advance as `pass`, `fail`, or `needs-review`?

The gate must not let an agent close a round only because the output looks
complete.

## Report Strategy

Phase 5 starts with one default compare report per round:

```text
reports/compare/<round-id>-compare-report.md
```

This report is the default decision surface. It may link to detailed coverage,
lint, claim audit, or review reports when a workspace needs more depth, but
Phase 5 should avoid report sprawl as the default.

The compare report is not a wiki page, not a source packet, and not a rewrite
instruction. It records findings, blockers, review needs, and next actions.

## Status Semantics

- `pass`: required deterministic or manual protocol checks passed, no blocking
  review item remains, and any carried-forward nonblocking review item has a
  reason and next action.
- `needs-review`: required artifacts are present, but human judgment is needed
  before the round can be accepted or advanced silently.
- `fail`: required artifacts are missing or broken, source/wiki alignment is
  materially broken, required links or index entries fail, important claims lack
  support or review routing, or the report cannot justify its own status.

`compare gate not enabled` is not `pass`.

Model self-evaluation is not `pass`.

## Gate Families

Phase 5 should define these gate families:

- source coverage
- source packet and anchor coverage
- wiki page coverage
- claim coverage
- modality coverage
- link, frontmatter, index, overview, and log checks
- omission checks
- contradiction checks
- review queue and carried-forward review checks
- round advancement decision

Some checks are deterministic today only in concept. Until Phase 6 tools exist,
Phase 5 can classify checks as:

- `deterministic`: can be checked mechanically now or later by a tool
- `manual-protocol`: a human or agent follows an explicit checklist
- `human-review`: semantic judgment is required

The report must distinguish these categories instead of hiding uncertainty.

## Phase 5.1 Active Scope

Phase 5.1 defines the compare report foundation.

It owns:

- main compare report sections
- pass, fail, and needs-review meanings
- deterministic, manual-protocol, and human-review check categories
- carried-forward review requirements
- validation-note integration
- report README guidance

Phase 5.1 does not implement:

- compare CLI tooling
- schema or validator changes
- fixtures
- source coverage algorithms
- link checking code
- wiki page rewrites
- downstream `skill + tool` artifacts

## Later Phase 5 Subphases

Recommended sequence after Phase 5.1:

1. Phase 5.2: source/wiki coverage and omission protocol.
2. Phase 5.3: claim, modality, and contradiction review protocol.
3. Phase 5.4: review queue workflow and carried-forward semantics.
4. Phase 5.5: round closure integration with validation note, index, overview,
   and log expectations.
5. Phase 5.6: Phase 5 closure review and Person A/Phase 6 handoff.

## Person A Handoff

Person B should not edit `contracts/schemas/**`, validator code, tools, tests,
or fixtures during Phase 5 workflow-surface work unless a later target
explicitly assigns that responsibility.

Potential Person A validation needs:

- compare report schema
- compare status enum: `pass`, `fail`, `needs-review`
- check category enum: `deterministic`, `manual-protocol`, `human-review`
- source coverage table validation
- claim coverage table validation
- modality coverage table validation
- review item linkage and carried-forward requirements
- link and index report validation
- fixture for a passing round
- fixture for missing source coverage
- fixture for unsupported wiki claim
- fixture for generated chart summary routed to review
- fixture for stale index link

## Non-Goals

Current Phase 5 workflow-surface targets do not:

- parse raw files
- generate source packets
- generate wiki pages
- silently rewrite wiki pages based on compare findings
- implement compare CLI tools
- implement schemas, validators, or fixtures
- make Obsidian required
- start downstream executable `skill + tool` work

## Phase 5.1 Completion Criteria

Phase 5.1 is complete when:

- the main Phase 5 plan exists
- the Phase 5.1 report-foundation plan exists
- compare report template exists
- compare gate rule defines report sections and status semantics
- review queue and validation note templates reference compare report outcomes
- report README explains where compare reports belong
- Person A handoff remains schema/validator/tool oriented and read-only from
  Person B

## Next Subphase

After Phase 5.1, the next useful target is Phase 5.2: source/wiki coverage and
omission protocol.

Phase 5.2 should define how a compare report records source packet coverage,
anchor coverage, wiki page coverage, omitted material, weak coverage, and
scope exclusions without requiring a full compare CLI implementation.

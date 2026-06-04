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

## Phase 5.1 Status

Status: complete from the Person B workflow-surface side.

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

## Phase 5.2 Status

Status: complete from the Person B workflow-surface side.

Phase 5.2 defines source/wiki coverage and omission semantics.

It owns:

- source packet coverage status
- anchor disposition language
- wiki page coverage status
- weak coverage and omission recording
- intentional scope exclusions
- source-to-wiki traceability tables
- validation-note coverage summary expectations

Phase 5.2 does not implement:

- source coverage algorithms
- claim coverage algorithms
- modality coverage algorithms
- contradiction analysis
- review queue workflow details
- compare CLI tooling
- schema or validator changes
- fixtures
- wiki page rewrites
- downstream `skill + tool` artifacts

## Phase 5.3 Status

Status: complete from the Person B workflow-surface side.

Phase 5.3 defines claim, modality, contradiction, and unsupported statement
semantics.

It owns:

- claim support status in compare reports
- generated evidence handling in compare reports
- modality coverage review language
- unsupported statement recording
- contradiction recording
- semantic review routing fields needed by compare reports
- validation-note summary expectations for claim/modality/contradiction findings

Phase 5.3 does not implement:

- claim extraction workflow redesign
- review queue workflow closure
- carried-forward review lifecycle details
- source/wiki coverage semantics from Phase 5.2
- link or frontmatter lint
- claim-audit CLI implementation
- compare CLI implementation
- schema or validator changes
- fixtures
- wiki page rewrites
- downstream `skill + tool` artifacts

## Phase 5.4 Active Scope

Phase 5.4 defines review queue lifecycle and carried-forward semantics.

It owns:

- review item lifecycle states
- blocking level semantics
- review item creation from compare findings
- review resolution and dismissal rules
- carried-forward review requirements
- stale review detection
- re-entry into later compare rounds
- validation-note summary expectations for review state

Phase 5.4 does not implement:

- source/wiki coverage semantics from Phase 5.2
- claim/modality/contradiction semantics from Phase 5.3
- round closure integration with overview, index, log, and validation notes
- review export CLI implementation
- compare CLI implementation
- schema or validator changes
- fixtures
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
- coverage disposition enum: `covered`, `weak`, `deferred`, `omitted`,
  `out-of-scope`, `review`, `blocked`
- source importance enum: `core`, `supporting`, `reference`, `decorative`,
  `unknown`
- omission reason enum: `decorative`, `duplicate`, `out-of-scope`,
  `low-value`, `deferred`, `blocked`, `superseded`
- source coverage table validation
- anchor disposition table validation
- wiki page coverage table validation
- claim coverage table validation
- claim support status enum: `supported`, `weak`, `unsupported`, `contested`,
  `generated-derived`, `reviewed-generated`, `needs-review`, `not-in-scope`
- generated evidence state enum: `source-derived`, `extracted-with-tool`,
  `generated`, `reviewed-generated`, `unsupported-or-unknown`
- modality state enum: `source-derived`, `extracted-with-tool`, `generated`,
  `reviewed-generated`, `skipped`, `failed`, `unsupported-or-unknown`
- contradiction type enum: `source-vs-source`, `source-vs-wiki`,
  `claim-vs-claim`, `wiki-vs-wiki`, `generated-vs-source`,
  `old-review-vs-new-source`
- unsupported statement table validation
- modality coverage table validation
- review item lifecycle enum: `open`, `in-review`, `resolved`, `dismissed`,
  `carried-forward`, `blocked`, `stale`
- blocking level enum: `blocking`, `nonblocking`, `informational`
- dismissal reason enum: `duplicate`, `out-of-scope`, `incorrect-reference`,
  `superseded`, `informational-only`, `no-longer-relevant`
- review item linkage and carried-forward requirements
- link and index report validation
- fixture for a passing round
- fixture for missing source coverage
- fixture for a 30-slide PPT with grouped slide coverage
- fixture for omitted decorative content
- fixture for omitted important chart without reason
- fixture for unsupported wiki claim
- fixture for generated chart summary routed to review
- fixture for reviewed-generated chart claim
- fixture for source-vs-source contradiction
- fixture for wiki claim narrowed after weak evidence
- fixture for blocking generated-evidence review
- fixture for nonblocking carried-forward review
- fixture for stale review after source packet change
- fixture for dismissed duplicate review item
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

## Phase 5.2 Completion Criteria

Phase 5.2 is complete when:

- the Phase 5.2 phase plan exists
- source/wiki coverage rule exists
- compare gate rule includes disposition, omission, and scope-exclusion
  semantics
- compare report template records source coverage, anchor disposition, wiki
  page coverage, weak coverage, omissions, and scope exclusions
- validation note template summarizes coverage and omission findings
- Person A handoff lists coverage/disposition schema and fixture needs

## Phase 5.3 Completion Criteria

Phase 5.3 is complete when:

- the Phase 5.3 phase plan exists
- claim/modality/contradiction review rule exists
- compare gate rule includes claim support, generated evidence, modality, and
  contradiction semantics
- compare report template records claim support, modality review, unsupported
  statement, and contradiction findings
- claim/evidence map and review queue templates can carry generated evidence
  and contradiction review handoff
- validation note template summarizes claim/modality/contradiction findings
- Phase 5 main plan identifies Phase 5.4 as the next review queue lifecycle
  target

## Phase 5.4 Completion Criteria

Phase 5.4 is complete when:

- the Phase 5.4 phase plan exists
- review queue workflow rule exists
- compare gate rule includes review lifecycle and carry-forward semantics
- review queue template records lifecycle state, blocking level, resolution,
  dismissal, carry-forward, stale, and re-entry information
- compare report and validation note templates summarize review lifecycle state
- Phase 5 main plan identifies Phase 5.5 as the next round-closure integration
  target

## Next Subphase

After Phase 5.4, the next useful target is Phase 5.5: round closure
integration with validation note, index, overview, and log expectations.

Phase 5.5 should define how compare status, review status, validation notes,
wiki index, overview, and wiki log together decide whether a round can close or
advance.

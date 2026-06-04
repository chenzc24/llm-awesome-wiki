# Phase 5.4 Review Queue Carry Forward Workflow

Phase 5.4 defines the review queue lifecycle for compare-gate findings.

This stage answers: when a compare report finds unresolved judgment, how does
the workspace keep that judgment visible until it is resolved, dismissed, or
explicitly carried forward?

## Scope

Phase 5.4 owns:

- review item lifecycle states
- blocking level semantics
- review item creation from compare findings
- review resolution and dismissal rules
- carried-forward review requirements
- stale review detection
- re-entry into later compare rounds
- validation-note summary expectations for review state

Phase 5.4 does not own:

- source/wiki coverage semantics from Phase 5.2
- claim/modality/contradiction semantics from Phase 5.3
- round closure integration with overview, index, log, and validation notes
- review export CLI implementation
- compare CLI implementation
- schema or validator changes
- fixtures
- wiki page generation or rewriting

## Core Principle

Unresolved judgment must stay visible.

A review item is not a polished explanation layer. It is a decision queue that
prevents agents from treating uncertain source coverage, generated evidence,
weak claims, contradictions, omissions, or stale decisions as accepted truth.

## Review Lifecycle

Use these lifecycle states:

- `open`: decision still needed
- `in-review`: reviewer or owner is actively deciding
- `resolved`: decision recorded and affected artifacts updated or scheduled
- `dismissed`: concern no longer applies and reason is recorded
- `carried-forward`: not resolved this round, but explicitly kept visible
- `blocked`: cannot be resolved until another artifact or review exists
- `stale`: previous decision may no longer be valid because source, packet,
  claim, wiki, or review context changed

Do not delete open, blocked, stale, or carried-forward items just because a
round's wiki prose looks complete.

## Blocking Levels

Use these blocking levels:

- `blocking`: the round must not advance as `pass`
- `nonblocking`: the round may advance only if the carry-forward reason and
  next action are explicit
- `informational`: tracked context that does not affect advancement

Blocking level is not permanent. A review item can move from `blocking` to
`nonblocking` only when the reason and next action are recorded.

## Review Item Creation

Create or update a review item when compare finds:

- unsupported important claim
- weak claim support
- generated evidence supporting an important claim
- modality interpretation that affects accepted wiki knowledge
- omitted core source content
- contradiction
- stale source packet, claim, wiki page, or review decision
- scope question that affects round acceptance
- broken or missing artifact that requires human decision rather than a simple
  mechanical fix

Each review item should identify:

- review item id
- type
- origin compare report or finding
- source references when available
- affected claim, wiki page, report, or source packet
- decision needed
- current status
- blocking level
- owner or next action
- target round or condition for resolution

## Resolution Rules

A review item can be marked `resolved` only when the decision is explicit.

A resolution should record:

- decision
- reviewer or accepted decision source
- affected artifacts
- source references reviewed
- claims, wiki pages, or reports updated or scheduled
- whether claim wording was narrowed, rejected, accepted, or deferred
- whether generated evidence was accepted or rejected

Resolved items may remain in the queue history for audit, but they should not
count as open blockers.

## Dismissal Rules

Dismiss a review item only when the concern no longer applies.

Acceptable dismissal reasons:

- duplicate of another review item
- source or claim was removed from scope
- issue was based on an incorrect reference
- source was superseded and the replacement is recorded
- item is informational and no longer useful

Dismissal must include a reason. Do not use dismissal to hide unresolved
semantic judgment.

## Carried-Forward Rules

Unresolved review may carry forward only when the item records:

- reason for carry-forward
- blocking level
- owner or next action
- target round or condition for resolution
- affected artifacts
- whether the item blocks `pass`

`blocking` carried-forward items prevent `pass`.

`nonblocking` carried-forward items may allow advancement only when the compare
report and validation note say why advancement is acceptable.

## Stale Review

Mark a review item `stale` when:

- source packet hash or metadata changed
- source anchor changed or disappeared
- claim wording changed
- wiki page moved, merged, or rewrote the affected statement
- a newer review decision contradicts the old one
- the item has carried forward beyond its target round or condition

Stale review should re-enter compare as a finding. It should not quietly remain
in the queue as historical noise.

## Re-Entry Into Compare

Every later compare round should inspect relevant open, blocked, stale, and
carried-forward review items.

The compare report should record:

- review items opened this round
- review items resolved this round
- review items dismissed this round
- review items carried forward
- review items that re-entered compare
- review items that changed blocking level

## Person A Handoff

Potential Person A needs after Phase 5.4:

- review item lifecycle enum
- blocking level enum
- dismissal reason enum
- validator rule that carried-forward items require reason and next action
- validator rule that blocking carried-forward items prevent `pass`
- validator rule that resolved items include a decision and affected artifacts
- validator rule that dismissed items include a reason
- fixture for blocking generated-evidence review
- fixture for nonblocking carried-forward review
- fixture for stale review after source packet change
- fixture for dismissed duplicate review item

Person B should keep these as workflow needs until Person A accepts schema and
validator ownership.

## Completion Criteria

Phase 5.4 is complete when:

- the phase plan defines review item lifecycle and blocking semantics
- review queue workflow rule exists
- compare gate rule includes review lifecycle and carry-forward semantics
- review queue template records lifecycle state, blocking level, resolution,
  dismissal, carry-forward, stale, and re-entry information
- compare report and validation note templates summarize review lifecycle state
- Phase 5 main plan identifies Phase 5.5 as the next round-closure integration
  target

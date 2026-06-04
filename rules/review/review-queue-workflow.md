# Review Queue Workflow

This rule defines how review items open, resolve, dismiss, carry forward, and
re-enter later compare rounds.

Use it during compare and validation work whenever deterministic checks cannot
decide or human judgment is required.

This is a workflow protocol. It is not a review export tool, schema, validator,
or wiki rewrite command.

## Purpose

Review queues keep unresolved judgment visible.

They prevent agents from silently accepting:

- generated evidence
- weak claims
- unsupported statements
- contradictions
- omitted core source content
- modality interpretation
- stale review decisions
- scope questions

## Lifecycle States

Use these review item statuses:

| status | meaning |
| --- | --- |
| `open` | decision still needed |
| `in-review` | owner or reviewer is actively deciding |
| `resolved` | decision recorded and affected artifacts updated or scheduled |
| `dismissed` | concern no longer applies and reason is recorded |
| `carried-forward` | unresolved but explicitly kept visible for a later round |
| `blocked` | cannot be resolved until another artifact or review exists |
| `stale` | previous decision may no longer be valid |

Do not remove unresolved items from the queue merely because they are
inconvenient.

## Blocking Levels

Use these blocking levels:

| blocking_level | meaning |
| --- | --- |
| `blocking` | affected round cannot advance as `pass` |
| `nonblocking` | round may advance only with explicit carry-forward reason and next action |
| `informational` | tracked context that does not affect advancement |

When in doubt, use `blocking` until the reason for nonblocking carry-forward is
recorded.

## Required Review Item Fields

Each review item should record:

- `review_item_id`
- `type`
- `origin`
- `source_refs`
- `affected_target`
- `status`
- `blocking_level`
- `decision_needed`
- `owner_or_next_action`
- `target_round_or_condition`
- `opened_in_round`
- `last_seen_in_compare`

Use source references in `<source_id>#<anchor_id>` form when available.

## Opening Or Updating Review Items

Create or update a review item when compare finds:

- important claim lacks support
- claim support is weak
- generated-derived claim needs review
- modality interpretation affects accepted knowledge
- contradiction needs decision
- core source content is omitted without safe reason
- source scope is unclear
- review decision may be stale

If a matching review item already exists, update it instead of creating a
duplicate.

## Resolution

Mark a review item `resolved` only when a decision exists.

Record:

- decision
- reviewer or decision source
- affected artifacts
- source references reviewed
- updated claims or wiki pages
- rejected or narrowed wording when relevant
- generated evidence accepted or rejected when relevant

Resolved items should appear in the queue history, but they should not count as
open blockers.

## Dismissal

Use `dismissed` only when the concern no longer applies.

Acceptable dismissal reasons:

- `duplicate`
- `out-of-scope`
- `incorrect-reference`
- `superseded`
- `informational-only`
- `no-longer-relevant`

Dismissal requires a reason. Do not dismiss unresolved semantic judgment.

## Carry Forward

Use `carried-forward` when a round cannot resolve the item but must keep it
visible.

Every carried-forward item must record:

- reason
- blocking level
- owner or next action
- target round or condition
- affected artifacts
- whether it blocks `pass`

Blocking carried-forward items prevent `pass`.

Nonblocking carried-forward items may allow advancement only when the compare
report and validation note explain why.

## Stale Review

Mark a review item `stale` when:

- source packet hash, metadata, or anchors changed
- claim wording changed
- wiki page moved, merged, or rewrote the affected statement
- newer source material contradicts the decision
- the target round or resolution condition passed without action

Stale review items should re-enter compare as findings.

## Re-Entry

Each relevant compare round should inspect:

- open review items
- blocked review items
- stale review items
- carried-forward review items
- items affecting changed wiki pages or source packets

The compare report should record which items re-entered the round and whether
their blocking level changed.

## Acceptance Criteria

- every review item has status and blocking level
- every open or in-review item has a decision needed and next action
- every resolved item has a decision and affected artifacts
- every dismissed item has a reason
- every carried-forward item has reason, next action, and target round or
  condition
- blocking carried-forward items prevent `pass`
- stale items re-enter compare instead of becoming historical noise

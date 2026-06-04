# Round Closure Workflow

Round closure decides whether a distillation round can be accepted, accepted
with carried-forward review, or kept open because blocking findings remain.

This is a workflow protocol. It is not a validator implementation, compare
tool, link checker, schema, fixture, or wiki generation step.

## Purpose

Closure keeps the accepted workspace state visible.

It integrates:

- round plan
- source packet scope
- wiki construction analysis when wiki pages changed
- compare report
- validation note
- review queue
- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`

Do not use closure to hide unresolved judgment or to upgrade a missing compare
gate into `pass`.

## Closure Decisions

Use these decisions:

| closure_decision | meaning |
| --- | --- |
| `close-pass` | round can close and advance normally |
| `close-with-review` | round can close only with explicit carried-forward review |
| `do-not-close` | round cannot close until blocking findings are fixed |

These decisions do not replace compare status. They summarize whether the whole
round state is acceptable after compare, review, validation, index, overview,
and log checks are considered together.

## Required Closure Packet

The closure packet is a conceptual bundle of existing artifacts. Do not create a
new default file only to hold it.

Record the following in the validation note or wiki log:

- round plan path
- fixed source packet or wiki area scope
- construction analysis path when wiki pages changed
- compare report path and status
- validation note path and closure decision
- review queue path and status when unresolved judgment exists
- review items created, resolved, dismissed, stale, or carried forward
- `wiki/index.md` update status or no-change reason
- `wiki/overview.md` update status or no-change reason
- `wiki/log.md` entry status
- active reports linked from `wiki/index.md`
- next action or next round

## Close Pass

Use `close-pass` only when:

- compare status is `pass`
- validation note exists and records the checks performed
- no blocking review item remains
- no `blocking` carried-forward review remains
- source/wiki coverage and claim support in scope are explainable
- generated or model-assisted evidence is marked or reviewed
- index links for accepted pages and active reports resolve or failures are
  absent from scope
- overview was refreshed when needed or a no-change reason exists
- wiki log records the round

`compare gate not enabled` is not `close-pass`.

Model self-evaluation is not `close-pass`.

## Close With Review

Use `close-with-review` only when:

- compare status is `needs-review`
- required artifacts are present
- there is no structural failure that prevents review
- all carried-forward review items have reason, owner or next action, and
  target round or condition
- blocking level is recorded for each carried-forward item
- validation note explains why the round can close with review
- wiki log records the unresolved review state
- active compare or review reports are linked from the index when later readers
  need them

`close-with-review` is not a clean pass. Later rounds must read the carried
review state before treating affected knowledge as stable.

## Do Not Close

Use `do-not-close` when:

- compare status is `fail`
- compare report is missing for a round that requires compare
- validation note is missing
- review queue is missing while unresolved judgment exists
- blocking review remains unresolved
- carried-forward review lacks reason, owner or next action, target round, or
  blocking level
- index, overview, or wiki log status is missing or materially stale
- important source coverage, claim support, generated evidence, modality,
  omission, contradiction, or link findings remain unhandled

Do not advance a `do-not-close` round. Fix the blocker or change scope and log
the reason.

A `do-not-close` round must not close or advance by being relabeled as
`needs-review`.

## Index, Overview, And Log

Before closure:

- inspect `wiki/index.md`
- inspect `wiki/overview.md`
- update `wiki/log.md`

If the index or overview does not change, record the no-change reason in the
validation note.

If active reports or review queues affect current use of the wiki, link them
from the index. Do not link every historical report by default.

The wiki log should stay short. Record status and links, not copied report
content.

## Advancement

A round can advance normally only after `close-pass`.

A round can advance with known review only after `close-with-review`, and only
when the next plan accepts that carried-forward state.

A round with `do-not-close` cannot advance until blocking findings are fixed or
scope is changed and logged.

## Acceptance Criteria

- every closed round has a closure decision
- closure decision matches compare status and review state
- validation note records the closure packet
- index, overview, and wiki log status is explicit
- active review and compare reports remain discoverable when they matter
- `close-pass` is never used with missing compare, blocking review, or stale
  navigation

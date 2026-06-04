# Phase 5.5 Round Closure Integration

Phase 5.5 defines how a distillation round closes.

This stage integrates the compare report, review queue, validation note,
`wiki/index.md`, `wiki/overview.md`, and `wiki/log.md` into one closure
decision. It does not add a new default report family. The closure decision is
recorded across the existing round artifacts.

## Scope

Phase 5.5 owns:

- round closure decision semantics
- required closure evidence
- relationship between compare status and round advancement
- review queue carry-forward requirements at closure time
- validation note summary requirements
- index, overview, and wiki log closure requirements
- active report and review queue linking expectations

Phase 5.5 does not own:

- source/wiki coverage semantics from Phase 5.2
- claim/modality/contradiction semantics from Phase 5.3
- review item lifecycle details from Phase 5.4
- compare CLI implementation
- review export implementation
- link checker implementation
- schemas or validators
- fixtures
- wiki page generation
- downstream `skill + tool` artifacts

## Core Principle

A round can close only when its accepted state is visible.

The workspace must show:

- what source material was in scope
- what wiki pages or reports changed
- what compare status was reached
- what review remains unresolved
- whether unresolved review blocks `pass`
- whether index, overview, and log were updated or inspected
- what must happen next

Do not close a round because the generated wiki prose looks complete.

## Closure Decisions

Use these closure decisions in validation notes and logs:

| closure_decision | meaning |
| --- | --- |
| `close-pass` | round can close and advance normally |
| `close-with-review` | round can close only with explicit carried-forward review |
| `do-not-close` | round cannot close until blocking findings are fixed |

`close-pass` requires:

- compare status is `pass`
- no blocking review item remains
- no `blocking` carried-forward review remains
- required validation note exists
- `wiki/index.md`, `wiki/overview.md`, and `wiki/log.md` were updated or
  inspected with no-change reasons
- accepted active reports or review queues are linked from `wiki/index.md`
  when needed

`close-with-review` requires:

- compare status is `needs-review`
- no structural failure prevents review
- all carried-forward review items have reason, owner or next action, and
  target round or condition
- blocking items are not mislabeled as nonblocking
- validation note records why the round may close with review
- `wiki/log.md` records the carry-forward state
- `wiki/index.md` links active review or compare reports when they matter for
  the next reader

`do-not-close` applies when:

- compare status is `fail`
- compare gate is missing where the round requires it
- validation note is missing or cannot justify closure
- source/wiki coverage, claim support, modality handling, link integrity,
  index integrity, overview refresh, or wiki log status is materially broken
- blocking review remains unresolved
- carried-forward review lacks reason, owner or next action, or target round or
  condition

`compare gate not enabled` is not `close-pass`.

## Closure Packet

The closure packet is the set of existing artifacts that justify the closure
decision. It is a conceptual bundle, not a required new file.

It should include:

- round plan path
- source packets in scope
- wiki construction analysis path when wiki pages changed
- compare report path and status
- validation note path and closure decision
- review queue path and status when unresolved judgment exists
- index update or no-change reason
- overview update or no-change reason
- wiki log entry path or heading
- commit and push status when known

The validation note should summarize the closure packet. The wiki log should
record it in short form.

## Index, Overview, And Log Expectations

`wiki/index.md` must represent the accepted navigation state:

- accepted source and chapter pages are linked once
- active compare, validation, or review reports are linked when they affect
  current use
- stale links are removed or recorded as findings

`wiki/overview.md` must represent the current corpus map:

- refresh it when corpus scope, chapter structure, coverage, or high-level
  review themes changed
- otherwise record a no-change reason in the validation note

`wiki/log.md` must record the round:

- source packets or wiki areas touched
- page decisions
- compare status
- closure decision
- review created, resolved, dismissed, or carried forward
- active reports
- commit and push status when known

## Advancement Rules

A closed round can advance normally only with `close-pass`.

A round with `close-with-review` may advance only to a target that explicitly
accepts the carried-forward review state. It must not be treated as a clean
pass.

A `do-not-close` round must fix the blocking findings or change scope and log
the reason before advancing.

A round with `do-not-close` must not close by treating unresolved blockers as
ordinary review.

## Person A Handoff

Potential Person A needs after Phase 5.5:

- validation rule that closure decisions use only `close-pass`,
  `close-with-review`, or `do-not-close`
- validator rule that `close-pass` requires compare `pass`
- validator rule that `close-with-review` requires compare `needs-review`
  plus carried-forward review fields
- validator rule that blocking review prevents `close-pass`
- validator rule that validation notes include closure packet fields
- link/index fixture for active compare and review report links
- fixture for close-pass
- fixture for close-with-review
- fixture for do-not-close caused by stale index
- fixture for do-not-close caused by missing validation note

## Completion Criteria

Phase 5.5 is complete when:

- the Phase 5.5 phase plan exists
- round closure workflow rule exists
- compare gate and distillation round rules include closure decision semantics
- overview/index/log rules include closure expectations
- compare report and validation note templates expose closure fields
- wiki index, overview, and log templates can record closure state
- Phase 5 main plan identifies Phase 5.6 as the closure review and handoff
  target

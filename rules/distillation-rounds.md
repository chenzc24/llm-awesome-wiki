# Distillation Rounds

Knowledge construction should happen in small rounds. A round has a fixed input
set, planned outputs, validation, and a log entry.

Small rounds do not mean starting from a narrow fragment blindly. A new
workspace or major new source set must first run an overview-first
initialization pass: read broadly enough to understand the source landscape,
write a high-level overview, create the initial project/wiki skeleton, and plan
the staged distillation sequence.

## Overview-First Initialization

Run this pass before detailed wiki distillation when a workspace is new or when
a large new source set enters the workspace.

Required inputs:

- `purpose.md`
- `schema.md`
- source inventory or source list
- raw sources or source packets selected for the initial scope

Required outputs:

- broad source readthrough notes or inventory observations
- `wiki/overview.md` with the current global picture
- skeleton `wiki/index.md`
- initial wiki directory/page-type structure
- staged distillation plan under `plan/`
- initial gaps, risks, and review questions

The overview pass is not a final synthesis. It is a map of the territory so
later rounds can be deliberately scoped.

## Round Steps

1. Confirm the overview-first initialization exists when the workspace or
   source set is new.
2. Plan the round from the staged distillation plan.
3. Confirm workspace Git status.
4. Select source packets or wiki areas to process.
5. Read `purpose.md`, `schema.md`, `wiki/overview.md`, `wiki/index.md`, and
   existing relevant wiki pages.
6. Apply page routing before writing page prose.
7. Write wiki construction analysis for wiki-facing work.
8. Select evidence and claim candidates when the round contains important
   sourced knowledge.
9. Route unsupported, generated-derived, contested, or judgment-heavy claims to
   review.
10. Create, update, merge, leave unchanged, or defer wiki pages according to
    the construction analysis.
11. Refresh `wiki/overview.md` when corpus map, coverage, or chapter structure
    changed.
12. Update `wiki/index.md` and `wiki/log.md`.
13. Run lint and compare checks available for the workspace, or record that
    they are not enabled.
14. Record review items and validation notes.
15. Decide round closure as `close-pass`, `close-with-review`, or
    `do-not-close`.
16. Commit only an accepted `close-pass` or allowed `close-with-review` result.

## Round Plan

The plan should state:

- target and reason
- fixed input set
- relationship to the overview and staged distillation plan
- expected pages, reports, and records
- expected routing decisions and construction analysis report
- expected create, update, merge, leave-unchanged, report-only, or needs-review
  page decisions
- expected evidence/claim map updates when important claims are in scope
- expected index and wiki log updates
- expected overview refresh decision
- validation commands or manual checks
- expected closure decision surface
- commit intent

Changing the input set mid-round should be recorded in the plan or log.

## Staged Distillation Plan

The staged plan should break the source set into reviewable work packages.

Each stage should state:

- source packets, decks, chapters, or source groups in scope
- expected wiki sections or page types
- expected compare/lint checks
- likely review questions
- dependency on earlier stages
- stop condition for advancing

The staged plan may evolve, but changes should be logged. Do not use the plan as
a promise that the final wiki is already complete; use it as a control surface
for incremental work.

## Round Boundaries

- Do not process the whole knowledge base in one pass unless the workspace is
  tiny and the plan says so.
- Do not begin detailed page generation for a new source set until an overview,
  skeleton index, and staged plan exist.
- Do not write final wiki prose before page routing and construction analysis.
- Do not mix raw conversion, wiki distillation, compare gates, and downstream
  code generation into the same round.
- Do not use a clean-looking generated page as evidence that source coverage is
  sufficient.

## Wiki Construction Round Protocol

A wiki construction round is a specific kind of distillation round.

Required inputs:

- fixed source packet set
- claim/evidence maps when important claims are in scope
- review queue or review reports when unresolved judgment exists
- current `wiki/overview.md`
- current `wiki/index.md`
- existing source and chapter pages in the target area

Required outputs:

- wiki construction analysis
- source or chapter page creates, updates, merges, or deferrals
- overview refresh or recorded no-change reason
- `wiki/index.md` update when accepted pages change
- `wiki/log.md` entry
- validation note
- review queue updates when judgment remains unresolved

The construction analysis should record whether each target is `create`,
`update`, `merge`, `leave-unchanged`, `report-only`, or `needs-review`.

If a compare gate or wiki-lint tool is not enabled, record that explicitly in
the validation note. Do not convert a missing gate into a pass.

## Round Log

Each round should leave a short log entry with:

- date
- target
- source packets, deck notes, chapter pages, or optional research pages touched
- construction analysis path when wiki pages are created or updated
- page decisions: created, updated, merged, deferred, or left unchanged
- evidence and claim map updates when used
- overview/index/log changes or no-change reasons
- stale index entries found or cleared
- reports produced
- compare status
- closure decision
- review items created or resolved
- validation run
- commit hash when available

## Report Expectations

Each round should leave at least one report or explicit validation note:

- source inventory or packet status for raw-facing work
- construction analysis status for wiki-facing work
- overview, index, and log status for wiki-facing work
- claim/evidence map status when important source-backed claims are created or
  updated
- lint or index status for wiki-facing work
- compare status before advancing to the next round
- review queue status when judgment is unresolved
- closure decision and next action

## Completion Criteria

A round is complete when all intended files are updated, validation is recorded,
review items are visible, closure decision is recorded, and the accepted diff
is committed.

For wiki construction rounds, completion also requires construction analysis,
overview/index/log status, index/log updates for accepted page changes, and a
validation note that records page decisions, compare status, review
carry-forward, and closure decision.

For rounds that create or update important claims, completion also requires
evidence references or review routing. A clean-looking wiki page is not proof
that claim support is sufficient.

For the initialization pass, completion also requires `wiki/overview.md`,
`wiki/index.md`, and the staged distillation plan to exist and be linked from
the workspace logs or plan records.

Follow `round-closure-workflow.md` before advancing from a wiki-facing round.
`close-pass` is the normal closure. `close-with-review` is allowed only when
the next plan accepts the carried-forward review state. `do-not-close` blocks
advancement until the blocker is fixed or the scope is changed and logged.

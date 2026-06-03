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
5. Run analysis before generation.
6. Write or update wiki pages.
7. Update `wiki/index.md` and `wiki/log.md`.
8. Run lint and compare checks available for the workspace.
9. Record review items.
10. Commit the accepted result.

## Round Plan

The plan should state:

- target and reason
- fixed input set
- relationship to the overview and staged distillation plan
- expected pages, reports, and records
- validation commands or manual checks
- commit intent

Changing the input set mid-round should be recorded in the plan or log.

## Staged Distillation Plan

The staged plan should break the source set into reviewable work packages.

Each stage should state:

- source packets or source groups in scope
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
- Do not mix raw conversion, wiki distillation, compare gates, and downstream
  code generation into the same round.
- Do not use a clean-looking generated page as evidence that source coverage is
  sufficient.

## Round Log

Each round should leave a short log entry with:

- date
- target
- source packets or pages touched
- overview or staged-plan changes
- reports produced
- review items created or resolved
- validation run
- commit hash when available

## Report Expectations

Each round should leave at least one report or explicit validation note:

- source inventory or packet status for raw-facing work
- lint or index status for wiki-facing work
- compare status before advancing to the next round
- review queue status when judgment is unresolved

## Completion Criteria

A round is complete when all intended files are updated, validation is recorded,
review items are visible, and the accepted diff is committed.

For the initialization pass, completion also requires `wiki/overview.md`,
`wiki/index.md`, and the staged distillation plan to exist and be linked from
the workspace logs or plan records.

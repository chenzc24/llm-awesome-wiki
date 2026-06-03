# Distillation Rounds

Knowledge construction should happen in small rounds. A round has a fixed input
set, planned outputs, validation, and a log entry.

## Round Steps

1. Plan the round.
2. Confirm workspace Git status.
3. Select source packets or wiki areas to process.
4. Run analysis before generation.
5. Write or update wiki pages.
6. Update `wiki/index.md` and `wiki/log.md`.
7. Run lint and compare checks available for the workspace.
8. Record review items.
9. Commit the accepted result.

## Round Plan

The plan should state:

- target and reason
- fixed input set
- expected pages, reports, and records
- validation commands or manual checks
- commit intent

Changing the input set mid-round should be recorded in the plan or log.

## Round Boundaries

- Do not process the whole knowledge base in one pass unless the workspace is
  tiny and the plan says so.
- Do not mix raw conversion, wiki distillation, compare gates, and downstream
  code generation into the same round.
- Do not use a clean-looking generated page as evidence that source coverage is
  sufficient.

## Round Log

Each round should leave a short log entry with:

- date
- target
- source packets or pages touched
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

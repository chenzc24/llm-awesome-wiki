# Distillation Rounds

Knowledge construction should happen in bounded rounds. A round has a fixed
input set, planned outputs, validation, review state, and a log entry.

This rule owns round sequencing and scope control. Source packet details belong
to `rules/workflow/raw-to-source-packet.md`; wiki surface details belong to
`rules/wiki/wiki-surface-workflow.md`; closure decisions belong to
`rules/workflow/round-closure-workflow.md`.

## Minimum Path

```text
overview-first initialization when needed
-> round plan
-> fixed input set
-> source packet or wiki work
-> reports and validation
-> closure decision
-> log and commit
```

## Overview-First Initialization

Run this pass before detailed wiki distillation when a workspace is new or a
large new source set enters the workspace.

Inputs:

- `purpose.md`
- `schema.md`
- source inventory or source list
- raw sources or source packets selected for the initial scope

Outputs:

- broad source readthrough notes or inventory observations
- `wiki/overview.md` with the current global picture
- skeleton `wiki/index.md`
- initial wiki directory/page-type structure
- staged distillation plan under `plan/`
- initial gaps, risks, and review questions

The overview pass is a map of the territory, not final synthesis.

## Round Steps

1. Confirm overview-first initialization exists when required.
2. Plan the round from the staged distillation plan.
3. Confirm workspace Git status.
4. Select a fixed source packet set or wiki area.
5. Read `purpose.md`, `schema.md`, `wiki/overview.md`, `wiki/index.md`, and
   relevant existing pages.
6. Apply source-packet, evidence/claim, wiki, compare, and closure rules only
   for the active stage.
7. Record reports, validation, review items, overview/index/log state, and
   closure decision.
8. Commit only an accepted `close-pass` or allowed `close-with-review` result.

## Round Plan

The plan should state:

- target and reason
- fixed input set
- relationship to overview and staged plan
- expected pages, reports, and records
- expected routing and construction analysis when wiki pages change
- expected evidence/claim map updates when important claims are in scope
- expected index, overview, and wiki log decisions
- validation commands or manual checks
- expected closure decision surface
- commit intent

Changing the input set mid-round should be recorded in the plan or log.

## Staged Distillation Plan

Break the source set into reviewable work packages. Each stage should state:

- source packets, decks, chapters, or source groups in scope
- expected wiki sections or page types
- expected compare/lint checks
- likely review questions
- dependency on earlier stages
- stop condition for advancing

The staged plan may evolve, but changes should be logged.

## Boundaries

- Do not process the whole knowledge base in one pass unless the workspace is
  tiny and the plan says so.
- Do not begin detailed page generation for a new source set until overview,
  skeleton index, and staged plan exist.
- Do not write final wiki prose before page routing and construction analysis.
- Do not mix raw conversion, wiki distillation, compare gates, and downstream
  code generation into the same round.
- Do not use a clean-looking generated page as evidence that source coverage is
  sufficient.

## Wiki Construction Round

A wiki construction round is a specific distillation round. It requires:

- fixed source packet set
- claim/evidence maps when important claims are in scope
- review queue or review reports when unresolved judgment exists
- current `wiki/overview.md`
- current `wiki/index.md`
- existing source and chapter pages in the target area

It should output:

- wiki construction analysis
- source or chapter page creates, updates, merges, deferrals, or no-change
  decisions
- overview refresh or no-change reason
- `wiki/index.md` update when accepted pages change
- `wiki/log.md` entry
- validation note
- review queue updates when judgment remains unresolved

If compare or wiki lint is not enabled, record that explicitly. Missing gates
are not passes.

## Round Log And Reports

Each round should leave a short log entry with target, source scope, page
decisions, reports, compare status, review state, validation run, closure
decision, and commit hash when available.

Each round should leave at least one report or explicit validation note:

- source inventory or packet status for raw-facing work
- construction analysis status for wiki-facing work
- overview, index, and log status for wiki-facing work
- claim/evidence map status when important claims are created or updated
- lint, compare, review queue, closure, and next-action status when relevant

## Completion Criteria

A round is complete when intended files are updated, validation is recorded,
review items are visible, closure decision is recorded, and the accepted diff
is committed.

Wiki construction rounds also require construction analysis,
overview/index/log status, and validation notes that record page decisions,
compare status, review carry-forward, and closure decision.

For rounds that create or update important claims, completion also requires
evidence references or review routing.

For initialization, completion also requires `wiki/overview.md`,
`wiki/index.md`, and the staged plan to exist and be linked from workspace logs
or plan records.

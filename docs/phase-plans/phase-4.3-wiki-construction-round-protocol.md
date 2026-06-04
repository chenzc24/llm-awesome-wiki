# Phase 4.3 Wiki Construction Round Protocol

Phase 4.3 defines the repeatable round protocol for wiki construction.

Phase 4.1 answered where content should go. Phase 4.2 hardened the source page,
chapter page, and construction analysis templates. Phase 4.3 connects those
pieces into a round rhythm that agents can follow in a workspace.

## Scope

Phase 4.3 owns:

- wiki construction round steps
- fixed input set rules
- construction analysis before generation
- create, update, merge, leave-unchanged, and report-only decisions
- index and log update rhythm
- validation note expectations
- review carry-forward behavior

Phase 4.3 does not implement:

- wiki generators
- wiki-lint tools
- compare gates
- schema or validator changes
- tests or fixtures
- Obsidian workflows
- downstream `skill + tool` artifacts

## Round Shape

Every wiki construction round should follow this shape:

```text
plan fixed input set
-> confirm git status
-> read purpose, schema, overview, index
-> select source packets and claim/evidence context
-> apply page routing
-> write construction analysis
-> create, update, merge, or defer wiki pages
-> update index and wiki log
-> update reports and review queue
-> record validation note
-> commit accepted diff
```

Do not turn a source packet directly into final wiki prose.

## Fixed Input Set

The round plan should define the fixed input set before page edits begin.

Minimum input fields:

- source packets in scope
- source references or anchor ranges in scope
- claim/evidence maps in scope
- review queues in scope
- existing overview/index/source/chapter pages to inspect
- sources intentionally out of scope

If the input set changes mid-round, update the plan or log before continuing.

## Construction Analysis Gate

The construction analysis is required before generation.

It should record:

- inputs read
- routing decisions
- target pages
- create/update/merge/leave-unchanged/report-only decisions
- duplicate checks
- review handoff
- whether generation may proceed

The recommended workspace template is:

```text
templates/workspace-kernel/reports/wiki-construction-analysis.template.md
```

In a generated workspace, copy it to a round-specific report path such as:

```text
reports/wiki-construction-analysis.md
```

or another configured report path.

## Page Update Decisions

Use these decision meanings:

| Decision | Meaning |
| --- | --- |
| `create` | A new page is needed because no existing page has the same scope. |
| `update` | An existing page has the right scope and should be edited. |
| `merge` | Two or more existing pages overlap and should be consolidated. |
| `leave-unchanged` | The page was inspected but does not need edits this round. |
| `report-only` | The content belongs in a report or review queue, not wiki prose. |
| `needs-review` | Human judgment is required before page generation or acceptance. |

Agents should prefer `update` over duplicate `create` when the scope matches.

## Page Generation Rules

After construction analysis allows generation:

- source pages should remain short source notes
- chapter pages should carry the main distilled knowledge
- important claims should cite source packet anchors, evidence IDs, or review
  items
- unresolved judgment should remain visible
- generated-evidence uncertainty should not be smoothed into source-derived
  prose
- optional synthesis or research pages require a recorded reason

## Index And Log Rules

Every accepted wiki page creation, deletion, merge, or major retitle requires:

- `wiki/index.md` update
- `wiki/log.md` entry
- round validation note update

Minor prose edits may still update `wiki/log.md` when they change accepted
knowledge, source references, claim state, or review status.

## Validation Note

A round validation note should state:

- construction analysis path
- pages created, updated, merged, deferred, or left unchanged
- index/log update status
- source references checked
- claim/evidence status
- review items created, resolved, or carried forward
- compare status

If no real compare gate ran, record:

```text
compare gate not enabled
```

Do not convert that into `pass`.

## Review Carry-Forward

Unresolved review must survive the round.

Carry forward:

- generated-evidence claims without accepted review
- unsupported or contested claims
- page scope questions
- missing modalities that affect wiki claims
- duplicate or merge decisions that need human judgment

Carried-forward review items should appear in the construction analysis,
validation note, and review queue when available.

## Acceptance Criteria

Phase 4.3 is complete when:

- round protocol is documented
- `distillation-rounds.md` describes wiki construction rounds
- `source-packet-to-wiki.md` references the round protocol
- first-round plan and validation note templates require construction analysis
- workspace README/AGENTS/wiki log guidance reflects the round rhythm
- Phase 4.1 routing and Phase 4.2 template boundaries remain intact

# Phase 5 Closure Review

Phase 5 is complete from the Person B workflow-surface side when compare gates,
review workflow, and round closure are understandable, auditable, bounded, and
ready for tool and validator implementation.

Phase 5 does not implement compare algorithms, schemas, validators, fixtures,
link checking code, wiki generation, or downstream `skill + tool` artifacts.

## Completed Workflow Surface

Phase 5 defines this path:

```text
wiki construction outputs
-> compare report
-> source/wiki coverage checks
-> claim, modality, unsupported statement, and contradiction checks
-> review queue lifecycle
-> round closure decision
-> Person A or Phase 6 validation/tooling handoff
```

Completed Person B outputs:

- main Phase 5 plan in
  `docs/phase-plans/phase-5-compare-gates-review-workflow.md`
- Phase 5.1 compare report foundation
- Phase 5.2 source/wiki coverage and omission protocol
- Phase 5.3 claim, modality, unsupported statement, and contradiction review
  protocol
- Phase 5.4 review queue lifecycle and carried-forward workflow
- Phase 5.5 round closure integration
- compare gate contract updates
- source/wiki coverage rule
- claim/modality/contradiction review rule
- review queue workflow rule
- round closure workflow rule
- workspace compare report, review queue, validation note, reports README,
  index, overview, and wiki log template updates
- Person A and Phase 6 handoff proposals for schemas, validators, fixtures,
  and tools

## Design Review

| Design principle | Phase 5 result |
| --- | --- |
| VSCode/Git-first | Compare, review, validation, index, overview, and log surfaces are plain repo-local Markdown files. |
| Agent-first | Rules define what an agent must inspect, record, route to review, carry forward, and refuse to pass. |
| Portable | No Obsidian, desktop app, hosted API, MCP, GPU, MinerU run, or specific extractor is required. |
| Incremental | Compare gates operate per distillation round, not as one large final audit of the whole corpus. |
| Avoid model self-evaluation | `pass`, `needs-review`, `fail`, `close-pass`, `close-with-review`, and `do-not-close` require recorded evidence rather than model confidence. |
| Raw-wiki alignment | Source packets, anchors, wiki pages, claims, review items, and compare findings remain traceable. |
| Artifact economy | One compare report is the default decision surface; detailed coverage, claim audit, or review reports are optional when needed. |
| Source/chapter default | Compare findings do not force fragmented concept/entity pages; document and PPT corpora can stay chapter-oriented. |
| Generated-content visibility | Generated OCR cleanup, chart summaries, image captions, table repairs, formula recognition, and modality interpretations are marked or routed to review. |
| Knowledge-construction executable layer | Compare gates, review queues, closure decisions, and future validators belong to knowledge construction, not downstream `skill + tool` generation. |
| Person A/B boundary | Workflow and template needs are recorded here; `contracts/schemas/**`, validators, tools, and fixtures remain Person A or Phase 6 implementation work. |

## Review Findings

1. Phase 5 should keep one default compare report per round.

   Reason: report sprawl would make the workflow harder for agents and humans
   to follow. The compare report can link to deeper coverage, lint, claim
   audit, or review reports when a workspace actually needs them.

2. Coverage means source disposition, not copying.

   Reason: for large PPT/PDF corpora, the compare gate should explain whether
   source material was covered, weak, omitted, deferred, out-of-scope, routed
   to review, or blocked. It should not force every slide or paragraph into
   wiki prose.

3. Important claims must be checked at the wording level.

   Reason: clean prose is not proof. Important wiki claims need source anchors,
   claim/evidence support, accepted review decisions, or explicit review
   routing.

4. Generated or tool-assisted evidence must remain visible.

   Reason: OCR cleanup, chart summaries, captions, table repairs, formula
   recognition, and visual interpretations can be useful, but they are not
   automatically source-derived truth.

5. Review queue state must survive across rounds.

   Reason: unresolved judgment should not disappear after one compare report.
   Phase 5 defines `open`, `in-review`, `resolved`, `dismissed`,
   `carried-forward`, `blocked`, and `stale` lifecycle states with blocking
   levels.

6. Round closure is an integration decision.

   Reason: a compare `pass` alone is not enough if validation notes, index,
   overview, wiki log, or review state are stale. Closure decisions use
   `close-pass`, `close-with-review`, or `do-not-close`.

7. Phase 5 is not deterministically enforced yet.

   Reason: the workflow surface is coherent, but schemas, validators, fixtures,
   link checks, compare checks, and report checks still need implementation.

## Person A Handoff

Recommended Person A or Phase 6 implementation areas:

- compare report schema
- review queue schema hardening
- validation note schema or parser
- closure decision field validation
- compare status enum validation: `pass`, `fail`, `needs-review`
- closure decision enum validation: `close-pass`, `close-with-review`,
  `do-not-close`
- coverage disposition validation: `covered`, `weak`, `deferred`, `omitted`,
  `out-of-scope`, `review`, `blocked`
- claim support status validation: `supported`, `weak`, `unsupported`,
  `contested`, `generated-derived`, `reviewed-generated`, `needs-review`,
  `not-in-scope`
- modality state validation
- contradiction type validation
- review item lifecycle and blocking level validation
- required carried-forward review fields
- rule that `close-pass` requires compare `pass`
- rule that `close-with-review` requires compare `needs-review` plus valid
  carried-forward review
- rule that `do-not-close` blocks advancement
- rule that blocking review prevents `pass` and `close-pass`
- link and index validation for accepted pages and active reports
- validation-note closure packet validation

Person B should not edit `contracts/schemas/**`, validator code, tests, tools,
or fixtures as part of this closure unless a later task explicitly assigns that
work.

## Suggested Fixtures

Useful Phase 6 fixture scenarios:

- valid close-pass round
- close-with-review round with nonblocking carried-forward review
- do-not-close round caused by compare `fail`
- do-not-close round caused by missing validation note
- do-not-close round caused by stale index link
- round with missing source/wiki coverage
- 30-slide PPT with grouped slide coverage
- omitted decorative content
- omitted important chart without reason
- unsupported wiki claim
- generated chart summary routed to review
- reviewed-generated chart claim
- source-vs-source contradiction
- wiki claim narrowed after weak evidence
- stale review after source packet change
- dismissed duplicate review item
- compare gate not enabled recorded without being converted to `pass`

## Suggested Tools

Useful Phase 6 tool surfaces:

- compare report validator
- review queue validator
- validation note validator
- source/wiki coverage table checker
- claim/evidence support checker
- generated evidence visibility checker
- index and active report link checker
- round closure checker
- fixture runner for scenario-driven validation

These tools belong to the knowledge-construction executable layer. They support
raw-to-wiki distillation quality. They are not the later downstream path from
distilled knowledge to executable `skill + tool` capability libraries.

## Remaining Non-Goals

Phase 5 closure does not start:

- schema implementation
- validator implementation
- fixture creation
- compare CLI implementation
- review export CLI implementation
- link checker implementation
- wiki generation
- raw source conversion
- source packet generation
- downstream executable `skill + tool` work

## Next Phase Boundary

The next Person B/Person A implementation phase should be Phase 6: validation
and tooling for the workspace kernel.

Phase 6 should consume Phase 2 through Phase 5 workflow surfaces and implement
the minimal deterministic or semi-deterministic checks needed to make the
kernel usable in real workspaces:

- schema checks
- lint checks
- report checks
- compare report validation
- review queue validation
- round closure validation
- scenario fixtures

Phase 6 should not start the separate downstream knowledge-to-`skill + tool`
mainline. That remains a later major stage after the knowledge construction
workflow and its executable maintenance layer are reliable.

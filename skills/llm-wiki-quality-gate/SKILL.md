---
name: llm-wiki-quality-gate
description: Quality gate runtime skill for LLM Awesome Wiki. Use when an agent needs to run or record compare reports, source/wiki coverage, claim/modality/contradiction review, review queues, validation notes, workspace checks, or round closure decisions.
---

# LLM Wiki Quality Gate

## Role

Use this subskill for compare, review, validation, and closure. It is part of
knowledge-base construction, not downstream `skill + tool` generation.

This skill owns the normal quality-gate runtime. It does not rewrite wiki pages
or use model self-evaluation as a pass.

Detailed rules are loaded only when needed:

- `rules/wiki/source-wiki-coverage-protocol.md` for source/wiki coverage,
  omission, disposition, and anchor tables
- `rules/claims/claim-modality-contradiction-review-protocol.md` for claim
  support, generated evidence, modality, unsupported statements, and
  contradictions
- `rules/review/review-queue-workflow.md` for review lifecycle and blocking
  level

## Inputs

- round plan and fixed scope
- source inventory and source packets in scope
- wiki construction analysis when wiki pages changed
- changed or inspected wiki pages
- `wiki/overview.md`, `wiki/index.md`, and `wiki/log.md`
- claim/evidence records when important claims are in scope
- current review queue
- validation notes and tool output

Missing expected inputs must be recorded. Missing input is not an implicit
pass.

## Runtime

1. Run available validators for the touched artifact family.
2. Write or inspect a compare report. It should answer:
   - what was in scope
   - which source packets and anchors were checked
   - which wiki pages changed or were inspected
   - whether important claims have source, evidence, accepted review, or review
     routing
   - which generated, skipped, or uncertain modalities matter
   - whether links, index, overview, and log are current
   - which omissions, contradictions, unsupported statements, or review items
     block advancement
3. Use only compare status values:
   - `pass`
   - `fail`
   - `needs-review`
4. Do not treat `compare gate not enabled`, model confidence, or "looks
   complete" as `pass`.
5. Write or inspect the validation note.
6. Decide closure:
   - `close-pass`: compare is `pass`, validation exists, no blocking review
     remains, generated evidence is marked or reviewed, navigation/log state is
     acceptable
   - `close-with-review`: compare is `needs-review`, artifacts are structurally
     reviewable, and carried-forward review has reason, next action, target
     round or condition, and blocking level
   - `do-not-close`: compare is `fail`, required artifacts are missing,
     blocking review remains, or index/overview/log/claim/source coverage is
     materially stale
7. Update workspace logs and commit only accepted `close-pass` or explicitly
   allowed `close-with-review` state.

## Outputs

- compare report or explicit validation note that compare is not enabled
- source/wiki coverage, claim support, modality, unsupported statement,
  contradiction, and review findings at the level needed for the round
- review queue updates for unresolved judgment
- validation note
- closure decision
- next action or next round

## Validation

Prefer the narrowest relevant check first, then broader checks:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode reports
python -m llm_wiki_tools workspace-check --workspace . --mode closure
python -m llm_wiki_tools workspace-check --workspace . --mode all
```

If checks are unavailable, record the missing checker state. Do not convert
missing validation, model confidence, or "looks complete" into `pass`.

Minimum manual checks:

- report status is `pass`, `fail`, or `needs-review`
- accepted wiki changes remain discoverable from index/log/overview state
- important claims have source anchors, evidence, accepted review, or review
  routing
- generated evidence is visible and not treated as source-derived truth by
  default
- unresolved review is carried forward with reason and next action
- `close-pass` is never used with missing compare, blocking review, or stale
  navigation

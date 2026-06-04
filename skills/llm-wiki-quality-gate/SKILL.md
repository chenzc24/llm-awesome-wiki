---
name: llm-wiki-quality-gate
description: Quality gate routing skill for LLM Awesome Wiki. Use when an agent needs to run or record compare reports, source/wiki coverage, claim/modality/contradiction review, review queues, validation notes, workspace checks, or round closure decisions.
---

# LLM Wiki Quality Gate

## Role

Use this subskill for compare, review, validation, and closure. It is part of
knowledge-base construction, not downstream `skill + tool` generation.

This skill routes the work. The semantic source of truth is in `rules/`:

- start with `rules/workflow/compare-gate-contract.md`
- use `rules/wiki/source-wiki-coverage-protocol.md` for source/wiki coverage
- use `rules/claims/claim-modality-contradiction-review-protocol.md` for claim
  support, generated evidence, modality, unsupported statements, and
  contradictions
- use `rules/review/review-queue-workflow.md` for review lifecycle and blocking level
- use `rules/workflow/round-closure-workflow.md` for closure and advancement decisions

## Sequence

1. Confirm the round plan, touched source packets, wiki construction analysis,
   changed wiki pages, overview, index, and log are visible.
2. Run available validators for the touched artifact family.
3. Write or inspect the compare report.
4. Record source/wiki coverage, claim support, modality state, unsupported
   statements, contradictions, review items, and carried-forward review only at
   the level needed for the round.
5. Write or inspect the validation note.
6. Decide `close-pass`, `close-with-review`, or `do-not-close`.
7. Update workspace logs and commit only accepted `close-pass` or allowed
   `close-with-review` state.

## Validation

Prefer the narrowest relevant check first, then broader checks:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode reports
python -m llm_wiki_tools workspace-check --workspace . --mode closure
python -m llm_wiki_tools workspace-check --workspace . --mode all
```

If checks are unavailable, record the missing checker state. Do not convert
missing validation, model confidence, or "looks complete" into `pass`.

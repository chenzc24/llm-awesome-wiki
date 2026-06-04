# Phase 5.1 Compare Report Foundation Plan

## Goal

Start Phase 5 from the Person B workflow-surface side by defining the compare
gate report foundation: the main Phase 5 plan, Phase 5.1 scope, compare report
template, status semantics, and validation-note integration.

Phase 5.1 does not implement compare tooling, schemas, validators, fixtures,
wiki generation, or downstream `skill + tool` artifacts.

## Dirty-State Note

Start state was clean:

```text
## main...origin/main
```

Reference submodules were unchanged:

```text
ef4aa39c1dcc0102082374e977e2d722b9d392c0 MinerU (heads/master)
a5ee5ec3c7cc180f0f5abfb9d266fe87573171bd llm_wiki (v0.4.18)
```

## Owned Files

- `docs/phase-plans/phase-5-compare-gates-review-workflow.md`
- `docs/phase-plans/phase-5.1-compare-report-foundation.md`
- `docs/phase-plans/README.md`
- `rules/compare-gate-contract.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/reports/review-queue.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `rules/source-packet-to-wiki.md`
- `rules/distillation-rounds.md`
- `templates/workspace-kernel/wiki/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 4 closure confirms wiki construction is ready for compare-gate design.
- Core philosophy requires raw-wiki alignment and avoids model-only
  self-evaluation.
- Person A owns machine-readable report schemas, validators, fixtures, and
  deterministic tool behavior.

## Implementation Steps

1. Add the main Phase 5 phase plan.
2. Add the Phase 5.1 compare report foundation plan.
3. Expand `rules/compare-gate-contract.md` with report sections, status
   semantics, anti-self-evaluation constraints, and deterministic/manual/human
   review categories.
4. Add `templates/workspace-kernel/reports/compare-report.template.md`.
5. Update report README, review queue template, and validation note template so
   they point to compare reports without creating report sprawl.
6. Update phase-plan index and logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5`
  - `Compare Gate`
  - `Compare Report`
  - `raw-wiki alignment`
  - `source coverage`
  - `claim coverage`
  - `modality coverage`
  - `pass`
  - `fail`
  - `needs-review`
  - `model self-evaluation`
  - `carried forward`
  - `not a wiki rewrite`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Define phase five compare report foundation
```

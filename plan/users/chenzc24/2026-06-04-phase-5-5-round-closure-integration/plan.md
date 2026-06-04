# Phase 5.5 Round Closure Integration Plan

## Goal

Continue Phase 5 from the Person B workflow-surface side by defining round
closure integration: how compare status, review status, validation notes,
`wiki/index.md`, `wiki/overview.md`, and `wiki/log.md` together decide whether
a distillation round can close, advance with review, or fail.

Phase 5.5 does not implement compare tools, validators, schemas, fixtures,
wiki generation, link checking code, or downstream `skill + tool` artifacts.

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
- `docs/phase-plans/phase-5.5-round-closure-integration.md`
- `docs/phase-plans/README.md`
- `rules/round-closure-workflow.md`
- `rules/compare-gate-contract.md`
- `rules/distillation-rounds.md`
- `rules/wiki-overview-log-contract.md`
- `rules/README.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/wiki/index.md`
- `templates/workspace-kernel/wiki/overview.md`
- `templates/workspace-kernel/wiki/log.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `rules/source-wiki-coverage-protocol.md`
- `rules/claim-modality-contradiction-review-protocol.md`
- `rules/review-queue-workflow.md`
- `templates/workspace-kernel/raw/**`
- `templates/workspace-kernel/wiki/chapters/**`
- `templates/workspace-kernel/wiki/sources/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.1 defines compare report status semantics.
- Phase 5.2 defines source/wiki coverage and omission semantics.
- Phase 5.3 defines claim, modality, unsupported statement, and contradiction
  findings.
- Phase 5.4 defines review queue lifecycle and carried-forward semantics.
- Phase 5.6 will close Phase 5 and hand validation/tooling needs to Person A
  or Phase 6. Phase 5.5 should not perform that closure review yet.

## Implementation Steps

1. Add the Phase 5.5 phase-plan document.
2. Update the main Phase 5 plan to mark Phase 5.4 complete and Phase 5.5
   active.
3. Add `rules/round-closure-workflow.md` and index it from `rules/README.md`.
4. Refine `rules/compare-gate-contract.md`, `rules/distillation-rounds.md`,
   and `rules/wiki-overview-log-contract.md` with closure decision semantics.
5. Refine compare report, validation note, reports README, and wiki index,
   overview, and log templates so round closure has explicit fields.
6. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5.5`
  - `Round Closure`
  - `round can close`
  - `close with review`
  - `must not close`
  - `advance with review`
  - `closure packet`
  - `validation note`
  - `index`
  - `overview`
  - `wiki log`
  - `not a validator implementation`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Define phase five round closure workflow
```

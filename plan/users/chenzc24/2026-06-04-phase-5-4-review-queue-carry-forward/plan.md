# Phase 5.4 Review Queue Carry Forward Plan

## Goal

Continue Phase 5 from the Person B workflow-surface side by defining review
queue lifecycle semantics: how review items open, triage, resolve, dismiss,
remain blocking, become nonblocking carried-forward work, and re-enter later
compare rounds.

Phase 5.4 does not implement review export tools, compare algorithms, schemas,
validators, fixtures, wiki generation, link checking, or downstream `skill +
tool` artifacts.

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
- `docs/phase-plans/phase-5.4-review-queue-carry-forward-workflow.md`
- `docs/phase-plans/README.md`
- `rules/review-queue-workflow.md`
- `rules/compare-gate-contract.md`
- `rules/README.md`
- `templates/workspace-kernel/reports/review-queue.template.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/reports/README.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `rules/claim-review-routing.md`
- `rules/claim-modality-contradiction-review-protocol.md`
- `rules/source-wiki-coverage-protocol.md`
- `templates/workspace-kernel/wiki/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.1 defines compare report status semantics.
- Phase 5.2 defines source/wiki coverage and omission findings.
- Phase 5.3 defines claim, modality, unsupported statement, and contradiction
  findings that can create review items.
- Phase 5.5 will integrate compare/review results with round closure,
  validation notes, index, overview, and log expectations. Phase 5.4 should not
  close that whole loop yet.

## Implementation Steps

1. Add the Phase 5.4 phase-plan document.
2. Update the main Phase 5 plan to mark Phase 5.3 complete and Phase 5.4
   active.
3. Add `rules/review-queue-workflow.md` and index it from `rules/README.md`.
4. Refine `rules/compare-gate-contract.md` with review lifecycle, status,
   blocking level, resolution, dismissal, and carried-forward semantics.
5. Refine review queue, compare report, validation note, and reports README
   templates so they can carry review lifecycle information.
6. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5.4`
  - `Review Queue`
  - `carried-forward`
  - `blocking`
  - `nonblocking`
  - `resolved`
  - `dismissed`
  - `stale`
  - `re-enter`
  - `review lifecycle`
  - `not a review export tool`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Define phase five review queue workflow
```

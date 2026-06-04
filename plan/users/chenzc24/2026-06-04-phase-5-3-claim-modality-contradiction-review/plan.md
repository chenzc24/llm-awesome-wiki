# Phase 5.3 Claim Modality Contradiction Review Plan

## Goal

Continue Phase 5 from the Person B workflow-surface side by defining how a
compare report records important claim support, generated evidence, modality
coverage, unsupported statements, contradictions, and semantic review routing.

Phase 5.3 does not implement claim-audit tooling, modality extraction tools,
compare algorithms, schemas, validators, fixtures, wiki generation, or
downstream `skill + tool` artifacts.

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
- `docs/phase-plans/phase-5.3-claim-modality-contradiction-review-protocol.md`
- `docs/phase-plans/README.md`
- `rules/claim-modality-contradiction-review-protocol.md`
- `rules/compare-gate-contract.md`
- `rules/README.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/claim-evidence-map.template.md`
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
- `rules/evidence-to-claim.md`
- `rules/claim-review-routing.md`
- `rules/source-wiki-coverage-protocol.md`
- `templates/workspace-kernel/wiki/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.1 defines the compare report as the default round decision surface.
- Phase 5.2 defines source/wiki coverage and anchor disposition.
- Phase 5.3 should build on Phase 3 claim/review rules without changing their
  source-of-truth role.
- Phase 5.4 will handle review queue workflow and carried-forward semantics in
  more depth, so this phase should only add the review fields needed for claim,
  modality, and contradiction findings.

## Implementation Steps

1. Add the Phase 5.3 phase-plan document.
2. Update the main Phase 5 plan to mark Phase 5.2 complete and Phase 5.3
   active.
3. Add `rules/claim-modality-contradiction-review-protocol.md` and index it
   from `rules/README.md`.
4. Refine `rules/compare-gate-contract.md` with claim support, generated
   evidence, modality, unsupported statement, and contradiction semantics.
5. Refine compare report, claim/evidence map, review queue, and validation note
   templates so they can carry Phase 5.3 findings.
6. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5.3`
  - `Claim Modality Contradiction`
  - `claim support`
  - `generated evidence`
  - `modality coverage`
  - `unsupported statement`
  - `contradiction`
  - `source-derived`
  - `reviewed-generated`
  - `semantic review`
  - `not a claim audit tool`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Define phase five claim modality review protocol
```

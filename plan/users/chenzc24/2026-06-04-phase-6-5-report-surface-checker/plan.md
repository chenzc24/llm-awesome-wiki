# Phase 6.5 Report Surface Checker Plan

## Goal

Implement Phase 6.5 as checker-only validation for existing compare, review,
claim/evidence, and validation-note reports.

This target validates report surfaces under `reports/`:

- compare reports
- claim/evidence maps
- review queues
- validation notes

It does not extract claims, decide semantic truth, rewrite reports, generate
wiki pages, or close rounds.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules are not part of this target.

## Owned Files

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.5-report-surface-checker.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/report-check/README.md`
- `tools/report-check/report-check.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-phase-6-5-report-surface-checker/plan.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- existing source/wiki checker scripts
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 6 shared report conventions and exit codes
- Phase 5 compare/review/report templates
- Compare report, claim record, and review item status vocabulary
- `workspace-check -Mode reports`

## Implementation Steps

1. Add Phase 6.5 phase-plan documentation.
2. Add `tools/report-check/report-check.ps1`:
   - discover report Markdown files under `reports/`
   - classify compare reports, claim/evidence maps, review queues, and
     validation notes
   - validate required sections and status values
   - validate pass/close-pass cannot be used when compare gate is not enabled
   - validate supported claims have evidence IDs
   - validate review queue lifecycle and blocking-level vocabulary
   - emit pass/fail/needs-review reports
3. Add `tools/report-check/README.md`.
4. Integrate `report-check.ps1` into `workspace-check -Mode reports` and
   `workspace-check -Mode all`.
5. Update Phase 6 docs, tool README, and `validate-kernel.ps1`.
6. Update maintenance logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- Create a temporary smoke workspace under the OS temp directory with:
  - one compare report
  - one claim/evidence map
  - one review queue
  - one validation note
- Run `report-check.ps1` and `workspace-check.ps1 -Mode reports` against that
  temp workspace.
- Remove or ignore generated smoke reports outside the repository.
- Targeted `rg` for Phase 6.5, report-check, compare report, review queue,
  claim/evidence, validation note, no-claim-extraction, and no-semantic-truth
  language.
- `git status --short --branch`

## Commit Intent

- Commit main implementation as `Add phase six report surface checker`.
- Then update log entries with the implementation commit hash and commit that
  maintenance status.

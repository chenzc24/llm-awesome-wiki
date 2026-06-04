# Phase 6.6 Round Closure Checker Plan

## Goal

Implement Phase 6.6 as checker-only validation for round closure consistency.

This target validates whether closure decisions recorded in validation notes are
consistent with compare status, review state, index/overview/log status, and
discoverability expectations.

It does not close rounds, change wiki pages, resolve review items, decide
semantic truth, or generate reports.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules are not part of this target.

## Owned Files

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.6-round-closure-checker.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/round-closure-check/README.md`
- `tools/round-closure-check/round-closure-check.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-phase-6-6-round-closure-checker/plan.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- existing checker scripts
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.5 round closure integration
- `rules/round-closure-workflow.md`
- validation note template
- Phase 6 report checker output assumptions
- `workspace-check -Mode closure`

## Implementation Steps

1. Add Phase 6.6 phase-plan documentation.
2. Add `tools/round-closure-check/round-closure-check.ps1`:
   - discover validation notes under `reports/validation/`
   - extract status, compare status, closure decision, support fields, and
     referenced compare/review paths
   - verify `close-pass` requires compare `pass`, support fields `yes`, and
     no blocking/carry-forward blockers
   - verify `close-with-review` requires compare `needs-review` and explicit
     carry-forward reason/next action
   - verify `do-not-close` does not claim normal advancement
   - verify referenced report paths exist when recorded
   - verify wiki log records closure decision
   - verify active compare/review reports are discoverable from index when
     closing with review
3. Add `tools/round-closure-check/README.md`.
4. Integrate into `workspace-check -Mode closure` and `-Mode all`.
5. Update Phase 6 docs, tools README, and `validate-kernel.ps1`.
6. Update maintenance logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- Create a temporary smoke workspace under the OS temp directory with:
  - one validation note with `close-pass`
  - matching compare report
  - review queue
  - wiki index, overview, and log entries
- Run `round-closure-check.ps1` and `workspace-check.ps1 -Mode closure`
  against that temp workspace.
- Remove or ignore generated smoke reports outside the repository.
- Targeted `rg` for Phase 6.6, round-closure-check, close-pass,
  close-with-review, do-not-close, validation note, no-round-closing, and
  no-semantic-truth language.
- `git status --short --branch`

## Commit Intent

- Commit main implementation as `Add phase six round closure checker`.
- Then update log entries with the implementation commit hash and commit that
  maintenance status.

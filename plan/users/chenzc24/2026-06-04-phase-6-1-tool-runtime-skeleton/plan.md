# Phase 6.1 Tool Runtime Skeleton Plan

## Goal

Start Phase 6.1 by adding a checker-first tool runtime skeleton and shared
report conventions. The target is a minimal runnable CLI entrypoint that can
orchestrate future workspace validators without implementing the individual
business checks yet.

Phase 6.1 should not parse raw binary files, run extractors, implement schema
validation, create fixtures, or perform semantic compare/review checks.

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

- `docs/phase-plans/phase-6.1-tool-runtime-skeleton.md`
- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/shared/README.md`
- `tools/shared/report-conventions.md`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Add Phase 6.1 phase-plan documentation.
2. Update the Phase 6.0 rebaseline plan and phase-plan index to mark Phase 6.1
   as active.
3. Add shared report and exit-code conventions for Phase 6 checker tools.
4. Add a minimal `workspace-check.ps1` CLI skeleton that:
   - accepts `-Workspace`
   - accepts `-Mode`
   - accepts `-Report`
   - validates workspace path existence
   - emits a stable Markdown report
   - returns the shared exit code for pass or configuration/runtime error
   - clearly marks business validators as not implemented yet
5. Update `tools/README.md` and `tools/workspace-check/README.md`.
6. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- `powershell -ExecutionPolicy Bypass -File tools/workspace-check/workspace-check.ps1 -Workspace . -Report reports-validation-smoke.md`
- confirm the smoke report is generated and remove it before commit
- targeted `rg` for:
  - `Phase 6.1`
  - `workspace-check`
  - `report-conventions`
  - `exit code`
  - `not implemented`
  - `does not run extractors`
  - `checker`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Add phase six tool runtime skeleton
```

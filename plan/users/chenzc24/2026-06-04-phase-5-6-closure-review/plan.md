# Phase 5.6 Closure Review Plan

## Goal

Close Phase 5 from the Person B workflow-surface side by reviewing the complete
compare gates and review workflow, confirming alignment with the core design
philosophy, and handing schema, validator, fixture, and tool implementation
needs to Person A or Phase 6.

Phase 5.6 does not implement schemas, validators, fixtures, compare CLI,
review export CLI, link checking code, wiki generation, or downstream `skill +
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
- `docs/phase-plans/phase-5-closure-review.md`
- `docs/phase-plans/README.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.1 report foundation
- Phase 5.2 source/wiki coverage protocol
- Phase 5.3 claim/modality/contradiction review protocol
- Phase 5.4 review queue lifecycle workflow
- Phase 5.5 round closure integration workflow

## Implementation Steps

1. Add `docs/phase-plans/phase-5-closure-review.md`.
2. Update the main Phase 5 plan to mark Phase 5.5 complete and record Phase 5
   closure.
3. Update `docs/phase-plans/README.md`.
4. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5 Closure`
  - `Phase 5 is complete`
  - `compare gates`
  - `review workflow`
  - `close-pass`
  - `close-with-review`
  - `do-not-close`
  - `Person A handoff`
  - `Phase 6`
  - `not implement`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Close phase five compare gate workflow
```

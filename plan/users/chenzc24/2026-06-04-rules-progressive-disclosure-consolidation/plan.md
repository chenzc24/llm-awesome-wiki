# Rules Progressive Disclosure Consolidation Plan

## Goal

Refactor `rules/` from a flat collection of phase-accumulated rule files into
a progressive-disclosure rule map with clear entrypoints, semantic ownership,
and compatibility stubs for historical links.

The change should preserve rule capability while reducing duplicated status
and lifecycle definitions.

## Dirty-State Note

Start state: `git status --short --branch` reported `main...origin/main` plus
one unrelated untracked directory:

- `plan/users/chenzc24/2026-06-04-person-a-dry-run-v2-handoff/`

That path belongs to a different target and is not edited by this task. This
task proceeds because the dirty path does not overlap the owned files or shared
contract dependencies for this rules consolidation pass.

## Owned Files

- `rules/**`
- `llm_wiki_tools/cli.py`
- `templates/workspace-kernel/**` guidance files that reference rule entrypoints
- `docs/top-level-design/system-architecture-plan.md`
- `README.md` rule-entrypoint references if needed
- `plan/users/chenzc24/2026-06-04-rules-progressive-disclosure-consolidation/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**`
- `tests/**`
- `docs/phase-plans/**`
- `docs/collaboration/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Rewrite `rules/README.md` as the first entrypoint:
   - default golden path
   - when to read more
   - semantic ownership map
   - compatibility note for historical `*-contract.md` files
2. Add `rules/evidence-claim-workflow.md` and replace the three old Phase 3
   files with compatibility entries.
3. Add `rules/wiki-surface-workflow.md` and replace the three old Phase 4
   surface files with compatibility entries.
4. Trim duplicated tables from `rules/compare-gate-contract.md` while keeping
   it as the compare gate decision surface.
5. Update validator required paths and workspace template guidance so new
   users start from `rules/README.md`.
6. Update maintenance logs with the target, changed areas, validation, and
   commit status.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `rg -n "Default Golden Path|When To Read More|Semantic Ownership" rules/README.md`
- `rg -n "evidence-claim-workflow|wiki-surface-workflow" rules llm_wiki_tools templates docs`
- targeted `rg` checks that compatibility entries exist and compare duplicate
  semantic tables are reduced
- `git status --short --branch`

## Commit Intent

Commit the intended rule consolidation changes with:

```text
Consolidate rules progressive disclosure
```

Then push to `origin main` and confirm `main...origin/main` alignment.

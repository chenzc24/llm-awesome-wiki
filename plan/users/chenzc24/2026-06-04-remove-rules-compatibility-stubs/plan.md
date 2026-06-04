# Remove Rules Compatibility Stubs Plan

## Goal

Remove six `rules/` compatibility stub files after the rules progressive
disclosure consolidation, and update current-facing references so agents use
the semantic owner rules directly.

This is an information-architecture cleanup. It does not change workflow
semantics, schemas, checker behavior beyond required-path validation, or
historical plan records.

## Start State

`git status --short --branch` reported `main...origin/main` with a clean
worktree.

`git submodule status` was checked because the repo includes reference
submodules; no submodule change is intended.

## Owned Files

- `rules/README.md`
- `rules/source-packet-to-evidence.md`
- `rules/evidence-to-claim.md`
- `rules/claim-review-routing.md`
- `rules/wiki-page-routing.md`
- `rules/wiki-index-contract.md`
- `rules/wiki-overview-log-contract.md`
- `llm_wiki_tools/cli.py`
- `docs/collaboration/person-b-workflow-closure-review.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `plan/users/chenzc24/2026-06-04-remove-rules-compatibility-stubs/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `docs/phase-plans/**`
- historical target plans under `plan/users/chenzc24/**`
- historical entries in `plan/log.md` and `plan/users/chenzc24/log.md`
- `contracts/schemas/**`
- `templates/**`
- `skills/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Delete the six compatibility stub rule files.
2. Update `rules/README.md` to remove the compatibility-entry section and make
   semantic owners the only current rule entrypoints.
3. Update `llm_wiki_tools/cli.py` kernel validation so it no longer requires a
   deleted stub path.
4. Update current Person B collaboration docs to reference
   `evidence-claim-workflow.md` and `wiki-surface-workflow.md` instead of the
   deleted split files.
5. Leave historical phase plans and logs unchanged except for the new
   maintenance record.
6. Validate, commit, and push to `origin main`.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `rg -n "source-packet-to-evidence|evidence-to-claim|claim-review-routing|wiki-page-routing|wiki-index-contract|wiki-overview-log-contract" rules llm_wiki_tools skills templates AGENTS.md README.md docs/collaboration`
- `Test-Path` checks confirming the six stub files are absent
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Remove obsolete rule compatibility stubs
```

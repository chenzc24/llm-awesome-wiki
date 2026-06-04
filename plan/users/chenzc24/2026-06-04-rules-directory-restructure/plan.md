# Rules Directory Restructure Plan

## Goal

Restructure `rules/` from a flat list into progressive-disclosure subdirectories
so the main workflow and optional modules are visible from the file tree.

This is a path and navigation change, not a semantic rewrite. Existing rule
content should remain intact except for path references and the rule entry map.

## Start State

`git status --short --branch` reported `main...origin/main` with a clean
worktree.

`git submodule status` was checked because the repo contains reference
submodules; no submodule change is intended.

## Owned Files

- `rules/**`
- `skills/**/SKILL.md`
- `templates/workspace-kernel/AGENTS.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/schema.md`
- `llm_wiki_tools/cli.py`
- `README.md`
- `docs/top-level-design/system-architecture-plan.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-closure-review.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `plan/users/chenzc24/2026-06-04-rules-directory-restructure/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- historical phase plans under `docs/phase-plans/**`
- historical target plans under `plan/users/chenzc24/**` other than this target
- historical entries in `plan/log.md` and `plan/users/chenzc24/log.md`
- `contracts/schemas/**`
- `llm_wiki/**`
- `MinerU/**`
- `workspace/**`

Historical plan/log references to previous rule paths will remain historical
records rather than being rewritten.

## Target Structure

```text
rules/
  README.md
  workflow/
    maintenance-workflow.md
    distillation-rounds.md
    raw-to-source-packet.md
    source-packet-to-wiki.md
    compare-gate-contract.md
    round-closure-workflow.md
  source/
    extractor-adapter-protocol.md
    source-type-packet-profiles.md
    generated-fields-review-routing.md
  wiki/
    wiki-surface-workflow.md
    source-wiki-coverage-protocol.md
  claims/
    evidence-claim-workflow.md
    claim-modality-contradiction-review-protocol.md
  review/
    review-queue-workflow.md
```

## Implementation Steps

1. Move rule files into the target subdirectories.
2. Update `rules/README.md` so the golden path and semantic ownership map use
   the new paths.
3. Update current-facing references in skills, workspace-kernel guidance,
   validator required paths, README, top-level design, and collaboration docs.
4. Update internal cross-references inside moved rules.
5. Leave historical phase plans and older plan/log entries unchanged.
6. Validate, commit, and push to `origin main`.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` confirming current-facing files no longer reference old flat
  paths.
- `rg --files rules` confirming the new directory layout.
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Group rules by workflow area
```

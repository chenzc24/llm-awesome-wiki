# Person B README Archive Cleanup Plan

## Goal

Update the root README so it reflects the current Person B-facing system
surface, archive the old root `llm-wiki.md` concept note, and remove the
obsolete root workspace note `workspace/human-agent-rule-divergence.md`.

This target is a documentation/entrypoint cleanup. It must not change workflow
rules, schemas, checker behavior, skills, templates, tests, or submodule
pointers.

## Dirty-State Note

Start state: `git status --short --branch` reported `main...origin/main` with
a clean worktree.

## Owned Files

- `README.md`
- `llm-wiki.md`
- `docs/archive/llm-wiki.md`
- `workspace/human-agent-rule-divergence.md`
- `plan/users/chenzc24/2026-06-04-person-b-readme-archive-cleanup/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `rules/**`
- `skills/**`
- `llm_wiki_tools/**`
- `contracts/schemas/**`
- `templates/**`
- `tests/**`
- `docs/phase-plans/**`
- `docs/top-level-design/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Rewrite `README.md` as the current top-level entrypoint:
   - current status through Phase 6 and skill runtime
   - where humans, agents, rules, tools, templates, and docs live
   - how a developer should join now
2. Move root `llm-wiki.md` to `docs/archive/llm-wiki.md`.
3. Delete `workspace/human-agent-rule-divergence.md`.
4. Update maintenance logs.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` for current README terms:
  - `skills/`
  - `llm_wiki_tools/`
  - `docs/archive/llm-wiki.md`
  - `Phase 6`
  - `not an active workspace`
- confirm `llm-wiki.md` no longer exists at the repository root
- confirm `workspace/human-agent-rule-divergence.md` is deleted
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Refresh README and archive old concept note
```

Then push to `origin main` and confirm alignment.

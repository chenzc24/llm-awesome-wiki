# Agent Skill Entrypoints Plan

## Goal

Add agent-facing skill entrypoints for the LLM Wiki distillation workflow and
record the repo boundary in `AGENTS.md`: `docs/` are maintenance/design records,
`rules/` own workflow semantics, and `skills/` are the agent-facing routing
layer.

This target must not add an end-to-end workflow document under `docs/`.

## Dirty-State Note

Start state: `git status --short --branch` reported `main...origin/main` with
a clean worktree.

## Owned Files

- `AGENTS.md`
- `skills/**`
- `llm_wiki_tools/cli.py`
- `plan/users/chenzc24/2026-06-04-agent-skill-entrypoints/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `docs/**`
- `rules/**`
- `contracts/schemas/**`
- `templates/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Add a small skill set:
   - top-level `llm-wiki-distill`
   - subskill `llm-wiki-source-packet`
   - subskill `llm-wiki-wiki-round`
   - subskill `llm-wiki-quality-gate`
2. Keep SKILL.md bodies concise and procedural. Skills should route agents to
   the relevant rules and CLI checks instead of duplicating rule semantics.
3. Update `AGENTS.md` to define the boundary:
   - `docs/` are maintenance/design records, not operational workflow
     entrypoints for agents.
   - `rules/` are semantic source of truth.
   - `skills/` are agent-facing workflow entrypoints and routers.
4. Update `llm_wiki_tools` kernel validation so the system repo requires the
   new skill entrypoints.
5. Update maintenance logs and commit.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` for `docs/`, `rules/`, `skills/`, `llm-wiki-distill`,
  `llm-wiki-source-packet`, `llm-wiki-wiki-round`, and
  `llm-wiki-quality-gate`
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Add agent skill entrypoints
```

Then push to `origin main` and confirm alignment.

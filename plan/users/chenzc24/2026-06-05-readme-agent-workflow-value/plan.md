# README Agent Workflow Value Plan

## Goal

Update the README top section to distinguish the failed LLM Wiki product goal
from the useful residue: the `AGENTS.md` + `docs/` + `plan/` Agent-assisted
development workflow.

## Dirty-State Note

Start state from `git status --short --branch`:

```text
## main...origin/main
```

The worktree is clean.

## Owned Files

- `README.md`
- `plan/users/chenzc24/2026-06-05-readme-agent-workflow-value/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `AGENTS.md`
- `docs/**`
- `rules/**`
- `skills/**`
- `templates/**`
- `contracts/**`
- `llm_wiki_tools/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Expected Work

1. Reframe the README status as "failed LLM Wiki, useful Agent workflow
   record."
2. Add concise sections for what failed and what remains useful.
3. Emphasize `AGENTS.md`, target plans, scoped ownership, logs, validation,
   commits, and design history.
4. Keep existing historical system details below the top notice.

## Validation

- `git diff --check`
- targeted `rg` for the new status, useful workflow language, and failure
  boundary
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Clarify README agent workflow value
```

Then push `origin main`.

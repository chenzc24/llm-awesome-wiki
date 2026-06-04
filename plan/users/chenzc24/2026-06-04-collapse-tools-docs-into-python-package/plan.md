# Collapse Tools Docs Into Python Package Plan

## Goal

Remove `tools/` as a standalone documentation directory and move the current
tool command index into `llm_wiki_tools/README.md`, so the executable Python
package owns the tool usage surface.

`rules/` remains the workflow/protocol source of truth. `docs/phase-plans/`
remains historical planning. This target must not change checker behavior or
workflow semantics.

## Dirty-State Note

Start state: `git status --short --branch` reported `main...origin/main` with
a clean worktree.

## Owned Files

- `llm_wiki_tools/README.md`
- `llm_wiki_tools/cli.py`
- `tools/**`
- repository docs or README files that directly reference `tools/`
- `plan/users/chenzc24/2026-06-04-collapse-tools-docs-into-python-package/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `rules/**`
- `contracts/schemas/**`
- `templates/**`
- `tests/**`
- `skills/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Search for active references to `tools/` and classify them as current docs,
   historical phase-plan references, or validator requirements.
2. Add a concise `llm_wiki_tools/README.md` describing implemented commands,
   common usage, report behavior, exit codes, and non-goals.
3. Delete the obsolete `tools/` README/spec directory.
4. Update `llm_wiki_tools/cli.py` kernel validation to require
   `llm_wiki_tools/README.md` and stop requiring `tools/**`.
5. Update current-facing references from `tools/` to `llm_wiki_tools/README.md`
   where needed; avoid rewriting historical phase-plan narrative unless it
   would create an active contradiction.
6. Update maintenance logs.

## Validation

- `git diff --check`
- `python -m py_compile llm_wiki_tools/cli.py llm_wiki_tools/__main__.py`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` confirming:
  - no active `tools/` path is required by validator
  - `llm_wiki_tools/README.md` documents implemented commands
  - no `.ps1` tool implementation references remain
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Collapse tool docs into Python package
```

Then push to `origin main` and confirm alignment.

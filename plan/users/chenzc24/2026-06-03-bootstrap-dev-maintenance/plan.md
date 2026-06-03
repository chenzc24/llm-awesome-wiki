# Bootstrap VSCode-Native Dev Maintenance Workflow

## Goal

Create the first version of this repository's VSCode-native, Git-first, and
Agent-first LLM Wiki distillation workflow. The work should document the core
philosophy, define agent maintenance rules, create a planning/logging skeleton,
and mark `llm_wiki/` as reference material.

## Expected Files

- `AGENTS.md`
- `docs/core-philosophy.md`
- `docs/llm_wiki-reference.md`
- `docs/knowledge-to-executable.md`
- `docs/execution-roadmap.md`
- `plan/README.md`
- `plan/log.md`
- `tools/README.md`
- `templates/README.md`

## Implementation Steps

1. Confirm the root repository is clean with `git status --short --branch`.
2. Confirm the `llm_wiki` submodule state with `git submodule status`.
3. Add this target plan before other edits.
4. Add documentation for philosophy, reference boundaries, and execution path.
5. Add `AGENTS.md` with required working discipline.
6. Add directory README files for future tools and templates.
7. Update `plan/log.md` after validation.

## Validation

- Run `git diff --check`.
- Run `rg --files` and confirm expected files exist.
- Inspect `AGENTS.md` for git-status, pre-edit plan, post-edit log, commit, and
  push rules.
- Inspect `docs/core-philosophy.md` for VSCode-native, no Obsidian dependency,
  and knowledge-to-executable direction.
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Bootstrap VSCode-native LLM wiki workflow
```

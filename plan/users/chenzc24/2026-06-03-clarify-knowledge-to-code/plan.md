# Clarify Knowledge-To-Code Mainline

## Goal

Clarify that "knowledge should lead to execution" means a future path from a
distilled knowledge base to an executable codebase or capability library,
especially `skill + tool` artifacts. This is a major next-stage mainline, not a
task to finish in the current documentation bootstrap.

## Expected Files

- `docs/core-philosophy.md`
- `docs/execution-roadmap.md`
- `docs/knowledge-to-executable.md`
- `docs/llm_wiki-reference.md`
- `plan/log.md`

## Implementation Steps

1. State the interpretation explicitly in `docs/core-philosophy.md`.
2. Expand `docs/knowledge-to-executable.md` so it describes the future
   knowledge-to-codebase path, including skills and tools.
3. Update `docs/execution-roadmap.md` to mark this as the next major mainline
   after workflow bootstrap, with staged sub-phases.
4. Update `docs/llm_wiki-reference.md` to clarify that `llm_wiki` has agent
   access but not a designed knowledge-to-code pipeline.
5. Record validation in `plan/log.md`.

## Validation

- Run `git diff --check`.
- Search docs for `skill`, `tool`, `codebase`, and "next-stage mainline".
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Clarify knowledge-to-code execution mainline
```

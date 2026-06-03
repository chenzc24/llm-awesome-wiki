# Add Developer README

## Goal

Create a root `README.md` for developers who may join the project. The README
should explain the project thesis, how it differs from `llm_wiki`, the current
phase, repository layout, working rules, and how to contribute without
collapsing construction tooling into downstream `skill + tool` work.

## Expected Files

- `README.md`
- `plan/log.md`

## Implementation Steps

1. Add a concise root README as the primary onboarding document.
2. Link to `AGENTS.md` and the top-level architecture plan.
3. Explain Phase 1 as Repository Kernel / system structure setup.
4. Mark `llm_wiki/` as pinned reference material.
5. Record validation in `plan/log.md`.

## Validation

- Run `git diff --check`.
- Search `README.md` for `Phase 1`, `Repository Kernel`, `llm_wiki`,
  `construction tools`, and `downstream`.
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Add developer README
```

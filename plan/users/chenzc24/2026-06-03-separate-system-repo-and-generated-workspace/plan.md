# Separate System Repo And Generated Workspace

## Goal

Clarify that this repository is the producer/system repository. It should
contain architecture docs, templates, construction tools, tests, and reusable
schema contracts. It should not itself become an instantiated knowledge
workspace with active `raw/`, `wiki/`, `reports/`, or downstream `skills/`
directories.

The generated knowledge workspace is what should contain `raw/`, `wiki/`,
`reports/`, copied schema/config contracts, and optional downstream skills.

## Expected Files

- `README.md`
- `docs/top-level-design/system-architecture-plan.md`
- `plan/log.md`

## Implementation Steps

1. Update the README repository layout section to separate system repository
   areas from generated workspace layout.
2. Update the architecture plan's Repository Kernel layer to state that its
   directory map is a template contract for generated workspaces, not a list of
   live root directories to create in this repo.
3. Clarify the status of `schemas/`: root schemas are reusable contracts if
   authored here; generated workspaces may copy or reference them.
4. Record validation in `plan/log.md`.

## Validation

- Run `git diff --check`.
- Search for `system repository`, `generated workspace`, `raw/`, `wiki/`, and
  `schemas` in the updated docs.
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Separate system repo from generated workspace
```

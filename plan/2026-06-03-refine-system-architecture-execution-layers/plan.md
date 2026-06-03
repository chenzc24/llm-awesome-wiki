# Refine System Architecture Execution Layers

## Goal

Revise `docs/top-level-design/system-architecture-plan.md` so its top-level
pipeline clearly separates:

1. construction executable tools and reports that belong to knowledge-base
   construction, maintenance, compare gates, and validation; and
2. downstream executable artifacts such as domain skills, domain tools, tests,
   templates, experiments, and code.

The correction should keep the architecture aligned with the two-layer
execution philosophy already documented elsewhere.

## Expected Files

- `docs/top-level-design/system-architecture-plan.md`
- `plan/log.md`

## Implementation Steps

1. Update the Product Thesis pipeline to insert construction tools/reports and
   stable knowledge release before downstream executable specs.
2. Clarify candidate directory comments for `tools/`, `skills/`, and `tests/`.
3. Add explicit layer boundaries to Quality Gates, Construction Tooling, and
   Knowledge-To-Executable Pipeline.
4. Update phase descriptions and validations so downstream `skill + tool`
   work is not conflated with construction tooling.
5. Record validation in `plan/log.md`.

## Validation

- Run `git diff --check`.
- Search the architecture plan for `construction tools`, `stable knowledge
  release`, and `downstream`.
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Refine architecture execution layer boundaries
```

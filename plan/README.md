# Plan Directory

The `plan/` directory stores implementation intent and maintenance history.
It exists so agents do not make untracked, unplanned changes.

## Required Pattern

Before modifying repository files for a single target, create:

```text
plan/<date-goal-slug>/plan.md
```

Example:

```text
plan/2026-06-03-bootstrap-dev-maintenance/plan.md
```

Each target plan should include:

- goal
- expected changed files
- implementation steps
- validation steps
- intended commit message

## Global Log

`plan/log.md` is the maintenance log. Update it after modifications and before
commit.

Each entry should record:

- date
- target
- summary of changes
- validation performed
- commit status

## Relationship To Git

Plans are not a replacement for Git. Plans explain intent before work begins;
Git records the final checkpoint. A complete target should end with:

1. validation
2. `plan/log.md` update
3. commit
4. push

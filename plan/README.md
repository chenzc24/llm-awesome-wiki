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
- owned files or directories
- read-only files or directories
- shared-contract dependencies, if any
- implementation steps
- validation steps
- intended commit message

For multi-agent work, `Owned files` and `Read-only files` are required. A worker
should not edit files outside the owned set without updating the plan first.
Only one owner may edit a given `contracts/schemas/*` schema at a time, and
shared terminology or top-level design changes should be Coordinator-owned.

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

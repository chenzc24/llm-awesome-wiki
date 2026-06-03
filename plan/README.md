# Plan Directory

The `plan/` directory stores implementation intent and maintenance history.
It exists so agents do not make untracked, unplanned changes.

## Required Pattern

Before modifying repository files for a single target, create a plan in the
appropriate namespace.

Individual co-worker work:

```text
plan/users/<user>/<date-goal-slug>/plan.md
```

Example:

```text
plan/users/chenzc24/2026-06-03-source-packet-contract/plan.md
```

`<user>` means the human or co-worker owner, not the executor agent. Agent names
such as `codex` should not be used as user namespaces. If an agent performs work
for `chenzc24`, the plan belongs under `plan/users/chenzc24/`.

Shared integration work:

```text
plan/shared/integration/<date-goal-slug>/plan.md
```

Example:

```text
plan/shared/integration/2026-06-03-merge-contracts/plan.md
```

Historical plans from before the multi-person namespace convention have been
classified under `plan/users/chenzc24/`. New work should use the namespaced
paths.

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

## Personal Logs

Each co-worker should have a personal log:

```text
plan/users/<user>/log.md
```

The personal log records individual task outcomes, validation, unresolved
issues, and commit references before or after integration.

## Global Log

`plan/log.md` is the global integration and maintenance log. It should record
work that has been merged, pushed, or accepted as repository-level history. In
multi-person work, this log is maintained by the Coordinator or merge owner.

Each entry should record:

- date
- target
- summary of changes
- validation performed
- commit status

## Phase Plans

`docs/phase-plans/` stores phase-level system plans. These are important shared
plans, not personal execution plans. They should be Coordinator-owned unless a
target plan explicitly claims ownership of a specific phase-plan file.

## Relationship To Git

Plans are not a replacement for Git. Plans explain intent before work begins;
Git records the final checkpoint. A complete target should end with:

1. validation
2. `plan/log.md` update
3. commit
4. push

# Maintenance Workflow

Generated workspaces should remain easy to inspect, diff, and hand off between
humans and agents.

## Before Work

- Run `git status --short --branch`.
- Confirm there are no unrelated uncommitted changes.
- Write or update a workspace plan before editing tracked files.
- Identify whether the target is raw conversion, wiki distillation, compare,
  lint, review, or downstream execution.

Workspace plans should live under `plan/<date-goal-slug>/plan.md` unless the
workspace chooses a different path in `schema.md`.

For multi-agent or co-worker work, each plan must also declare:

- `Owned files`: files or directories the worker is allowed to modify.
- `Read-only files`: files or directories the worker may inspect but must not
  modify.
- shared contracts or schemas the task depends on.
- the Coordinator or integration owner for shared terminology decisions.

## During Work

- Keep changes scoped to the current target.
- Preserve source files.
- Record uncertain semantic judgments as review items.
- Prefer deterministic tooling for paths, hashes, parsing, and validation.
- Keep generated reports in the configured report directory.
- Do not edit another worker's owned files without updating the plan and
  getting Coordinator approval.
- Do not change shared terminology or top-level design boundaries unless the
  task is Coordinator-owned. Submit a proposal instead.
- Only one owner may edit a given `contracts/schemas/*` schema at a time.
- Treat pinned reference repositories, including `llm_wiki/` when present, as
  read-only unless the user explicitly requests a pointer update or direct
  work inside that repository.

## After Work

- Update the workspace log.
- Run available validation commands.
- Review the diff.
- Commit only intended files.
- Push according to the workspace's branch policy.
- At minimum, run `git diff --check` and `git status --short --branch`.
- Also run any relevant schema, validator, lint, or compare command for the
  files touched by the task.

The workspace log should record target, changed areas, validation, unresolved
review items, commit hash, and push status when available.

## Multi-Agent Coordination

Use file ownership to keep parallel work safe:

- Contracts owner: owns the specific schema files named in their plan.
- Workflow owner: owns the rule, template, or tool-surface files named in their
  plan.
- Coordinator: owns shared terminology, phase boundaries, and integration
  decisions.

When two tasks need the same file, stop and split the work by sequence or by
smaller ownership scopes before editing. Prefer proposals in plan notes or
review comments over opportunistic edits to shared files.

## Long-Term Hygiene

- Archive or summarize completed plans.
- Keep stale review items visible until resolved.
- Keep `wiki/index.md` and `wiki/log.md` parseable with simple text tools.
- Periodically check source coverage, claim coverage, and broken links.

## Commit Discipline

- Use small commits that match one round or maintenance target.
- Do not mix generated knowledge updates with rule or template changes unless
  the plan explicitly says so.
- Do not commit raw source deletion without a report explaining the cascade.
- Keep failed or abandoned plans visible until their status is recorded.

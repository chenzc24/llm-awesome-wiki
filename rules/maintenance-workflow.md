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

## During Work

- Keep changes scoped to the current target.
- Preserve source files.
- Record uncertain semantic judgments as review items.
- Prefer deterministic tooling for paths, hashes, parsing, and validation.
- Keep generated reports in the configured report directory.

## After Work

- Update the workspace log.
- Run available validation commands.
- Review the diff.
- Commit only intended files.
- Push according to the workspace's branch policy.

The workspace log should record target, changed areas, validation, unresolved
review items, commit hash, and push status when available.

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

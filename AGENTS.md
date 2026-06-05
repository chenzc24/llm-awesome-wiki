# Agent Working Rules

This repository is a VSCode-native, Git-first LLM Wiki distillation workflow.
Agents maintain the workflow as an engineering project, not as an Obsidian vault
or a desktop-app extension.

## Operating Discipline

Before starting any single target:

1. Run `git status --short --branch` from the repository root.
2. Perform a dirty-state audit:
   - If the worktree is clean, proceed normally.
   - If the worktree is dirty, identify the changed paths and whether they
     belong to the user, another co-worker, or a previous task.
   - Do not require a fully clean repository when the dirty paths are unrelated
     to the current target.
   - Stop before editing if any dirty path overlaps the current target's
     `Owned files`, if ownership is unclear, or if the dirty state changes a
     shared contract the current target depends on.
   - If proceeding with unrelated dirty files present, record that decision in
     the target plan.
3. Run `git submodule status` when the task touches or references `llm_wiki`.
4. Treat `llm_wiki/` as a pinned reference submodule unless the user explicitly
   asks to update that pointer or work inside that repository.

Before making modifications:

1. Create a target-specific plan before editing tracked files.
   - Individual co-worker work goes under
     `plan/users/<user>/<date-goal-slug>/plan.md`.
   - Shared integration work goes under
     `plan/shared/integration/<date-goal-slug>/plan.md`.
   - Historical root-level target plans have been classified under
     `plan/users/chenzc24/`; new work should use the namespaced paths.
   - User namespaces represent human/co-worker ownership, such as
     `plan/users/chenzc24/`. Executor agent names such as `codex` are not user
     namespaces. If an agent works on behalf of a human owner, use that human
     owner's namespace.
2. The plan must state the goal, expected files, validation steps, and commit
   intent.
3. In multi-agent or co-worker work, the plan must also declare:
   - `Owned files`: files or directories this worker may edit.
   - `Read-only files`: files or directories this worker may inspect but not
     edit.
   - expected shared-contract dependencies, if any.
4. If the worktree was dirty at start, the plan must include a dirty-state note
   listing the unrelated dirty paths or explaining why the target is blocked.
5. Do not begin content or code edits until the plan is written.

Multi-agent coordination:

1. Every co-worker must create their own target plan before editing tracked
   files.
   Executor agents act inside the human owner's namespace rather than creating
   their own user directory.
2. Keep file ownership explicit. Do not edit another worker's owned files
   without a new plan update or Coordinator approval.
   A dirty worktree is acceptable only when dirty files do not overlap the
   current target's owned files or shared dependencies.
3. Only one owner may edit a given `contracts/schemas/*` schema at a time.
   Other workers should submit notes, proposals, or review comments instead of
   changing that schema directly.
4. Shared terminology, architecture boundaries, and top-level design documents
   are Coordinator-owned. Non-coordinator workers should propose changes rather
   than directly editing `docs/top-level-design/**` or other shared vocabulary
   sources.
5. Phase-level plans under `docs/phase-plans/**` are important shared plans and
   are Coordinator-owned unless a task explicitly claims ownership of a specific
   phase-plan file.
6. Each co-worker has a personal log at `plan/users/<user>/log.md`. Record
   personal task outcomes there before integration.
7. The global `plan/log.md` records merged or integration-level maintenance
   history and should be updated by the Coordinator or merge owner.
8. Each PR or commit must run at least `git diff --check`,
   `git status --short --branch`, and any relevant schema or validator command.
9. Treat `llm_wiki/` as read-only for all co-workers unless the user explicitly
   asks to update the submodule pointer or work inside that repository.

After making modifications:

1. Update `plan/log.md` with a short maintenance record.
2. Include the target, changed areas, validation performed, and commit status.
3. Run the validation listed in the target plan.
4. At minimum, run `git diff --check` and `git status --short --branch`.

Plan hygiene:

1. Periodically clean completed target plans so `plan/` stays useful.
2. At the end of a day or completed stage, summarize finished
   personal plan entries into `plan/users/<user>/log.md`.
3. After the summary preserves the goal, outcome, validation, and commit hash,
   remove or archive the detailed completed plan folders.
4. Keep `plan/log.md` focused on merged or integration-level history rather
   than every individual draft task.
5. Never delete an in-progress, failed, or unresolved plan. Keep it visible
   until the work is finished or explicitly abandoned.

When the target is verified:

1. Stage only the intended files.
2. Commit with a clear message.
3. Push with `git push origin main`, unless the user explicitly requests a
   different branch or remote.
4. Confirm that `main` and `origin/main` are aligned afterward.

## Project Direction

- Prefer VSCode, Git, CLI tools, and repo-local documentation as the primary
  working environment.
- Do not make Obsidian a required dependency. Markdown compatibility is welcome,
  but Obsidian plugins and graph views are not the source of truth.
- The knowledge base must support a path from source material to executable
  artifacts: specs, scripts, tests, experiments, templates, and code.
- Avoid model self-evaluation as the only quality gate. Prefer deterministic
  checks, source coverage tables, claim-to-source mapping, and human review
  queues where judgment is required.
- Keep `llm_wiki/` as reference material for structure and product ideas. The
  root repository defines the portable workflow.

## Agent Entrypoint Boundary

- `docs/` contains system design, phase planning, collaboration notes, and
  maintenance history. Do not treat `docs/` as the operational entrypoint for a
  distillation round.
- `rules/` is the semantic source of truth for workflow behavior. Rules define
  statuses, lifecycle meanings, routing requirements, acceptance criteria, and
  forbidden shortcuts.
- `skills/` is the agent-facing entrypoint layer. Skills should route agents
  through the workflow and point to the relevant rules. Skills should not copy
  or redefine rule semantics.
- For end-to-end distillation, start from
  `skills/llm-wiki-distill/SKILL.md`, then load only the subskill needed for
  the active stage.

## Repository Topology Boundary

- This repository is the system repo. It owns reusable skills, rules,
  templates, contracts, checker source, tests, and design records.
- `templates/workspace-kernel/` is the workspace skeleton, not the complete
  runtime bundle by itself.
- A complete workspace kernel bundle is the skeleton plus copied or
  synchronized `skills/`, `rules/`, `contracts/schemas/`, and checker access.
- A knowledge workspace repo is an independent Git repo that owns live
  `raw/`, `wiki/`, `reports/`, `plan/`, `purpose.md`, and `schema.md`.
- Do not mix system repo asset edits with live knowledge workspace artifact
  edits in one commit.
- If a workspace distillation round exposes a missing rule, template, schema,
  or checker behavior, record it as a separate system repo task.

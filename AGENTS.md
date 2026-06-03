# Agent Working Rules

This repository is a VSCode-native, Git-first LLM Wiki distillation workflow.
Agents maintain the workflow as an engineering project, not as an Obsidian vault
or a desktop-app extension.

## Operating Discipline

Before starting any single target:

1. Run `git status --short --branch` from the repository root.
2. Confirm the root repository is clean. If it is not clean, stop and identify
   whether the changes belong to the user or to a previous task.
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
4. Do not begin content or code edits until the plan is written.

Multi-agent coordination:

1. Every co-worker must create their own target plan before editing tracked
   files.
   Executor agents act inside the human owner's namespace rather than creating
   their own user directory.
2. Keep file ownership explicit. Do not edit another worker's owned files
   without a new plan update or Coordinator approval.
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

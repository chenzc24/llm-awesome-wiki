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

1. Create a target-specific plan at `plan/<date-goal-slug>/plan.md`.
2. The plan must state the goal, expected files, validation steps, and commit
   intent.
3. Do not begin content or code edits until the plan is written.

After making modifications:

1. Update `plan/log.md` with a short maintenance record.
2. Include the target, changed areas, validation performed, and commit status.
3. Run the validation listed in the target plan.
4. At minimum, run `git diff --check` and `git status --short --branch`.

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

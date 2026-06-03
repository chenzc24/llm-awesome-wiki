# Workspace Agent Rules

This repository is a knowledge workspace generated from the LLM Awesome Wiki
workspace kernel. It is VSCode-native, Git-first, and agent-maintained.

## Before Work

1. Run `git status --short --branch`.
2. Confirm unrelated changes are not mixed into the current target.
3. Read `purpose.md`, `schema.md`, and `wiki/index.md` when they exist.
4. Create or update a target plan before editing tracked files.

## During Work

1. Treat `raw/sources/` as immutable source material.
2. Convert raw files into source packets under `raw/derived/` before wiki
   distillation when a structured packet is feasible.
3. Keep wiki claims traceable to source packets or source identities.
4. Put uncertain semantic judgment into review items or reports.
5. Update `wiki/index.md` and `wiki/log.md` after accepted wiki changes.

## After Work

1. Run available validation commands.
2. Write reports under `reports/`.
3. Review the diff.
4. Commit only intended files.
5. Push according to the workspace branch policy.

## Non-Goals

- Do not require Obsidian.
- Do not depend on a desktop app as the source of truth.
- Do not use model self-evaluation as the only quality gate.
- Do not generate downstream skills or tools until the knowledge release is
  stable and explicitly planned.

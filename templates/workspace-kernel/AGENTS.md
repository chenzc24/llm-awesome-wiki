# Workspace Agent Rules

This repository is a knowledge workspace generated from the LLM Awesome Wiki
workspace kernel. It is VSCode-native, Git-first, and agent-maintained.

## Before Work

1. Run `git status --short --branch`.
2. Confirm unrelated changes are not mixed into the current target.
3. Read `purpose.md`, `schema.md`, and `wiki/index.md` when they exist.
4. If workspace rules are copied into this repo, start from `rules/README.md`
   and follow its default golden path before opening specialized rule modules.
5. Create or update `plan/<date-goal-slug>/plan.md` before editing tracked
   files.

## During Work

1. Treat `raw/sources/` as immutable source material.
2. Convert raw files into source packets under `raw/derived/` before wiki
   distillation when a structured packet is feasible.
3. Treat source packets as audit baselines, not semantic ceilings.
4. Keep source identities, hashes, anchors, and extraction gaps visible.
5. Cite packet anchors as `<source_id>#<anchor_id>`.
6. For important sourced knowledge, create or update a concise claim/evidence
   map according to the evidence/claim workflow before treating a claim as
   supported.
7. Keep generated evidence, such as OCR, captions, chart summaries, table
   repairs, formula recognition, and agent notes, visibly marked.
8. Apply the wiki surface workflow and write semantic draft plus construction
   analysis before creating or updating accepted wiki pages.
9. Run a grounding pass for important definitions, formulas, derivations,
   examples, tables, and implications.
10. Keep wiki claims traceable to source packet anchors, evidence records, or
   review items.
11. Put uncertain semantic judgment into review items or reports.
12. Refresh `wiki/overview.md` when corpus map, coverage, or chapter structure
    changes.
13. Update `wiki/index.md` and `wiki/log.md` after accepted wiki changes.
14. Record why overview or index did not change when a wiki construction round
    inspected them but left them unchanged.

## After Work

1. Run available validation commands.
2. Write reports under `reports/`.
3. Update `plan/log.md` with target, changed areas, validation, and commit
   status.
4. Review the diff.
5. Commit only intended files.
6. Push according to the workspace branch policy.

## Non-Goals

- Do not require Obsidian.
- Do not depend on a desktop app as the source of truth.
- Do not use model self-evaluation as the only quality gate.
- Do not turn every sentence into a claim record; preserve source/chapter
  readability as the default wiki surface.
- Do not generate downstream skills or tools until the knowledge release is
  stable and explicitly planned.

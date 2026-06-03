# Phase 2.1 Source Intake And Inventory

## Goal

Advance Phase 2.1 by turning source intake and inventory into a clear
workflow/tool-surface layer.

This target stabilizes what happens after a user places raw files under
`raw/sources/` and before source-packet extraction begins. It does not implement
the source inventory command, update schemas, build validators, run MinerU, or
convert raw files.

## Dirty-State Note

Initial `git status --short --branch` was clean on
`co-work/czc_personB...origin/co-work/czc_personB`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.1-source-intake-inventory.md`
- `rules/raw-to-source-packet.md`
- `templates/workspace-kernel/raw/source-inventory.template.md`
- `tools/source-inventory/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-1-source-intake-inventory/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `MinerU/**`
- `llm_wiki/**`
- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- other `rules/**`
- other `templates/workspace-kernel/**`
- other `tools/**`

## Shared Dependencies

- Phase 2 plan:
  `docs/phase-plans/phase-2-raw-resource-conversion.md`
- Person B phase assignment:
  `docs/collaboration/person-b-workflow-surface-by-phase.md`
- Person A ownership of schemas, validator behavior, and fixtures

## Expected Changes

- Add a Phase 2.1 phase plan that defines source intake, inventory rows, status
  transitions, unsupported-source handling, and Person A handoff needs.
- Refine `rules/raw-to-source-packet.md` so source identity and inventory happen
  before packet writing.
- Update `templates/workspace-kernel/raw/source-inventory.template.md` with
  clearer columns, status rules, and examples.
- Expand `tools/source-inventory/README.md` into a future CLI behavior spec
  without implementing the command.

## Validation

- `git diff --check`
- targeted `rg` for Phase 2.1, source intake, source inventory, stable
  `source_id`, status transitions, hash, unsupported, and Person A handoff
  language
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push on `co-work/czc_personB` with:

```text
Define source intake inventory workflow
```

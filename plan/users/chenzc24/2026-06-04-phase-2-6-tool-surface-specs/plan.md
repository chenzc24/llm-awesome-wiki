# Phase 2.6 Tool Surface Specs

## Goal

Define README-level behavior specifications for the Phase 2 construction tool
surface.

This target translates Phase 2.1 through Phase 2.5 workflow protocols into
future CLI/tool surfaces for source inventory, source packet conversion, and
source packet linting.

This target is specification-only. It does not implement tools, write scripts,
run extractors, edit schemas, create fixtures, generate wiki pages, extract
claims, implement compare gates, or start downstream skill/tool work.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.6-tool-surface-specs.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `tools/README.md`
- `tools/source-inventory/README.md`
- `tools/source-packet-convert/README.md`
- `tools/source-packet-lint/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-6-tool-surface-specs/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `docs/phase-plans/phase-2.1-source-intake-inventory.md`
- `docs/phase-plans/phase-2.2-source-packet-protocol.md`
- `docs/phase-plans/phase-2.3-extractor-adapter-protocol.md`
- `docs/phase-plans/phase-2.4-source-type-packet-profiles.md`
- `docs/phase-plans/phase-2.5-generated-fields-review-routing.md`
- `MinerU/**`
- `llm_wiki/**`

## Shared Dependencies

- Phase 2.1 source inventory workflow
- Phase 2.2 source packet protocol
- Phase 2.3 extractor adapter protocol
- Phase 2.4 source-type packet profiles
- Phase 2.5 generated fields and review routing
- Person A ownership of schemas, validators, and fixtures

## Expected Changes

- Add a Phase 2.6 phase plan for tool surface specs.
- Update the main Phase 2 plan so Phase 2.5 is complete and Phase 2.6 is the
  current target.
- Update the root tools index with the Phase 2 tool trio:
  `source-inventory`, `source-packet-convert`, and `source-packet-lint`.
- Align `tools/source-inventory/README.md` with the current Phase 2 protocol.
- Add README-level specs for `source-packet-convert` and `source-packet-lint`.
- Record the result in the global and personal logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for `Tool Surface Specs`, `source-inventory`,
  `source-packet-convert`, `source-packet-lint`, `inputs`, `outputs`,
  `failure modes`, `exit codes`, `deterministic`, `adapter`,
  `generated_fields`, `review_required`, `known_gaps`, and `Non-Goals`
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Define phase two tool surface specs
```

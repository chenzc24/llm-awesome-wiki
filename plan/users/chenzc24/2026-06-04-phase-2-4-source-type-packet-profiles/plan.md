# Phase 2.4 Source-Type Packet Profiles

## Goal

Define minimum source packet expectations for common source types after the
Phase 2.3 extractor adapter boundary is established.

This target keeps Phase 2 protocol-first. It does not implement parsers, run
MinerU, write adapter code, write CLI README specs, update schemas, generate
wiki pages, extract claims, or implement compare gates.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.4-source-type-packet-profiles.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `rules/source-type-packet-profiles.md`
- `rules/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-4-source-type-packet-profiles/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `tests/fixtures/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `docs/phase-plans/phase-2.1-source-intake-inventory.md`
- `docs/phase-plans/phase-2.2-source-packet-protocol.md`
- `docs/phase-plans/phase-2.3-extractor-adapter-protocol.md`
- `rules/raw-to-source-packet.md`
- `rules/extractor-adapter-protocol.md`
- `templates/workspace-kernel/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Dependencies

- Phase 2.1 source inventory workflow
- Phase 2.2 source packet protocol
- Phase 2.3 extractor adapter protocol
- Artifact economy and raw-wiki alignment boundaries
- Person A ownership of schema, validator, and fixture changes

## Expected Changes

- Add a Phase 2.4 phase plan for source-type packet profiles.
- Add a rule that defines minimum packet expectations for PDF, PPTX, DOCX,
  image, table/dataset, and mixed-media sources.
- Update the main Phase 2 plan so Phase 2.3 is complete and the immediate next
  step is Phase 2.4.
- Update the rules index to include the new source-type packet profile rule.
- Record the result in the global and personal logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for `Source-Type Packet Profiles`, `PDF`, `PPTX`, `DOCX`,
  `image`, `table`, `mixed media`, `page-level anchors`, `slide-level anchors`,
  `heading hierarchy`, `generated captions`, `review routing`, and
  `non-goals`
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Define source-type packet profiles
```

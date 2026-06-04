# Phase 2.5 Generated Fields And Review Routing

## Goal

Define trust boundaries and review routing for generated or model-assisted
content inside source packets.

This target explains how OCR text, image captions, chart summaries, table
repairs, formula recognition, inferred reading order, visual descriptions,
agent notes, normalized values, inferred headings, and cross-file summaries
should be labeled, reviewed, and handed off to later claim and wiki stages.

This target is protocol-only. It does not implement validators, edit schemas,
write CLI specs, generate wiki pages, extract claims, implement compare gates,
or run any extractor backend.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.5-generated-fields-review-routing.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `rules/generated-fields-review-routing.md`
- `rules/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-5-generated-fields-review-routing/plan.md`
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
- `docs/phase-plans/phase-2.4-source-type-packet-profiles.md`
- `rules/raw-to-source-packet.md`
- `rules/extractor-adapter-protocol.md`
- `rules/source-type-packet-profiles.md`
- `templates/workspace-kernel/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Dependencies

- Phase 2.2 source packet metadata and anchor protocol
- Phase 2.3 extractor adapter failure behavior
- Phase 2.4 source-type packet profile generated-content references
- Person A ownership of schema, validator, and fixture changes

## Expected Changes

- Add a Phase 2.5 phase plan for generated fields and review routing.
- Add an operational rule that defines generated content types, trust levels,
  packet marking, review triggers, and handoff boundaries for later claim/wiki
  stages.
- Update the main Phase 2 plan so Phase 2.4 is complete and the immediate next
  step is Phase 2.5.
- Update the rules index to include the new generated-fields rule.
- Record the result in the global and personal logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for `Generated Fields And Review Routing`,
  `source-equivalent`, `ocr_text`, `image_caption`, `chart_summary`,
  `table_repair`, `formula_recognition`, `inferred_reading_order`,
  `review_required`, `review_reason`, `known_gaps`, `generated content`,
  `Person A Handoff`, and `Non-Goals`
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Define generated fields review routing
```

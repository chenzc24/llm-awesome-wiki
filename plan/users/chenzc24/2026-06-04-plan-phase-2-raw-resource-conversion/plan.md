# Plan Phase 2 Raw Resource Conversion

## Goal

Create the Person B Phase 2 plan for the raw-resource-to-source-packet
subsystem, using `MinerU/` as a read-only reference for document parsing
patterns while preserving this project's VSCode-native, Git-first,
Agent-first workflow.

This target plans Phase 2. It does not implement the raw converter, change JSON
schemas, create test fixtures, or run MinerU.

## Dirty-State Note

Initial `git status --short --branch` was clean on
`co-work/czc_personB...origin/co-work/czc_personB`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `plan/users/chenzc24/2026-06-04-plan-phase-2-raw-resource-conversion/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `MinerU/**`
- `llm_wiki/**`
- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- existing `rules/**`
- existing `templates/workspace-kernel/**`
- existing `tools/*/README.md`

## Shared Dependencies

- Person B Phase 2 guidance in
  `docs/collaboration/person-b-workflow-surface-by-phase.md`
- Person A ownership of schemas, validation, and fixtures
- Root `AGENTS.md` branch and maintenance rules

## Expected Changes

- Add a Phase 2 plan document that:
  - explains why Phase 2 is the raw-resource conversion layer
  - summarizes what MinerU contributes as reference material
  - states what this project will not inherit from MinerU
  - defines Phase 2 deliverables for rules, templates, tool README specs, and
    Person A handoff proposals
  - keeps CPU-first deterministic extraction as the baseline
  - treats OCR, VLM, chart captions, and generated descriptions as optional
    generated fields requiring traceability and review

## Validation

- `git diff --check`
- `rg --files docs/phase-plans plan/users/chenzc24 | sort`
- targeted `rg` for Phase 2, MinerU, source packet, CPU-first, generated
  fields, and Person A handoff language
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push on `co-work/czc_personB` with:

```text
Plan phase two raw resource conversion
```

# Reframe Phase 2 Protocol First

## Goal

Adjust Phase 2 and collaboration guidance after deciding that Phase 2 is a
raw-resource-to-source-packet protocol layer, not a MinerU-style document
parsing harness or extractor implementation.

The ownership split remains stable:

- Person B defines workflow, protocol, templates, and tool surfaces.
- Person A defines schemas, validation, and fixtures that check those protocol
  artifacts.

## Dirty-State Note

Initial `git status --short --branch` was clean on
`co-work/czc_personB...origin/co-work/czc_personB`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/phase-plans/phase-1.1-workspace-kernel-closure.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `plan/users/chenzc24/2026-06-04-reframe-phase-2-protocol-first/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `MinerU/**`
- `llm_wiki/**`
- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`
- `docs/top-level-design/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tools/*/README.md`

## Shared Dependencies

- Person A owns contracts, validation, and fixtures.
- Person B owns phase plans, workflow prose, templates, and tool README specs.
- Phase 2.1 source intake/inventory is already complete and should not be
  reopened except for wording consistency if needed later.

## Expected Changes

- Reframe Phase 2 as `Raw Resource To Source Packet Protocol`.
- Make clear that MinerU contributes output-structure ideas, not its harness,
  backend orchestration, GPU/VLM stack, or parser implementation.
- Change the Phase 2 work breakdown to:
  - Phase 2.1 Source Intake And Inventory
  - Phase 2.2 Source Packet Protocol
  - Phase 2.3 Extractor Adapter Protocol
  - Phase 2.4 Source-Type Packet Profiles
  - Phase 2.5 Generated Fields And Review Routing
  - Phase 2.6 Tool Surface Specs
- Update Person A/B collaboration guidance so Person B defines protocol and
  Person A validates protocol artifacts.
- Keep file ownership unchanged.

## Validation

- `git diff --check`
- targeted `rg` for protocol-first language, extractor adapter, source packet
  protocol, no harness implementation, and unchanged ownership language
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push on `co-work/czc_personB` with:

```text
Reframe phase two as packet protocol
```

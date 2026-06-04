# Phase 2.3 Extractor Adapter Protocol

## Goal

Define how any optional extractor, human workflow, agent, MCP, local CLI, or
external backend can legally connect to the workspace and produce the Phase 2.2
source packet protocol.

This target is protocol-only. It does not implement a parser, run MinerU, build
an MCP adapter, write CLI README specs, create source-type packet profiles, or
edit schemas.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.3-extractor-adapter-protocol.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `rules/extractor-adapter-protocol.md`
- `rules/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-3-extractor-adapter-protocol/plan.md`
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
- `rules/raw-to-source-packet.md`
- `templates/workspace-kernel/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Dependencies

- Phase 2.1 source inventory workflow
- Phase 2.2 source packet protocol
- Artifact economy and raw-wiki alignment boundaries
- Person A ownership of schema, validator, and fixture changes

## Expected Changes

- Add a Phase 2.3 plan that defines the adapter position:
  `ready inventory row -> optional adapter -> valid source packet`.
- Add an extractor adapter rule that defines required inputs, outputs, backend
  declaration, workspace anchor mapping, visible failure protocol, and typical
  adapter examples.
- Update the main Phase 2 plan so Phase 2.2 is complete and the immediate next
  step is Phase 2.3.
- Update the rules index to include the new adapter protocol.
- Record the result in the global and personal logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for `Extractor Adapter Protocol`, `optional adapter`,
  `workspace owner`, `extraction_backend`, `backend-local`, `workspace anchor`,
  `failed visibly`, `manual`, `Agent/MCP`, `MinerU/local CLI`, and `non-goals`
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Define extractor adapter protocol
```

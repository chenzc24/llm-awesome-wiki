# Phase 2.2 Source Packet Protocol

## Goal

Advance Person B Phase 2.2 by defining the source packet protocol that every
human, agent, MCP, local CLI, optional extractor, or manual workflow must
satisfy after a source inventory row becomes ready.

This target keeps Phase 2 protocol-first. It does not implement a PDF/PPTX/DOCX
parser, run MinerU, build an MCP adapter, generate wiki pages, or edit schemas.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/phase-plans/phase-2.2-source-packet-protocol.md`
- `rules/raw-to-source-packet.md`
- `templates/workspace-kernel/raw/source-packet.template.md`
- `templates/workspace-kernel/raw/derived/README.md`
- `plan/users/chenzc24/2026-06-04-phase-2-2-source-packet-protocol/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `MinerU/**`
- `llm_wiki/**`
- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- other `docs/phase-plans/**`
- other `rules/**`
- other `templates/**`

## Shared Dependencies

- Top-level artifact economy and raw-wiki alignment design
- Phase 2 protocol-first plan
- Phase 2.1 source intake and inventory workflow
- Person A ownership of schemas, validation, and fixtures

## Expected Changes

- Add a Phase 2.2 phase plan that defines packet purpose, files, metadata,
  anchors, generated fields, gaps, review routing, and Person A handoff needs.
- Update `rules/raw-to-source-packet.md` so packet protocol is explicit after
  the Phase 2.1 intake gate.
- Update the workspace source packet template so `metadata` is the source of
  truth for identity/backend/status and `source.md` remains extracted/audit
  content rather than a wiki article.
- Update the derived packet README with the expected directory shape and
  artifact economy boundary.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for Phase 2.2, source packet protocol, audit layer,
  agent-readable wiki, metadata source of truth, anchors, generated fields,
  known gaps, and Person A handoff language
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Define source packet protocol
```

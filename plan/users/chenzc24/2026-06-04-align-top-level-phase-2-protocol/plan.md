# Align Top-Level Phase 2 Protocol Wording

## Goal

Align top-level design wording with the current Phase 2 decision:

Phase 2 is a raw-resource-to-source-packet protocol and raw-wiki alignment
substrate. It is not a MinerU-style harness, not a project-owned PDF/PPTX/DOCX
parser implementation, and not an extractor-first plan.

After this small correction, push the result to `main`, then plan the next
Person B Phase 2.2 work.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/top-level-design/system-architecture-plan.md`
- `docs/top-level-design/README.md`
- `plan/users/chenzc24/2026-06-04-align-top-level-phase-2-protocol/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `MinerU/**`
- `llm_wiki/**`
- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `rules/**`
- `templates/**`
- `docs/phase-plans/**`
- `docs/collaboration/**`

## Expected Changes

- Reframe top-level Layer 2 from raw resource conversion implementation toward
  source packet protocol and raw-wiki alignment substrate.
- Rename Phase 2 wording in the top-level build phase to avoid implying a
  project-owned parser harness.
- Convert PDF/PPTX/DOCX handling text into source-type packet profile
  requirements rather than parser pipelines.
- Keep construction tool wording compatible with future optional adapters.

## Validation

- `git diff --check`
- targeted `rg` for source packet protocol, raw-wiki alignment substrate,
  source-type packet profiles, optional extractors, and parser harness non-goal
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Align top-level phase two protocol wording
```

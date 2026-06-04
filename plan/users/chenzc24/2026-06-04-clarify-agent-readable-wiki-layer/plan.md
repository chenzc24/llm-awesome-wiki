# Clarify Agent-Readable Wiki Layer

## Goal

Refine the artifact-economy language so the wiki layer is described as
agent-readable first and human-reviewable second. This is a terminology and
template-language adjustment, not a Phase 1 redesign or directory change.

## Dirty-State Note

The worktree was clean at start on `main`.

## Expected Files

- `docs/top-level-design/artifact-economy-and-raw-wiki-alignment.md`
- `docs/top-level-design/system-architecture-plan.md`
- `docs/top-level-design/README.md`
- `docs/core-philosophy.md`
- `docs/knowledge-to-executable.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `templates/workspace-kernel/wiki/chapters/README.md`
- `templates/workspace-kernel/wiki/chapters/chapter-page.template.md`
- `templates/workspace-kernel/wiki/sources/source-page.template.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `docs/top-level-design/**`
- `docs/core-philosophy.md`
- `docs/knowledge-to-executable.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `templates/workspace-kernel/wiki/**`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-04-clarify-agent-readable-wiki-layer/**`

## Read-only Files

- `contracts/schemas/**`
- `rules/**`
- `tools/**`
- `tests/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Contract Dependencies

None. This task changes architecture language and wiki template wording only.

## Implementation Steps

1. Replace human-readable-first wording with agent-readable,
   human-reviewable language.
2. Clarify wiki scanability priorities: agent scanability, traceability,
   human reviewability, prose elegance.
3. Update chapter/source page template wording so wiki pages are structured
   knowledge surfaces, not prose essays or audit packets.
4. Update maintenance logs.

## Validation

- Run `git diff --check`.
- Run targeted `rg` checks for:
  - `agent-readable`
  - `human-reviewable`
  - `agent-readable, human-reviewable`
  - `agent scanability`
- Run `git status --short --branch`.
- Confirm `MinerU/` and `llm_wiki/` remain pinned.

## Commit Intent

Commit with message `Clarify agent-readable wiki layer` and push `main`.

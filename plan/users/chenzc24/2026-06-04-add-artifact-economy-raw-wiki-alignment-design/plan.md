# Add Artifact Economy And Raw-Wiki Alignment Design

## Goal

Promote artifact economy and raw-wiki alignment into top-level design
constraints that apply across every phase. The adjustment should make clear
that concise directory shape is only a means; the real system goal is to keep
readable wiki knowledge aligned with raw sources through stable source
identity, anchors, coverage, and review.

## Dirty-State Note

The worktree was clean at start on branch `co-work/czc_personB`.

## Expected Files

- `docs/top-level-design/artifact-economy-and-raw-wiki-alignment.md`
- `docs/top-level-design/system-architecture-plan.md`
- `docs/top-level-design/README.md`
- `docs/knowledge-to-executable.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `docs/top-level-design/**`
- `docs/knowledge-to-executable.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-04-add-artifact-economy-raw-wiki-alignment-design/**`

## Read-only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/**`
- `tools/**`
- `tests/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Contract Dependencies

None. This is a design-layer update. It may create future schema and validator
handoff needs, but it does not edit contracts directly.

## Implementation Steps

1. Add a top-level design document for artifact economy and raw-wiki alignment.
2. Update the system architecture plan so raw-wiki alignment is the primary
   quality axis and artifact economy is a cross-cutting invariant.
3. Update Phase 2 positioning so raw-resource conversion is framed as the raw
   side of a raw-wiki alignment substrate.
4. Update knowledge-to-executable so downstream artifacts consume stable
   readable knowledge/specs, not verbose audit noise.
5. Update Person A/B collaboration docs so Person A avoids schema-driven
   duplicate truth sources and Person B owns readable workflow/output surfaces.
6. Update maintenance logs.

## Validation

- Run `git diff --check`.
- Run targeted `rg` checks for:
  - `raw-wiki alignment`
  - `artifact economy`
  - `one fact, one source of truth`
  - `readable layer`
  - `audit layer`
  - `alignment reports`
- Run `git status --short --branch`.
- Confirm `MinerU/` and `llm_wiki/` remain read-only.

## Commit Intent

Commit with message `Add artifact economy and raw-wiki alignment design` and
push the current collaboration branch.

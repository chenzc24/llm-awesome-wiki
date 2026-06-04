# Phase 4.4 Overview Index Log Maintenance Plan

## Goal

Execute Phase 4.4 for Person B by defining maintenance rules for
`wiki/overview.md`, `wiki/index.md`, and `wiki/log.md`.

This target makes wiki construction rounds leave the workspace navigable and
maintainable. It does not close all Phase 4 work.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules were inspected and remain read-only for this target:

```text
MinerU
llm_wiki
```

## Owned Files

This target may edit:

- `docs/phase-plans/phase-4-wiki-construction-engine.md`
- `docs/phase-plans/phase-4.4-overview-index-log-maintenance.md`
- `docs/phase-plans/README.md`
- `rules/wiki-overview-log-contract.md`
- `rules/wiki-index-contract.md`
- `rules/source-packet-to-wiki.md`
- `rules/distillation-rounds.md`
- `rules/README.md`
- `templates/workspace-kernel/wiki/overview.md`
- `templates/workspace-kernel/wiki/overview.template.md`
- `templates/workspace-kernel/wiki/index.md`
- `templates/workspace-kernel/wiki/log.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/AGENTS.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

This target may inspect but should not edit:

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 4.1 page routing.
- Phase 4.2 source/chapter templates and construction analysis template.
- Phase 4.3 wiki construction round protocol.
- Artifact economy: overview, index, and log must not duplicate source packets,
  claim/evidence maps, or full validation reports.

## Expected Changes

1. Add Phase 4.4 phase-plan document.
2. Update main Phase 4 plan to mark Phase 4.3 complete and Phase 4.4 active.
3. Add operational rule for overview/log maintenance and update index contract.
4. Update source-packet-to-wiki and distillation rounds to require overview,
   index, and log maintenance triggers.
5. Harden workspace overview, index, and log templates.
6. Update validation note and AGENTS guidance so copied workspaces check
   overview/index/log status.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` checks for:
  - `Phase 4.4`
  - `overview refresh`
  - `index integrity`
  - `wiki log`
  - `navigation contract`
  - `stale entries`
  - `not a final synthesis`
  - `not knowledge prose`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit after validation with:

```text
Define phase four overview index log maintenance
```

Push to `origin main` after commit.

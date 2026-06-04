# Phase 4.3 Wiki Construction Round Protocol Plan

## Goal

Execute Phase 4.3 for Person B by defining the round protocol for wiki
construction.

This target turns Phase 4.1 routing and Phase 4.2 source/chapter templates into
a repeatable round rhythm:

```text
select fixed inputs
-> read source packets and claim/evidence context
-> route pages
-> write wiki construction analysis
-> create, update, or merge pages
-> update index/log
-> record validation
```

This target continues Phase 4 but does not close all Phase 4 work.

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
- `docs/phase-plans/phase-4.3-wiki-construction-round-protocol.md`
- `docs/phase-plans/README.md`
- `rules/distillation-rounds.md`
- `rules/source-packet-to-wiki.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/AGENTS.md`
- `templates/workspace-kernel/plan/first-round-plan.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/reports/wiki-construction-analysis.template.md`
- `templates/workspace-kernel/wiki/log.md`
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
- Phase 3 claim/evidence and review queue workflow.
- Artifact economy: page generation must not duplicate source packets or
  claim/evidence maps.
- Person A/B split: Person B writes workflow and templates, Person A owns
  machine-readable contracts and validators.

## Expected Changes

1. Add a Phase 4.3 phase-plan document.
2. Update the main Phase 4 plan to mark Phase 4.2 complete and Phase 4.3
   active.
3. Update `distillation-rounds.md` so wiki construction rounds require:
   - fixed input set
   - routing decision
   - construction analysis
   - page create/update/merge decision
   - index/log update
   - validation note
4. Update `source-packet-to-wiki.md` to reference the round protocol.
5. Update workspace first-round plan and validation note templates to include
   construction analysis, merge/duplicate checks, index/log updates, and review
   carry-forward.
6. Update workspace README/AGENTS/wiki log guidance so copied workspaces follow
   the same round rhythm.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` checks for:
  - `Phase 4.3`
  - `wiki construction round`
  - `fixed input set`
  - `routing decision`
  - `construction analysis`
  - `create/update/merge`
  - `index/log`
  - `validation note`
  - `review carry-forward`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit after validation with:

```text
Define phase four wiki construction round protocol
```

Push to `origin main` after commit.

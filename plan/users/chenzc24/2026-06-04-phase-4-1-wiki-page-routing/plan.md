# Phase 4.1 Wiki Page Routing Plan

## Goal

Execute Phase 4.1 for Person B by defining the wiki page routing and default
reading surface for source/chapter-oriented wiki construction.

This target starts Phase 4 but does not complete all Phase 4 work. It focuses
on deciding what content belongs in overview, index, source pages, chapter
pages, reports, and optional synthesis/research pages before template
hardening begins.

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
- `docs/phase-plans/README.md`
- `rules/wiki-page-routing.md`
- `rules/README.md`
- `rules/source-packet-to-wiki.md`
- `rules/wiki-index-contract.md`
- `templates/workspace-kernel/wiki/index.md`
- `templates/workspace-kernel/wiki/overview.md`
- `templates/workspace-kernel/wiki/overview.template.md`
- `templates/workspace-kernel/wiki/chapters/README.md`
- `templates/workspace-kernel/wiki/sources/README.md`
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

- Phase 3 closure review and claim/evidence handoff.
- Existing `source-packet-to-wiki` rule.
- Existing `wiki-index-contract` rule.
- Workspace kernel source/chapter templates.
- Core philosophy: source/chapter default, artifact economy, and raw-wiki
  alignment.

## Expected Changes

1. Add the main Phase 4 plan with Phase 4.1 scoped as the current active
   subphase.
2. Add `rules/wiki-page-routing.md` to decide where content belongs.
3. Update `source-packet-to-wiki.md` so routing/analysis happens before page
   generation.
4. Update `wiki-index-contract.md` so overview, source pages, chapter pages,
   reports, and optional synthesis are routed consistently.
5. Update workspace wiki index/overview and source/chapter README guidance.
6. Record that Phase 4.1 does not harden full templates, implement wiki-lint,
   edit schemas, or create optional research graph pages by default.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` checks for:
  - `Wiki Page Routing`
  - `source page`
  - `chapter page`
  - `overview`
  - `index`
  - `claim/evidence`
  - `not a second source packet`
  - `optional synthesis`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit after validation with:

```text
Define phase four wiki page routing
```

Push to `origin main` after commit.

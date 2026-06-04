# Phase 4.2 Source And Chapter Template Hardening Plan

## Goal

Execute Phase 4.2 for Person B by hardening the source page, chapter page, and
wiki construction analysis templates so agents can turn routed source packet
knowledge into readable wiki pages without duplicating audit artifacts.

This target continues Phase 4 after Phase 4.1 page routing. It does not close
all Phase 4 work.

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
- `docs/phase-plans/phase-4.2-source-chapter-template-hardening.md`
- `docs/phase-plans/README.md`
- `rules/source-packet-to-wiki.md`
- `rules/wiki-page-routing.md`
- `templates/workspace-kernel/wiki/sources/source-page.template.md`
- `templates/workspace-kernel/wiki/chapters/chapter-page.template.md`
- `templates/workspace-kernel/wiki/sources/README.md`
- `templates/workspace-kernel/wiki/chapters/README.md`
- `templates/workspace-kernel/reports/wiki-construction-analysis.template.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/schema.md`
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
- Phase 3 claim/evidence and review queue rules.
- Artifact economy: wiki pages are the agent-readable layer, not source
  packets or claim/evidence maps.
- Person A/B split: Person B writes workflow and templates, Person A owns
  machine-readable contracts and validators.

## Expected Changes

1. Add a Phase 4.2 plan document.
2. Update the main Phase 4 plan to mark Phase 4.1 complete and Phase 4.2
   active.
3. Harden source page template:
   - short source/deck note
   - packet reference
   - structure summary
   - linked chapters
   - gaps/review
   - explicit anti-duplication guardrails
4. Harden chapter page template:
   - scope
   - routing/source inputs
   - source-backed distilled knowledge
   - claim/evidence support
   - practical implications
   - gaps/review
   - explicit anti-claim-table guardrails
5. Add a wiki construction analysis report template that records routing,
   inputs, target pages, merge decisions, and review handoff before page
   generation.
6. Update source-packet-to-wiki and wiki-page-routing prose to reference the
   construction analysis template.
7. Update workspace reports/schema guidance so copied workspaces know where
   construction analysis belongs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` checks for:
  - `Phase 4.2`
  - `wiki construction analysis`
  - `source page`
  - `chapter page`
  - `packet reference`
  - `claim/evidence`
  - `review handoff`
  - `not a source packet`
  - `not a claim/evidence table`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit after validation with:

```text
Harden phase four source chapter templates
```

Push to `origin main` after commit.

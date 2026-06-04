# Phase 3 Evidence And Claim Workflow Plan

## Goal

Execute and review all Person B Phase 3 workflow-surface work against the
project design philosophy.

Phase 3 consumes Phase 2 source packets and defines how packet anchors become
evidence, how evidence supports claims, how generated evidence and uncertainty
are routed to review, and how the result is handed to later wiki construction
and compare gates.

This target does not implement parsers, validators, JSON Schema changes,
fixtures, raw conversion, wiki generation, compare gate implementation, or
downstream `skill + tool` artifacts.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules were inspected and are read-only for this target:

```text
MinerU
llm_wiki
```

## Owned Files

This target may edit:

- `docs/phase-plans/phase-3-evidence-claim-workflow.md`
- `docs/phase-plans/phase-3-closure-review.md`
- `docs/phase-plans/README.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `rules/source-packet-to-evidence.md`
- `rules/evidence-to-claim.md`
- `rules/claim-review-routing.md`
- `rules/README.md`
- `rules/distillation-rounds.md`
- `rules/source-packet-to-wiki.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/reports/claim-evidence-map.template.md`
- `templates/workspace-kernel/reports/review-queue.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/plan/first-round-plan.template.md`
- `templates/workspace-kernel/wiki/chapters/chapter-page.template.md`
- `templates/workspace-kernel/AGENTS.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/schema.md`
- `tools/README.md`
- `tools/claim-audit/README.md`
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

- Phase 2 source packet protocol and closure handoff.
- Core philosophy and artifact economy design.
- Person A/B collaboration boundary.
- Existing evidence, claim, and review schema drafts as read-only reference.

## Expected Changes

1. Add the main Phase 3 phase plan.
2. Add operational rules for:
   - source packet anchors to evidence
   - evidence to claim records
   - claim review routing
3. Keep the default corpus flow source/chapter-oriented rather than fragmented
   into concept/entity object pages.
4. Add lightweight workspace report templates for claim/evidence mapping and
   review queue records.
5. Update claim-audit tool surface prose without implementing a tool.
6. Update distillation and wiki handoff rules so Phase 3 output is used as an
   audit/review layer, not as a duplicate wiki.
7. Add a Phase 3 closure review that checks the result against VSCode/Git-first,
   Agent-first, artifact economy, raw-wiki alignment, generated-content
   visibility, and non-self-evaluation principles.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- `Get-ChildItem contracts/schemas -Filter *.schema.json | ForEach-Object { Get-Content $_.FullName -Raw | ConvertFrom-Json | Out-Null }`
- Targeted `rg` checks for Phase 3 terminology:
  - `source packet to evidence`
  - `evidence to claim`
  - `generated evidence`
  - `review item`
  - `artifact economy`
  - `source/chapter`
  - `not a wiki page`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit after validation with:

```text
Define phase three evidence claim workflow
```

Push to `origin main` after commit.

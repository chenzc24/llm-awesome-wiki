# Phase 5.2 Source Wiki Coverage And Omission Plan

## Goal

Continue Phase 5 from the Person B workflow-surface side by defining how a
compare report records source/wiki coverage, anchor disposition, weak coverage,
omissions, deferrals, scope exclusions, and source-to-wiki traceability without
requiring a full compare CLI implementation.

Phase 5.2 does not implement coverage algorithms, schemas, validators,
fixtures, wiki generation, link checking tools, or downstream `skill + tool`
artifacts.

## Dirty-State Note

Start state was clean:

```text
## main...origin/main
```

Reference submodules were unchanged:

```text
ef4aa39c1dcc0102082374e977e2d722b9d392c0 MinerU (heads/master)
a5ee5ec3c7cc180f0f5abfb9d266fe87573171bd llm_wiki (v0.4.18)
```

## Owned Files

- `docs/phase-plans/phase-5-compare-gates-review-workflow.md`
- `docs/phase-plans/phase-5.2-source-wiki-coverage-omission-protocol.md`
- `docs/phase-plans/README.md`
- `rules/source-wiki-coverage-protocol.md`
- `rules/compare-gate-contract.md`
- `rules/README.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `rules/source-packet-to-wiki.md`
- `rules/distillation-rounds.md`
- `templates/workspace-kernel/wiki/**`
- `templates/workspace-kernel/reports/review-queue.template.md`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 5.1 defines the compare report as the default decision surface.
- Phase 5.2 must preserve artifact economy: do not create a default report
  sprawl when one compare report can carry the coverage decision.
- Phase 5.3 will handle claim, modality, and contradiction review in more
  depth. Phase 5.2 should only mention those areas as handoff fields when
  source/wiki coverage reveals them.

## Implementation Steps

1. Add the Phase 5.2 phase-plan document.
2. Update the main Phase 5 plan to mark Phase 5.1 complete and Phase 5.2
   active.
3. Add `rules/source-wiki-coverage-protocol.md` and index it from
   `rules/README.md`.
4. Refine `rules/compare-gate-contract.md` with coverage statuses,
   dispositions, omission rules, and scope-exclusion semantics.
5. Refine the compare report template to make source coverage and anchor
   disposition explicit enough for a 30-page PPT or document corpus.
6. Update report README and validation note guidance for coverage/omission
   decisions.
7. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 5.2`
  - `Source Wiki Coverage`
  - `anchor disposition`
  - `covered`
  - `weak`
  - `omitted`
  - `deferred`
  - `out-of-scope`
  - `scope exclusion`
  - `coverage is not copying`
  - `not report sprawl`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Define phase five source wiki coverage protocol
```

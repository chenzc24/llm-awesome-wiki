# Person A Dry-Run V2 Handoff Plan

## Goal

Create a current-system `adctoolbox-ch1-dry-run-v2` local workspace using the
same historical ADC Toolbox chapter source, and clarify that Person A should
optimize machine-checkable contracts, validators, and fixtures rather than
redesigning workflow prose.

## Dirty-State Note

The repository started clean on `main...origin/main`. `git submodule status`
was checked because this task references the broader reference-boundary context;
`llm_wiki/` and `MinerU/` remain read-only.

## Owned Files

- `workspace/local/adctoolbox-ch1-dry-run-v2/**` local ignored dry-run output
- `docs/collaboration/person-a-dry-run-v2-review-brief.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `docs/collaboration/README.md`
- `plan/users/chenzc24/2026-06-04-person-a-dry-run-v2-handoff/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `rules/**`
- `templates/workspace-kernel/**`
- `contracts/schemas/**`
- `llm_wiki_tools/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Inspect the historical dry-run and current workspace-kernel template.
2. Create a local `workspace/local/adctoolbox-ch1-dry-run-v2` that follows the
   current source/chapter-oriented structure.
3. Reuse the same available source material from the historical dry-run without
   committing binary source files.
4. Add a Person A review brief that points to the v2 dry-run and lists the
   concrete contract, fixture, and validator questions to answer.
5. Update collaboration ownership docs so Person A owns Python checker
   implementation under `llm_wiki_tools/**`, while Person B owns workflow prose
   and tool-surface specs.
6. Update personal and global maintenance logs.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools workspace-check --workspace workspace/local/adctoolbox-ch1-dry-run-v2 --mode all --report workspace/local/adctoolbox-ch1-dry-run-v2/reports/workspace-check-v2.md`
- Targeted `rg` checks for Person A ownership, dry-run v2 handoff, source/chapter
  default, and Python checker ownership.
- `git status --short --branch`

## Commit Intent

Commit only tracked collaboration and log changes. Keep
`workspace/local/adctoolbox-ch1-dry-run-v2/**` ignored as local dry-run output.
Use commit message:

```text
Clarify person A validation handoff
```

# ADCtoolbox ch2-ch4 Hardened Redistill Plan

## Goal

Create a new ignored local workspace and redistill ADCtoolbox `ch2.pdf`,
`ch3.pdf`, and `ch4.pdf` using the strengthened coverage-aware workflow.

The primary review target is `ch3.pdf`, because the previous dry run produced
structurally valid but overly shallow wiki output. This pass must record source
outline, anchor disposition, source coverage, wiki page coverage, and separate
knowledge coverage from modality review.

## Fixed Input Set

- `E:\ADCToolbox\learning\adctoolbox-learning\toolbox-wiki\raw\resources\ADCtoolbox\ADC基础\孙老师课件\ch2.pdf`
- `E:\ADCToolbox\learning\adctoolbox-learning\toolbox-wiki\raw\resources\ADCtoolbox\ADC基础\孙老师课件\ch3.pdf`
- `E:\ADCToolbox\learning\adctoolbox-learning\toolbox-wiki\raw\resources\ADCtoolbox\ADC基础\孙老师课件\ch4.pdf`

## Target Workspace

- `workspace/local/adctoolbox-ch2-ch4-hardened-redistill/`

This path is ignored and is not intended for commit.

## Dirty-State Note

Start state: tracked worktree is clean on `main...origin/main`.

Ignored `workspace/local/` already exists from earlier local workspace tests.
It is unrelated to this target. This task will create a new ignored workspace
under a new directory and will not edit the previous workspace except for
read-only comparison if needed.

## Owned Files

- `workspace/local/adctoolbox-ch2-ch4-hardened-redistill/**` ignored local
  workspace files
- `plan/users/chenzc24/2026-06-04-adctoolbox-ch2-ch4-hardened-redistill/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `skills/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `llm_wiki_tools/**`
- `contracts/**`
- `llm_wiki/**`
- `MinerU/**`
- previous ignored workspaces under `workspace/local/**`

## Expected Workspace Outputs

- copied raw PDFs under `raw/sources/ADCtoolbox/ADC-basic/`
- `raw/source-inventory.md`
- source packets under `raw/derived/adctoolbox-adc-basic-ch2/`,
  `raw/derived/adctoolbox-adc-basic-ch3/`, and
  `raw/derived/adctoolbox-adc-basic-ch4/`
- `reports/wiki-construction-analysis.md` with `distillation_depth` and source
  outline / coverage plan
- source pages and chapter pages under `wiki/`
- `reports/compare/ch2-ch4-hardened-compare-report.md` with source coverage,
  anchor disposition, wiki page coverage, claim/modality/review sections
- `reports/review/review-queue.md`
- `reports/validation/first-round-validation-note.md`
- `.checks/` validation output

## Validation

- `python -m llm_wiki_tools workspace-check --workspace workspace/local/adctoolbox-ch2-ch4-hardened-redistill --mode all --report workspace/local/adctoolbox-ch2-ch4-hardened-redistill/.checks/workspace-check-all.md`
- `git diff --check`
- `git status --short --branch`

## Commit Intent

Commit only the plan/log records. Do not commit ignored workspace contents.

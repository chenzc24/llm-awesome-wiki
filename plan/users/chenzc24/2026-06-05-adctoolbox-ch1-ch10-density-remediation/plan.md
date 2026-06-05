# ADCtoolbox Ch1-Ch10 Density Remediation

## Goal

Remediate the first ch1-ch10 workspace distillation because the accepted wiki
pages were too shallow and omitted most slide-level course information. Replace
the high-level chapter summaries with high-density, page-anchored chapter
notes that preserve substantially more of the extracted text and lesson
structure.

## Fixed Input Set

- Existing local workspace:
  `workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/`
- Existing raw source copies:
  `raw/sources/ADCtoolbox/ADC-basic/ch1.pdf` through
  `raw/sources/ADCtoolbox/ADC-basic/ch10.pdf`
- Existing source packets:
  `raw/derived/adctoolbox-adc-basic-ch1/source.md` through
  `raw/derived/adctoolbox-adc-basic-ch10/source.md`

## Expected Files

- Dense replacement chapter pages under `wiki/chapters/ch1.md` through
  `wiki/chapters/ch10.md`.
- Updated `wiki/overview.md`, `wiki/index.md`, and `wiki/log.md` documenting
  the density remediation.
- Updated `reports/wiki-construction-analysis.md`,
  `reports/compare/adctoolbox-ch1-ch10-compare-report.md`,
  `reports/review/review-queue.md`, and
  `reports/validation/first-round-validation-note.md`.
- Updated workspace log under `workspace/local/.../plan/log.md`.
- Checker reports under workspace `.checks/`.
- Maintenance log updates in the system repo.

## Owned Files

- `plan/users/chenzc24/2026-06-05-adctoolbox-ch1-ch10-density-remediation/`
- `workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/`
- `plan/log.md`
- `plan/users/chenzc24/log.md`

## Read-only Files

- `skills/**`
- `rules/**`
- `contracts/schemas/**`
- `templates/workspace-kernel/**`
- `llm_wiki/**`
- `MinerU/**`
- Existing sibling workspaces under `workspace/local/**`

## Shared-contract Dependencies

- Uses the current checker contracts without editing schemas, rules, skills, or
  checker source.

## Dirty-state Note

Initial `git status --short --branch` reported a clean worktree on
`main...origin/main`.

## Validation

- Run `python -m llm_wiki_tools workspace-check --workspace
  workspace/local/adctoolbox-adc-basic-ch1-ch10-distill --mode all --report
  workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/.checks/workspace-check-all.md`.
- Run `git diff --check`.
- Run `git status --short --branch`.

## Review State

The remediation should improve text-derived knowledge density but still close
with review because formulas, plots, circuits, and visual layout need
independent visual review.

## Commit Intent

Commit only tracked maintenance files from the system repository. The generated
workspace remains ignored local output.

# ADCtoolbox Ch1-Ch10 Workspace Distillation

## Goal

Create a new local knowledge workspace for the ADCtoolbox ADC basic course PDF
corpus and run an overview-first first distillation round for chapters ch1
through ch10.

## Fixed Input Set

- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch1.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch2.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch3.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch4.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch5.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch6.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch7.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch8.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch9.pdf`
- `C:\Users\90590\Desktop\ADCtoolbox\ADC基础\孙老师课件\ch10.pdf`

## Expected Files

- New ignored local workspace:
  `workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/`
- Workspace kernel files copied from `templates/workspace-kernel/`.
- Runtime bundle copies of `skills/`, `rules/`, and `contracts/schemas/`.
- Raw source copies under `raw/sources/ADCtoolbox/ADC-basic/`.
- Source inventory under `raw/source-inventory.md`.
- Source packets under `raw/derived/adctoolbox-adc-basic-ch*/source.md`.
- Overview, index, source pages, and chapter pages under `wiki/`.
- Construction, compare, review, validation, and checker reports under
  `reports/` and `.checks/`.
- Maintenance log updates in the workspace and root system repo.

## Owned Files

- `plan/users/chenzc24/2026-06-05-adctoolbox-ch1-ch10-workspace-distill/`
- `workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/`
- `plan/log.md`
- `plan/users/chenzc24/log.md`

## Read-only Files

- `templates/workspace-kernel/**`
- `skills/**`
- `rules/**`
- `contracts/schemas/**`
- `llm_wiki/**`
- `MinerU/**`
- Existing sibling workspaces under `workspace/local/**`

## Shared-contract Dependencies

- Uses the current source inventory, source packet, wiki page, report, review,
  and closure checker contracts without editing them.
- Uses the current `llm_wiki_tools` development tool mode from the system repo.

## Dirty-state Note

Initial `git status --short --branch` from the repository root reported a
clean worktree on `main...origin/main`.

## Validation

- Confirm all fixed input PDFs exist and are copied into the new workspace.
- Run `python -m llm_wiki_tools workspace-check --workspace
  workspace/local/adctoolbox-adc-basic-ch1-ch10-distill --mode all --report
  workspace/local/adctoolbox-adc-basic-ch1-ch10-distill/.checks/workspace-check-all.md`.
- Run `git diff --check`.
- Run `git status --short --branch`.

## Review State

The first ten-chapter round is expected to close with review, because equations,
plots, circuits, and layout-derived details need visual/human verification
before a final technical release.

## Commit Intent

Commit only tracked maintenance files from the system repository. The generated
workspace under `workspace/local/` is intentionally ignored local output.

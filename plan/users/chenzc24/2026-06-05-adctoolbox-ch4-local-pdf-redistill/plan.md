# ADCtoolbox Ch4 Local PDF Redistill

## Goal

Run a bounded local distillation pass for
`workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/sources/ADCtoolbox/ADC-basic/ch4.pdf`
using the current skill-driven, semantic-first, audit-grounded workflow.

## Dirty-State Note

`git status --short --branch` was clean at task start.

## Fixed Input Set

- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/sources/ADCtoolbox/ADC-basic/ch4.pdf`
- Existing ch4 packet and wiki artifacts may be inspected and updated.
- Existing ch2/ch3 pages and packets are read-only context for navigation and
  consistency.

## Owned Files

- `plan/users/chenzc24/2026-06-05-adctoolbox-ch4-local-pdf-redistill/plan.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/plan/2026-06-05-ch4-local-redistill/plan.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/derived/adctoolbox-adc-basic-ch4/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/sources/ch4-source.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/chapters/ch4.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/overview.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/index.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/log.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/reports/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/.checks/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `skills/**`
- `rules/**`
- `contracts/schemas/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/sources/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/derived/adctoolbox-adc-basic-ch2/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/raw/derived/adctoolbox-adc-basic-ch3/**`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/chapters/ch2.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/chapters/ch3.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/sources/ch2-source.md`
- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/wiki/sources/ch3-source.md`
- `llm_wiki/`

## Shared-Contract Dependencies

- Existing workspace schemas and `llm_wiki_tools` validators are dependencies
  only; this task will not edit them.

## Expected Outputs

- Refreshed ch4 source packet metadata and source anchors if extraction is
  improved.
- Ch4 semantic draft, source outline, grounding pass, compare report, review
  queue, validation note, and closure decision.
- Updated ch4 source/chapter wiki pages, plus navigation/log updates when
  needed.

## Validation

- Run the relevant workspace checker from the repository root, preferably:
  `python -m llm_wiki_tools workspace-check --workspace workspace/local/adctoolbox-ch2-ch4-pdf-distill-test --mode all --report workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/.checks/ch4-redistill-workspace-check-all.md`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit only tracked planning/log maintenance files if the local workspace
artifacts remain ignored. Do not stage raw PDFs or unrelated files. Push to
`origin main` only after validation if a tracked commit is created.

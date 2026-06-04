# Coverage-Aware Wiki Gate Hardening Plan

## Goal

Strengthen the source-packet-to-wiki and quality-gate workflow so document/PPT
distillation rounds cannot pass with shallow wiki prose that only cites broad
source ranges. The hardening should make source outline, anchor disposition,
knowledge coverage status, and modality review status explicit before closure.

## Dirty-State Note

Start state: tracked worktree is clean on `main...origin/main`.

Ignored local workspace `workspace/local/` exists from the ADCtoolbox ch2-ch4
distillation test. It is unrelated to tracked system files and may be used only
as optional read-only or local validation material.

Submodules `llm_wiki/` and `MinerU/` are pinned references and are not owned by
this target.

## Owned Files

- `skills/llm-wiki-wiki-round/SKILL.md`
- `skills/llm-wiki-quality-gate/SKILL.md`
- `rules/wiki/source-wiki-coverage-protocol.md`
- `templates/workspace-kernel/reports/wiki-construction-analysis.template.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `llm_wiki_tools/cli.py`
- `tests/fixtures/phase6/**` only if checker fixture expectations require
  alignment
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-coverage-aware-wiki-gate-hardening/plan.md`

## Read-Only Files

- `contracts/**`
- `rules/source/**`
- `rules/claims/**`
- `rules/review/**`
- `docs/**`
- `llm_wiki/**`
- `MinerU/**`
- `workspace/local/**` except optional ignored validation artifacts

## Expected Changes

- Make document/PPT wiki rounds produce a source outline or coverage plan before
  final wiki prose unless the round is explicitly `overview-only`.
- Require compare reports to expose anchor disposition for in-scope document/PPT
  work, separating knowledge coverage review from modality review.
- Clarify that `covered` means represented at the right detail level, not merely
  cited or summarized by a broad page range.
- Harden report templates so future workspaces have the required fields.
- Harden `report-check` enough to catch missing anchor disposition tables and
  obvious pass/coverage contradictions.

## Validation

- `git diff --check`
- `python -m py_compile llm_wiki_tools/cli.py llm_wiki_tools/__main__.py`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools fixture-runner`
- `python -m llm_wiki_tools workspace-check --mode fixtures`
- Optional local ADCtoolbox workspace recheck after adding local ignored anchor
  disposition rows if useful.
- `git status --short --branch`

## Commit Intent

Commit and push to `origin/main` with a message like:

`Harden wiki coverage gate`

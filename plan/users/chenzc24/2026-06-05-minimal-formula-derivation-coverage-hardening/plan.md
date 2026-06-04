# Minimal Formula Derivation Coverage Hardening Plan

## Goal

Make the smallest system change needed after the ADCtoolbox redistillation
showed that important formulas and derivations can still be lost while source
coverage appears to pass.

The target is not to add a new formula subsystem. The target is to clarify that
core formulas and derivations are knowledge coverage when they carry technical
meaning. If they are missing, broken, or only routed as nonblocking modality
review, the round must not claim `Knowledge coverage status: pass`.

## Dirty-State Note

Start state: tracked worktree is clean on `main...origin/main`.

Ignored `workspace/local/` exists and contains local test workspaces. This task
will not edit ignored workspace outputs.

## Owned Files

- `skills/llm-wiki-wiki-round/SKILL.md`
- `skills/llm-wiki-quality-gate/SKILL.md`
- `rules/wiki/source-wiki-coverage-protocol.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-05-minimal-formula-derivation-coverage-hardening/plan.md`

## Read-Only Files

- `llm_wiki_tools/**`
- `contracts/**`
- `tests/**`
- `rules/source/**`
- `rules/claims/**`
- `rules/review/**`
- `templates/workspace-kernel/raw/**`
- `workspace/local/**`
- `llm_wiki/**`
- `MinerU/**`

## Expected Changes

- Add a small rule note that core formulas and derivations are not merely
  modality review when they support the accepted wiki knowledge.
- Update wiki-round guidance to require naming formula/derivation-bearing source
  units in the coverage plan.
- Update quality-gate guidance so missing core formulas/derivations affect
  knowledge coverage status.
- Update existing compare and validation templates with a few formula/derivation
  checklist fields, without adding a new table or checker requirement.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools fixture-runner`
- `git status --short --branch`

## Commit Intent

Commit and push the minimal documentation hardening to `origin/main`.

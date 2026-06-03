# Align Distillation Rounds With Overview-First Flow Plan

## Goal

Update `rules/distillation-rounds.md` so it reflects the core philosophy:
before small distillation rounds begin, the workspace should broadly read the
source set, create an overview, build a skeleton index/project structure, and
write a staged distillation plan.

## Expected Files

- Update `rules/distillation-rounds.md`.
- Update `plan/log.md`.
- Add this target plan.

## Validation

- Run `git diff --check`.
- Run targeted `rg` checks for overview-first, skeleton index, staged
  distillation plan, and compare-gate language.
- Run `git status --short --branch`.

## Commit Intent

Commit message: `Align distillation rounds with overview first flow`

Push target: `origin/main`

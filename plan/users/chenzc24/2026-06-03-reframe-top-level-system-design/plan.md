# Reframe Top-Level System Design

## Goal

Reframe the top-level design docs so they describe the construction of the new
LLM Awesome Wiki system, not a plan to use `llm_wiki` to generate a knowledge
base. Convert the design area to English.

## Expected Files

- `docs/top-level-design/README.md`
- delete `docs/top-level-design/phased-distillation-design.md`
- `docs/top-level-design/system-architecture-plan.md`
- `plan/log.md`
- this plan file

No edits are expected inside `llm_wiki/`; it remains a pinned reference
submodule.

## Validation Steps

- Confirm the top-level design docs are English-only.
- Confirm the docs frame `llm_wiki` as a reference/benchmark, not the system
  foundation.
- Confirm the raw-resource conversion discussion is scoped as one subsystem in
  the new LLM Awesome Wiki architecture.
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Stage only the reframed top-level design docs, this plan, and the maintenance
log update. Commit with a clear documentation message and push `main` to
`origin/main`.

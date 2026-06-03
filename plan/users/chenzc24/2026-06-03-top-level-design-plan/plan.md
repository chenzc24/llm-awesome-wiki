# Top-Level Design Plan Folder

## Goal

Add a designer-maintained top-level design plan area under `docs/` and capture
the staged workflow for raw resource conversion, multimodal document handling,
LLM responsibility boundaries, Markdown conversion rules, and `llm_wiki`
reference points.

## Expected Files

- `docs/top-level-design/README.md`
- `docs/top-level-design/phased-distillation-design.md`
- `plan/log.md`
- this plan file

No edits are expected inside `llm_wiki/`; it remains a pinned reference
submodule.

## Validation Steps

- Review the new design docs for consistency with existing docs:
  - `docs/core-philosophy.md`
  - `docs/execution-roadmap.md`
  - `docs/knowledge-to-executable.md`
  - `docs/llm_wiki-reference.md`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Stage only the new top-level design docs, this plan, and the maintenance log
update. Commit with a clear documentation message and push `main` to
`origin/main` after validation.

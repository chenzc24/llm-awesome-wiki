# Correct Default Document Corpus Profile Plan

## Goal

Make a minimal correction to the system direction: the default workspace kernel
should optimize for document/PPT corpus distillation with source and chapter
structure preserved. Research-style pages such as concepts, entities,
comparisons, synthesis, and queries should be optional extensions, not the
default minimum structure.

## Expected Files

- Update `README.md`.
- Update top-level and philosophy docs under `docs/`.
- Update `rules/wiki-index-contract.md` and related workflow wording.
- Update `templates/workspace-kernel/` default wiki schema and index.
- Remove research-style optional wiki subdirectories from the default template.
- Add a default `wiki/chapters/README.md`.
- Update `tools/validate-kernel/validate-kernel.ps1`.
- Update `plan/log.md`.

## Validation

- Run `git diff --check`.
- Run `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`.
- Confirm default template uses document-corpus terms: sources/decks, chapters,
  overview, reports/review.
- Confirm research-style concepts/entities/comparisons/queries are not required
  by the validator or default index.
- Confirm root-level active workspace paths remain absent.
- Confirm `llm_wiki/` has no content changes.

## Commit Intent

Commit message: `Make document corpus the default workspace profile`

Push target: `origin/main`

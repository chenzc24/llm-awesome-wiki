# ADCtoolbox Ch1 PDF Dry Run

## Goal

Add explicit repository ignore settings for local workspace dry runs, create an
ignored local workspace from the workspace kernel, copy `ch1.pdf` into it, and
try a first manual distillation pass for the PDF.

## Expected Files

Tracked files:

- `.gitignore`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-adctoolbox-ch1-pdf-dry-run/plan.md`

Ignored local workspace files:

- `workspace/local/adctoolbox-ch1-dry-run/**`

## Owned Files

- `.gitignore`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-adctoolbox-ch1-pdf-dry-run/**`
- `workspace/local/adctoolbox-ch1-dry-run/**`

## Read-only Files

- `templates/workspace-kernel/**`
- `rules/**`
- `docs/**`
- `contracts/**`
- `llm_wiki/**`
- existing tracked `workspace/human-agent-rule-divergence.md`

## Shared Contract Dependencies

None. This dry run uses the existing Phase 1.3 golden-path templates.

## Implementation Steps

1. Add `.gitignore` rules for `workspace/local/`.
2. Copy `templates/workspace-kernel/` into
   `workspace/local/adctoolbox-ch1-dry-run/`.
3. Copy the source PDF into the ignored workspace under `raw/sources/`.
4. Extract basic PDF text/page metadata for manual source-packet writing.
5. Fill first-round workspace files: purpose, plan, inventory, source packet,
   overview, source page, chapter page, validation note, and logs.
6. Keep the dry-run workspace ignored and commit only repository maintenance
   files.

## Validation

- Run `git check-ignore -v workspace/local/adctoolbox-ch1-dry-run/raw/sources/ch1.pdf`.
- Run `git diff --check`.
- Run `git status --short --branch --untracked-files=all`.
- Confirm `llm_wiki/` has no content changes.

## Commit Intent

Commit tracked maintenance changes with message
`Add ignored workspace dry run area` and push `main` to `origin/main`.

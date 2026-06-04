# Rules Slimming Pass Plan

## Goal

Deduplicate and slim the largest `rules/` owner documents while preserving the
normal distillation workflow and safety guarantees.

The target is to reduce repeated explanations across rules, not to remove
required behavior. Compatibility stubs and existing paths should remain.

## Dirty-State Note

Start state: `git status --short --branch` reported `main...origin/main` with
unrelated dirty work already present:

- modified top-level and collaboration/design docs
- modified `llm_wiki_tools/cli.py`
- deleted legacy `tools/**/README.md` files
- new `llm_wiki_tools/README.md`
- new plan under
  `plan/users/chenzc24/2026-06-04-collapse-tools-docs-into-python-package/`

These paths belong to a separate tools-documentation collapse target. This
rules slimming pass will not edit or stage them. Because the dirty
`llm_wiki_tools/cli.py` affects kernel validation, validation results will be
reported as run against the current dirty tooling state.

## Owned Files

- `rules/raw-to-source-packet.md`
- `rules/distillation-rounds.md`
- `rules/source-packet-to-wiki.md`
- `rules/wiki-surface-workflow.md`
- `rules/evidence-claim-workflow.md`
- `rules/compare-gate-contract.md`
- `plan/users/chenzc24/2026-06-04-rules-slimming-pass/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `llm_wiki_tools/**`
- `tools/**`
- `docs/**`
- `templates/**`
- `contracts/schemas/**`
- `skills/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Add concise minimum-path sections to large owner rules where useful.
2. Remove repeated stage, closure, page-surface, and review explanations when
   another owner file already defines them.
3. Keep required field lists, status meanings, acceptance criteria, and
   forbidden shortcuts.
4. Do not move files, delete compatibility entries, or change schema/tool
   behavior.
5. Update logs and commit only this target's files.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` for required flow terms:
  - `source inventory`
  - `<source_id>#<anchor_id>`
  - `wiki construction analysis`
  - `compare gate not enabled`
  - `close-pass`
  - `needs-review`
  - `review item`
- compare rules size before/after with PowerShell line/word counts.
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Slim duplicate rules prose
```

Push to `origin main` only with the intended rules/log/plan files staged.

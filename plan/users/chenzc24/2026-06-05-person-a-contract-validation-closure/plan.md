# Person A Contract And Validation Closure Plan

## Goal

Complete the current Person A workstream for contracts, validators, and
fixtures according to the project design philosophy:

- keep contracts small and checkable
- avoid duplicate truth sources
- validate artifacts instead of building extractor harnesses or wiki generators
- prove the workflow with representative fixtures
- leave a clear closure review for the next phase

This target closes the current pre-Phase-7 Person A surface. It does not start
downstream knowledge-to-skill/tool generation.

## Dirty-State Note

Start state from `git status --short --branch`:

```text
## main...origin/main
```

The worktree is clean. The current branch is `main`.

## Owned Files

- `contracts/schemas/**`
- `llm_wiki_tools/**`
- `tests/fixtures/**`
- `tests/README.md`
- `docs/collaboration/person-a-implementation-closure-review.md`
- `docs/collaboration/README.md`
- `plan/users/chenzc24/2026-06-05-person-a-contract-validation-closure/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `rules/**`
- `skills/**`
- `templates/workspace-kernel/**`
- `docs/phase-plans/**`
- `docs/top-level-design/**`
- `llm_wiki/**`
- `MinerU/**`

These files may be inspected for terminology and requirements, but this target
will not edit them unless a mismatch blocks Person A closure.

## Expected Work

1. Audit current schemas, CLI checkers, and fixtures against Person A handoff.
2. Keep the schema layer minimal; do not add a new schema family unless a
   validator needs a stable field vocabulary.
3. Harden `source-packet-lint` only where the existing rules expose
   deterministic checks for PDF/PPTX packet profiles.
4. Harden wiki/report/closure checks only where representative fixtures expose
   missing deterministic validation.
5. Add small fixtures that prove:
   - valid PPTX packet output can pass source validation
   - invalid PPTX output without slide anchors fails
   - generated visual interpretation without generated-field marking fails
   - valid PDF packet output with gaps and review routing passes
   - wiki construction closure requires analysis/index/log/validation evidence
6. Add a Person A closure review summarizing completed contracts, validators,
   fixture evidence, remaining risks, and Phase 7 boundary.

## Validation Steps

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools schema-check --workspace . --report person-a-schema-check-smoke.md`
- `python -m llm_wiki_tools fixture-runner --fixture-root tests/fixtures/phase6 --report person-a-fixture-runner-smoke.md`
- `python -m llm_wiki_tools workspace-check --workspace . --mode fixtures --report person-a-workspace-fixtures-smoke.md`
- targeted `rg` for Person A closure, source packet profiles, wiki construction
  fixtures, no-harness boundary, and validator evidence
- remove generated smoke reports and Python cache directories
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Complete Person A contract validation closure
```

Then push `origin main` and confirm local `main` aligns with `origin/main`.

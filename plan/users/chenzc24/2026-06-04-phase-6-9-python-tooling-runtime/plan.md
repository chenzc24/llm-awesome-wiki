# Phase 6.9 Python Tooling Runtime Plan

## Goal

Refactor the Phase 6 checker tooling from PowerShell scripts to a Python CLI
runtime.

This target does not preserve `.ps1` compatibility wrappers. The new supported
entrypoint is:

```text
python -m llm_wiki_tools <command>
```

The migration should keep the Phase 6 architecture unchanged: tools validate
existing workspace artifacts and fixture scenarios. They do not run extractors,
parse raw binary documents, generate source packets, generate wiki pages,
resolve semantic review, or start downstream `skill + tool` generation.

## Dirty-State Note

Start state was clean:

- `git status --short --branch`: `## main...origin/main`
- `git submodule status`: reference submodules present and unchanged.

## Owned Files

- `pyproject.toml`
- `llm_wiki_tools/**`
- `tools/**/*.ps1`
- `tools/**/README.md`
- `tools/README.md`
- `docs/phase-plans/phase-6-closure-review.md`
- `docs/phase-plans/phase-6.9-python-tooling-runtime.md`
- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/README.md`
- `tests/README.md`
- `tests/fixtures/README.md`
- `plan/users/chenzc24/2026-06-04-phase-6-9-python-tooling-runtime/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**` unless a Python checker exposes a contract mismatch
- `rules/**`
- `templates/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 6 report conventions
- Existing Phase 6 checker behavior
- Existing Phase 6 fixture scenarios
- Kernel invariant that the system repo must not contain live root-level
  `raw/`, `wiki/`, `reports/`, `schema.md`, or `schemas/`

## Implementation Steps

1. Add a Python package with shared report helpers and CLI dispatch.
2. Port the existing implemented Phase 6 tools:
   - `validate-kernel`
   - `schema-check`
   - `source-inventory-check`
   - `source-packet-lint`
   - `wiki-lint`
   - `report-check`
   - `round-closure-check`
   - `fixture-runner`
   - `workspace-check`
3. Delete the corresponding `.ps1` scripts.
4. Update READMEs, phase docs, and tests docs to use Python commands.
5. Update validation and logs.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools schema-check --workspace . --report phase6-schema-check-smoke.md`
- `python -m llm_wiki_tools fixture-runner --fixture-root tests/fixtures/phase6 --report phase6-fixture-runner-smoke.md`
- `python -m llm_wiki_tools workspace-check --workspace . --mode fixtures --report phase6-workspace-fixtures-smoke.md`
- Remove generated smoke reports.
- `rg -n "\.ps1|powershell -ExecutionPolicy" tools docs/phase-plans tests plan`
  should only find historical log or migration-plan references, not active
  command docs.
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Migrate phase six tooling to Python CLI
```

Then update log commit status and commit the maintenance follow-up.

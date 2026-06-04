# Phase 6.3 Source Artifact Checkers Plan

## Goal

Implement Phase 6.3 as the first workspace-artifact validators:

- source inventory check
- source packet lint
- `workspace-check -Mode source` orchestration

This target validates source inventory rows and source packet outputs. It does
not scan raw content into packets, run extractors, parse PDFs/PPTs, generate
wiki pages, or change machine schemas.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules are not part of this target.

## Owned Files

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.3-source-artifact-checkers.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/source-inventory/README.md`
- `tools/source-inventory/source-inventory-check.ps1`
- `tools/source-packet-lint/README.md`
- `tools/source-packet-lint/source-packet-lint.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-phase-6-3-source-artifact-checkers/plan.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 6.2 `schema-check` exit-code/report conventions
- `tools/shared/report-conventions.md`
- Phase 2 source inventory and source packet protocols
- Workspace template inventory and packet examples

## Implementation Steps

1. Add Phase 6.3 phase-plan documentation.
2. Implement `tools/source-inventory/source-inventory-check.ps1`:
   - parse Markdown table inventory rows
   - validate required columns
   - reject duplicate `source_id`
   - validate `raw_path` stays under `raw/sources/`
   - check local raw file existence and SHA-256 when hash looks real
   - validate status/review/packet-path consistency
   - emit deterministic report and exit codes
3. Implement `tools/source-packet-lint/source-packet-lint.ps1`:
   - scan packets from inventory or a specified packet directory
   - read `metadata.json`, `metadata.yml`, or `source.md` frontmatter
   - validate required metadata fields and status values
   - validate `source.md` exists
   - parse anchor rows from the packet anchor table
   - check failed/partial/manual-review packets expose gaps and review routing
   - check derived artifact paths stay workspace-relative and exist when local
   - emit deterministic report and exit codes
4. Integrate both scripts into `workspace-check -Mode source` and `-Mode all`.
5. Update tool READMEs and Phase 6 docs.
6. Update `validate-kernel.ps1` required paths.
7. Update maintenance logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- Create a temporary smoke workspace under the OS temp directory with:
  - one raw source file
  - one `raw/source-inventory.md`
  - one processed packet under `raw/derived/<source-id>/source.md`
  - one anchor table
- Run `source-inventory-check.ps1`, `source-packet-lint.ps1`, and
  `workspace-check.ps1 -Mode source` against that temp workspace.
- Remove or ignore generated smoke reports outside the repository.
- Targeted `rg` for Phase 6.3, source-inventory-check, source-packet-lint,
  no-extractor, and report language.
- `git status --short --branch`

## Commit Intent

- Commit main implementation as `Add phase six source artifact checkers`.
- Then update log entries with the implementation commit hash and commit that
  maintenance status.

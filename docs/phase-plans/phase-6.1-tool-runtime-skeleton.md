# Phase 6.1 Tool Runtime Skeleton

Phase 6.1 adds the first checker runtime skeleton for Phase 6.

The goal is not to implement every validator. The goal is to establish the
shared CLI shape, report conventions, exit-code semantics, and workspace
orchestration surface that later Phase 6 validators can plug into.

## Scope

Phase 6.1 owns:

- checker CLI entrypoint shape
- shared report sections
- shared exit-code convention
- workspace path handling
- stable smoke-test behavior
- explicit not-implemented status for future business validators

Phase 6.1 does not own:

- schema validation implementation
- source inventory validation implementation
- source packet validation implementation
- wiki lint implementation
- compare report validation implementation
- review queue validation implementation
- round closure validation implementation
- scenario fixture runner implementation
- raw document parsing
- extractor orchestration
- downstream knowledge-to-`skill + tool` generation

## Runtime Decision

Add `python -m llm_wiki_tools workspace-check` as the first Phase 6 runtime
entrypoint.

The entrypoint should:

- run from the system repository or a copied workspace context
- accept a workspace path
- accept a mode
- accept a report path
- write a Markdown report
- use shared exit codes
- fail visibly when the workspace path is invalid
- mark future validators as `not-implemented`

The runtime should not hide missing validators behind `pass`. A smoke run may
pass only for the runtime skeleton itself.

## Shared Exit Codes

Phase 6 checker tools should use:

| exit_code | meaning |
| --- | --- |
| `0` | requested checks passed or the skeleton smoke run completed |
| `1` | deterministic validation failure |
| `2` | review required without deterministic failure |
| `3` | configuration or runtime error |

These codes apply to checker execution, not extractor execution.

## Report Convention

Phase 6 checker reports should include:

- tool name
- tool version or phase marker
- workspace path
- mode
- started timestamp
- status
- exit code
- checks run
- checks not implemented
- findings
- next actions

Reports should be stable enough to commit when useful. They should not copy raw
source content or rewrite semantic wiki knowledge.

## Smoke Run

The Phase 6.1 smoke run should prove:

- the command can be invoked from the Python CLI
- an existing workspace path returns exit code `0`
- a missing workspace path returns exit code `3`
- the generated report lists the future validators as not implemented
- the script does not create root `raw/`, `wiki/`, or `reports/` workspace
  output in the system repo

## Completion Criteria

Phase 6.1 is complete when:

- the Phase 6.1 phase plan exists
- shared report and exit-code conventions exist
- `workspace-check command` exists and is runnable
- `workspace-check` README defines inputs, outputs, modes, non-goals, and
  future validator slots
- smoke run succeeds against the system repository path without leaving
  committed workspace output
- Phase 6.2 is identified as schema and structured-field validation

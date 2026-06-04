# Tests

This directory will contain validation for contracts, templates, and
construction tools.

Phase 1 only establishes the test strategy. Future tests should be
scenario-driven: each scenario defines a small workspace state, simulated agent
or LLM output when needed, and expected files or reports.

## Scenario Families

- source inventory scenarios
- raw-to-source-packet scenarios
- source-packet-to-wiki scenarios
- wiki lint scenarios
- compare gate scenarios
- claim audit scenarios
- review queue scenarios

## Scenario Shape

Each scenario should be small enough to inspect by hand and should define:

- `name`: stable scenario name
- `description`: behavior under test
- `initial_workspace`: files that exist before the action
- `input`: source file, source packet, wiki page, report, or command input
- `simulated_output`: optional agent or LLM output
- `expected`: files, reports, review items, or validation failures

Scenarios should assert repository artifacts, not the quality of a chat answer.

## Principles

- Prefer deterministic assertions over model self-evaluation.
- Keep fixture workspaces small and readable.
- Include both clean and failing cases.
- Assert files and reports, not only chat responses.
- Do not require Obsidian, a desktop app, MCP, or a background service.

## Current Validation

Run the Phase 1 workspace-kernel validator from the repository root:

```bash
python -m llm_wiki_tools validate-kernel
```

Phase 6.7 adds scenario fixture validation:

```bash
python -m llm_wiki_tools fixture-runner \
  --fixture-root tests/fixtures/phase6 \
  --report fixture-runner-report.md
```

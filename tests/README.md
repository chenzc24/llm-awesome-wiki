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

## Principles

- Prefer deterministic assertions over model self-evaluation.
- Keep fixture workspaces small and readable.
- Include both clean and failing cases.
- Assert files and reports, not only chat responses.
- Do not require Obsidian, a desktop app, MCP, or a background service.

## Current Validation

Run the Phase 1 workspace-kernel validator from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1
```

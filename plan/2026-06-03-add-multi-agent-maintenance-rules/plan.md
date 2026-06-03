# Add Multi-Agent Maintenance Rules

## Goal

Update repository and workspace maintenance rules for safe multi-agent or
co-worker parallel work before downstream skill/tool development begins.

## Expected Files

- `AGENTS.md`
- `rules/maintenance-workflow.md`
- `plan/README.md`
- `plan/log.md`
- this plan file

No edits are expected inside `llm_wiki/`; it remains a read-only pinned
reference submodule unless explicitly requested otherwise.

## Owned Files

- `AGENTS.md`
- `rules/maintenance-workflow.md`
- `plan/README.md`
- `plan/log.md`
- `plan/2026-06-03-add-multi-agent-maintenance-rules/plan.md`

## Read-Only Files

- `llm_wiki/`
- `contracts/schemas/`
- `docs/top-level-design/`

## Implementation Steps

1. Add root multi-agent coordination rules to `AGENTS.md`.
2. Add workspace-level co-worker coordination rules to
   `rules/maintenance-workflow.md`.
3. Update `plan/README.md` so target plans declare owned and read-only files.
4. Update `plan/log.md` with the maintenance record.

## Validation Steps

- Run `rg` checks for:
  - `Owned files`
  - `Read-only files`
  - `Coordinator`
  - `contracts/schemas`
  - `git diff --check`
  - `llm_wiki/`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Add multi-agent maintenance rules` and push `main` to
`origin/main` after validation.

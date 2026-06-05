# Workspace Contracts

Copy or pin machine contracts from the system repository here.

The workspace-local `schema.md` is the human and agent-facing guide. Files under
`contracts/` are for deterministic validation and construction tooling.

Default expected layout:

```text
contracts/schemas/
```

For copy-first workspaces, copy `contracts/schemas/` from the system repo into
this directory. If the workspace only references system repo schemas, record the
system repo path and commit in `schema.md`.

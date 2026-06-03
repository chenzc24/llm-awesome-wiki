# Workspace Kernel Template

Copy this directory into a new knowledge workspace repository to start a
VSCode-native LLM Wiki workflow.

After copying, the new repository owns its own `raw/`, `wiki/`, `reports/`,
`tools/`, `contracts/`, `purpose.md`, `schema.md`, and `AGENTS.md`. Daily work
should happen inside that workspace repository, not inside the system repo.

## First Steps In A New Workspace

1. Edit `purpose.md`.
2. Edit `schema.md` for the domain.
3. Create a target plan under `plan/`.
4. Place source files under `raw/sources/`.
5. Create source inventory and source packets under `raw/derived/`.
6. Distill source packets into `wiki/`.
7. Write compare, lint, coverage, or review reports under `reports/`.
8. Update `wiki/log.md` and `plan/log.md`.
9. Commit every accepted round.

## Minimum Round Flow

```text
configure purpose/schema
-> add raw source
-> identify source
-> create source packet
-> analyze packet against wiki/index.md
-> generate wiki updates
-> run or record lint/compare checks
-> update logs
-> commit
```

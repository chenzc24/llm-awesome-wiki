# Workspace Kernel Template

Copy this directory into a new knowledge workspace repository to start a
VSCode-native LLM Wiki workflow.

After copying, the new repository owns its own `raw/`, `wiki/`, `reports/`,
`tools/`, `contracts/`, `purpose.md`, `schema.md`, and `AGENTS.md`. Daily work
should happen inside that workspace repository, not inside the system repo.

## First Steps In A New Workspace

1. Edit `purpose.md`.
2. Edit `schema.md` for the domain.
3. Place source files under `raw/sources/`.
4. Convert raw sources into source packets under `raw/derived/`.
5. Distill source packets into `wiki/`.
6. Write reports under `reports/`.
7. Commit every accepted round.

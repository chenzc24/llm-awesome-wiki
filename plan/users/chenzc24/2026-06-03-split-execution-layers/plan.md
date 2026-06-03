# Split Execution Layers

## Goal

Clarify that this project has two different execution layers:

1. A knowledge-construction executable layer for maintenance, lint, search,
   compare gates, source inventory, and claim audit. This belongs inside the
   knowledge-base construction stage.
2. A downstream knowledge-to-code layer where a stable distilled wiki can later
   produce or maintain domain `skill + tool` codebases.

The first layer should not be described as part of the later
knowledge-base-to-skill/tool mainline.

## Expected Files

- `docs/core-philosophy.md`
- `docs/knowledge-to-executable.md`
- `docs/execution-roadmap.md`
- `docs/llm_wiki-reference.md`
- `tools/README.md`
- `plan/log.md`

## Implementation Steps

1. Rewrite the core philosophy execution point as two layers.
2. Update `knowledge-to-executable.md` to distinguish construction tools from
   downstream skill/tool artifacts.
3. Update the roadmap so maintenance and compare tools live in the construction
   phases, while downstream knowledge-to-code remains a later mainline.
4. Adjust the `llm_wiki` reference boundary to preserve this distinction.
5. Update `tools/README.md` to state that its first tools support knowledge
   construction and compare gates.
6. Record validation in `plan/log.md`.

## Validation

- Run `git diff --check`.
- Search for "construction executable layer", "downstream knowledge-to-code",
  and "skill + tool".
- Run `git status --short --branch` before commit.

## Commit

Intended commit message:

```text
Split construction and downstream execution layers
```

# Workspace Kernel Manifest

`templates/workspace-kernel/` is the workspace skeleton. A complete knowledge
workspace kernel bundle also needs runtime guidance, detailed reference rules,
machine contracts, and checker access from the system repo.

## Skeleton Files

Copy this directory into a new knowledge workspace repo:

```text
AGENTS.md
README.md
purpose.md
schema.md
plan/
raw/
wiki/
reports/
contracts/
tools/
```

These files create the workspace artifact layout. They do not duplicate the
full system runtime.

## Required Runtime Assets

For a complete workspace kernel bundle, also copy or synchronize:

```text
skills/              from system repo skills/
rules/               from system repo rules/
contracts/schemas/   from system repo contracts/schemas/
```

The runtime entrypoint is:

```text
skills/llm-wiki-distill/SKILL.md
```

`rules/README.md` is a detailed reference index, not the default runtime
entrypoint.

## Checker Access

Choose one tool mode:

| Mode | How It Works | Status |
| --- | --- | --- |
| Development tool mode | run `python -m llm_wiki_tools ...` from the system repo with `--workspace <workspace-path>` | current development default |
| Portable tool mode | install or vendor the checker package so the workspace can run `python -m llm_wiki_tools ...` locally | long-term portable target |

The workspace should record which tool mode it uses in `schema.md` or a local
tooling note.

## Boundary Rule

Do not mix system repo asset edits with live knowledge workspace artifact edits
in one commit.

If a workspace round exposes a missing rule, template, schema, or checker
behavior, record the workspace result first, then open a separate system repo
task.

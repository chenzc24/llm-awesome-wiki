# Workspace Topology Contract

This contract defines how the LLM Awesome Wiki system repository relates to a
real distilled knowledge workspace.

It exists to prevent one recurring mistake: treating the system repo, the
workspace skeleton, and an active knowledge workspace as the same project.

## Four Forms

LLM Awesome Wiki has four distinct forms.

| Form | Owner | Purpose | Contains Live Knowledge? |
| --- | --- | --- | --- |
| System repo | this repository | develops reusable skills, rules, templates, schemas, tools, tests, and design records | no |
| Workspace skeleton | `templates/workspace-kernel/` | gives a new workspace its initial file and artifact layout | no |
| Workspace kernel bundle | released/copied material assembled from the system repo | gives a workspace local runtime guidance, references, schemas, and tool access | no, until instantiated |
| Knowledge workspace repo | independent user repository | stores and maintains one real distilled corpus | yes |

The workspace skeleton is not the complete kernel by itself. It is only the
artifact layout portion of the kernel.

## System Repo

The system repo owns reusable assets:

```text
AGENTS.md
README.md
docs/
skills/
rules/
contracts/schemas/
templates/workspace-kernel/
llm_wiki_tools/
tests/
```

It must not contain live root-level workspace outputs:

```text
raw/
wiki/
reports/
schema.md
```

Allowed exceptions are examples, tests, fixtures, and ignored local scratch
workspaces.

System repo commits should change reusable workflow assets, not a specific
corpus's distilled knowledge.

## Workspace Skeleton

`templates/workspace-kernel/` is the copyable workspace skeleton. It supplies
the default directories and starter files for a knowledge workspace:

```text
AGENTS.md
purpose.md
schema.md
plan/
raw/
wiki/
reports/
contracts/
tools/
```

The skeleton is intentionally small. It does not duplicate the system repo's
full `skills/`, `rules/`, `contracts/schemas/`, or Python package source. Those
belong to the complete kernel bundle.

## Workspace Kernel Bundle

A complete workspace kernel bundle is:

```text
workspace skeleton
+ skills/
+ rules/
+ contracts/schemas/
+ checker tool access
```

The default runtime entrypoint is:

```text
skills/llm-wiki-distill/SKILL.md
```

The detailed rule index is:

```text
rules/README.md
```

The machine-readable contract source is:

```text
contracts/schemas/
```

Checker access has two supported modes:

| Mode | Meaning | Use |
| --- | --- | --- |
| Development tool mode | run `python -m llm_wiki_tools ...` from the system repo against `--workspace <path>` | current system development and local experiments |
| Portable tool mode | install or vendor the checker package so the workspace can run checks locally | long-term distributable workspace use |

Development tool mode is acceptable while the system is being built. Portable
tool mode is the direction for fully transferable workspaces.

## Knowledge Workspace Repo

A knowledge workspace repo is an independent Git repository created from a
kernel bundle. It owns the live corpus:

```text
raw/sources/
raw/derived/
wiki/
reports/
plan/
purpose.md
schema.md
```

The workspace may also contain vendored or synchronized runtime assets:

```text
skills/
rules/
contracts/schemas/
tools/
```

The workspace's job is to maintain one corpus through bounded distillation
rounds:

```text
raw sources
-> source packets
-> wiki construction analysis
-> source/chapter wiki pages
-> reports and review queues
-> validation and closure
-> workspace commit
```

Do not mix system repo edits with knowledge workspace artifact edits in one
commit. If a distillation round exposes a system rule or tool bug, record that
as a separate system repo task.

## Copy And Sync Policy

Current copy-first setup:

1. Create a new knowledge workspace Git repository.
2. Copy the contents of `templates/workspace-kernel/` into it.
3. Copy or synchronize system `skills/` into workspace `skills/`.
4. Copy or synchronize system `rules/` into workspace `rules/`.
5. Copy or pin `contracts/schemas/` into workspace `contracts/schemas/`.
6. Choose checker access:
   - development tool mode: run the system repo's `llm_wiki_tools` against the
     workspace path
   - portable tool mode: install or vendor the checker package in the workspace
7. Start from workspace `skills/llm-wiki-distill/SKILL.md`.

Future scaffold tooling may automate these steps. It must preserve the same
topology: the workspace remains an independent repo, and live `raw/`, `wiki/`,
and `reports/` belong to that workspace.

## Boundary Checks

Before a task starts, identify the active repository:

| Question | System Repo Answer | Knowledge Workspace Answer |
| --- | --- | --- |
| Am I editing reusable workflow assets? | yes | no, unless vendored runtime assets are being synced |
| Am I editing `raw/`, `wiki/`, or `reports/` for a real corpus? | no | yes |
| Should I run `validate-kernel`? | yes | only if checking system-style kernel files |
| Should I run `workspace-check`? | only against an example/fixture/local workspace path | yes |
| Should I commit distilled knowledge here? | no | yes |

If the answer is unclear, stop and classify the task before editing.

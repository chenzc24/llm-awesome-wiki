# Workspace Tools

Workspace-local tools belong here after the workspace skeleton and kernel
bundle assets are copied or synchronized into a knowledge workspace repository.

The current checker layer supports two topology modes:

- development tool mode: run the system repo's `llm_wiki_tools` against this
  workspace with `--workspace <workspace-path>`
- portable tool mode: install or vendor the checker package so this workspace
  can run checks locally

Initial tool families:

- source inventory
- source packet validation
- wiki lint
- compare gate
- claim audit
- review queue export

Tools should write explicit reports and avoid silent semantic rewrites.

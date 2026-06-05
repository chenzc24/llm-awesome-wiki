# Workspace Topology Contract Plan

## Goal

Clarify the project-structure relationship between this system repository, the
copyable workspace skeleton, a complete workspace kernel bundle, and an actual
knowledge workspace repository.

The immediate problem is that the repository already defines distillation
rules, skills, templates, schemas, and tools, but it does not state clearly how
those system assets enter a real knowledge workspace. This creates ambiguity
about whether `templates/workspace-kernel/` alone is the kernel, whether rules
and skills are copied, and where tools/contracts are expected to live.

## Start State

`git status --short --branch` reported `main...origin/main` with a clean
worktree.

`git submodule status` was checked. No submodule pointer changes are intended.

## Owned Files

- `docs/top-level-design/workspace-topology-contract.md`
- `docs/top-level-design/README.md`
- `docs/top-level-design/system-architecture-plan.md`
- `README.md`
- `AGENTS.md`
- `templates/README.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/AGENTS.md`
- `templates/workspace-kernel/schema.md`
- `templates/workspace-kernel/KERNEL-MANIFEST.md`
- `skills/llm-wiki-distill/SKILL.md`
- `llm_wiki_tools/README.md`
- `llm_wiki_tools/cli.py`
- `plan/users/chenzc24/2026-06-05-workspace-topology-contract/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- other `skills/**` subskills unless a direct link is required
- `docs/phase-plans/**`
- `docs/collaboration/**`
- `tests/**`
- `workspace/**`
- `llm_wiki/**`
- `MinerU/**`

## Decisions To Encode

1. The system repo is the development and release source of reusable workflow
   assets. It is not an active knowledge workspace.
2. `templates/workspace-kernel/` is the copyable workspace skeleton, not the
   complete runtime bundle by itself.
3. A complete workspace kernel bundle is:
   - workspace skeleton from `templates/workspace-kernel/`
   - vendored or synchronized `skills/`
   - vendored or synchronized `rules/`
   - copied or pinned `contracts/schemas/`
   - checker tool access through either development-mode system repo execution
     or packaged/vendored tool installation
4. A knowledge workspace repo owns `raw/`, `wiki/`, `reports/`, `plan/`, and
   workspace-local commits. System repo edits and knowledge distillation
   artifact edits should not be mixed in one commit.
5. Development mode may run tools from the system repo, but the long-term
   portable mode should be workspace-local/package-based.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- targeted `rg` for:
  - `workspace skeleton`
  - `kernel bundle`
  - `knowledge workspace repo`
  - `development tool mode`
  - `portable tool mode`
  - `Do not mix system repo edits`
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Define workspace topology contract
```

Push to `origin main` after validation.

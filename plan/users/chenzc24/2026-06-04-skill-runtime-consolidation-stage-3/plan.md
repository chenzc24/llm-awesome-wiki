# Skill Runtime Consolidation Stage 1-3

## Goal

Execute the full three-stage skill runtime consolidation:

1. Make `skills/` the workflow runtime and progressive-disclosure entrypoint.
2. Review the new skill runtime against the existing `rules/workflow/**`
   baseline before deleting anything.
3. Complete the Stage 3 cleanup by removing workflow-rule runtime entrypoints
   whose semantics have been migrated, updating current references, and
   keeping detailed non-workflow rules as the reference layer.

The final state should make normal execution start from one active skill, not
from `rules/workflow/**`.

## Dirty-State Note

Starting status was clean:

```text
## main...origin/main
```

`git submodule status` was checked because current references mention pinned
reference repositories. `MinerU/` and `llm_wiki/` remain read-only references.

## Owned Files

- `skills/llm-wiki-distill/SKILL.md`
- `skills/llm-wiki-distill/agents/openai.yaml`
- `skills/llm-wiki-source-packet/SKILL.md`
- `skills/llm-wiki-source-packet/agents/openai.yaml`
- `skills/llm-wiki-wiki-round/SKILL.md`
- `skills/llm-wiki-wiki-round/agents/openai.yaml`
- `skills/llm-wiki-quality-gate/SKILL.md`
- `skills/llm-wiki-quality-gate/agents/openai.yaml`
- `rules/README.md`
- `rules/workflow/**`
- `README.md`
- `llm_wiki_tools/cli.py`
- `docs/top-level-design/system-architecture-plan.md`
- `docs/collaboration/skill-runtime-vs-workflow-rules-review.md`
- `docs/collaboration/README.md`
- `docs/collaboration/person-b-workflow-closure-review.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `rules/source/**`
- `rules/wiki/**`
- `rules/claims/**`
- `rules/review/**`
- `contracts/**`
- `tests/**`
- `templates/**`
- `llm_wiki/**`
- `MinerU/**`

If Stage 3 reveals a detailed non-workflow rule is required, prefer updating
current references or schemas/tools in a later target rather than expanding
this target.

## Implementation Plan

1. Stage 1: Rewrite each `SKILL.md` as a self-contained runtime card:
   - active-stage inputs
   - default execution sequence
   - required outputs
   - minimum validation
   - progressive-disclosure triggers for detailed `rules/**`
   - hard boundaries
2. Stage 2: Add a parity review document comparing each `rules/workflow/*.md`
   file with the new skill runtime.
3. Stage 3: Based on the review:
   - delete workflow-rule files whose runtime role has been migrated to skills
   - update `rules/README.md` so rules are detailed reference, not runtime entry
   - update validator required paths
   - update current-facing references away from `rules/workflow/**`
4. Update personal and global logs.

## Validation Plan

- `git diff --check`
- `python -m py_compile llm_wiki_tools/cli.py llm_wiki_tools/__main__.py`
- `python -m llm_wiki_tools validate-kernel`
- `rg -n "rules/workflow|workflow/" -g "!llm_wiki/**" -g "!MinerU/**"`
  with remaining hits limited to historical plans/logs or the parity review
- targeted `rg` to confirm skill runtime language:
  - `runtime`
  - `progressive disclosure`
  - `source packet`
  - `wiki construction analysis`
  - `pass`
  - `close-pass`
  - `rules/source`
  - `rules/wiki`
  - `rules/claims`
  - `rules/review`
- `git status --short --branch`

## Commit Intent

Commit message:

```text
Consolidate workflow runtime into skills
```

Push to `origin main` after validation.

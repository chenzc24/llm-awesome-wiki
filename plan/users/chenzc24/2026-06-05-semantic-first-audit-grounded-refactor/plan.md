# Semantic-First, Audit-Grounded Refactor Plan

## Goal

Refactor the workflow direction after the ADCtoolbox PPT/PDF test showed that
the current source-packet-first pipeline can preserve references while losing
formulas, derivations, and dense technical meaning.

The new direction is:

```text
raw/rendered/external reading -> semantic draft -> grounding to source anchors
-> accepted wiki -> compare/review/closure
```

The source packet remains required, but it is an audit baseline rather than the
semantic ceiling for wiki construction.

## Dirty-State Note

Initial status:

```text
## main...origin/main
!! workspace/local/
```

The tracked worktree is clean. `workspace/local/` is ignored local test output
and is unrelated to this target.

## Owned Files

- `README.md`
- `docs/core-philosophy.md`
- `docs/knowledge-to-executable.md`
- `docs/top-level-design/system-architecture-plan.md`
- `skills/llm-wiki-distill/SKILL.md`
- `skills/llm-wiki-source-packet/SKILL.md`
- `skills/llm-wiki-wiki-round/SKILL.md`
- `skills/llm-wiki-wiki-round/agents/openai.yaml`
- `skills/llm-wiki-quality-gate/SKILL.md`
- `rules/wiki/wiki-surface-workflow.md`
- `rules/wiki/source-wiki-coverage-protocol.md`
- `rules/README.md`
- `templates/workspace-kernel/reports/wiki-construction-analysis.template.md`
- `templates/workspace-kernel/reports/compare-report.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `templates/workspace-kernel/AGENTS.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/schema.md`
- `templates/workspace-kernel/reports/README.md`
- `templates/workspace-kernel/wiki/chapters/README.md`
- `templates/workspace-kernel/wiki/chapters/chapter-page.template.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- This plan file

## Read-Only Files

- `llm_wiki_tools/**`
- `contracts/**`
- `tests/**`
- `workspace/local/**`
- `llm_wiki/**`
- `MinerU/**`

## Expected Changes

- Clarify top-level project philosophy: source packets support audit and
  traceability, but final knowledge quality requires a semantic drafting pass.
- Update skills so the operational route is progressive:
  fixed input set, packet baseline, semantic draft, grounding pass, wiki merge,
  quality gate, closure.
- Update wiki rules so formulas, derivations, tables, examples, and conceptual
  explanations are treated as knowledge coverage, not optional decoration.
- Update report and wiki templates so semantic richness and grounding are both
  visible before accepting a wiki round.
- Avoid changing extractors, schemas, validators, or checker implementation in
  this pass.

## Validation

- `git diff --check`
- `python -m llm_wiki_tools validate-kernel`
- `python -m llm_wiki_tools fixture-runner`
- Targeted `rg` checks for the new language:
  - `semantic draft`
  - `audit baseline`
  - `semantic ceiling`
  - `grounding`
  - `formula`
  - `derivation`
- `git status --short --branch`

## Validation Results

- `git diff --check`: passed with only Windows line-ending warnings.
- `python -m llm_wiki_tools validate-kernel`: passed.
- `python -m llm_wiki_tools fixture-runner`: passed.
- Targeted `rg`: confirmed `semantic draft`, `grounding pass`,
  `audit baseline`, `semantic ceiling`, `candidate-derived`, and
  `semantic richness`; no current-facing `source-packet-to-wiki` runtime
  wording remained.
- Temporary `fixture-runner-report.md` output was removed before commit.

## Commit Intent

Commit message:

```text
Refactor workflow toward semantic-first grounding
```

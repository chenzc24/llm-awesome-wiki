# Maintenance Log

## 2026-06-03 - Bootstrap VSCode-native LLM Wiki workflow

- Target: establish root repository guidance, core philosophy, planning
  discipline, and documentation skeleton.
- Changed areas: added `AGENTS.md`, core documentation under `docs/`, planning
  records under `plan/`, and placeholder guidance under `tools/` and
  `templates/`.
- Validation: `git diff --check` passed; `rg --files AGENTS.md docs plan tools
  templates` confirmed expected files; targeted `rg` confirmed git discipline,
  no-Obsidian dependency, `llm_wiki` reference boundary, and
  knowledge-to-executable direction.
- Commit: ready for `Bootstrap VSCode-native LLM wiki workflow`.

## 2026-06-03 - Clarify knowledge-to-code execution mainline

- Target: clarify that "knowledge should lead to execution" means a future path
  from distilled knowledge to an executable codebase or capability library,
  especially `skill + tool` artifacts.
- Changed areas: updated `docs/core-philosophy.md`,
  `docs/knowledge-to-executable.md`, `docs/execution-roadmap.md`, and
  `docs/llm_wiki-reference.md`; added the target plan under
  `plan/2026-06-03-clarify-knowledge-to-code/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed
  `next-stage mainline`, `skill + tool`, `executable codebase`, and
  `knowledge-to-code` language across the mainline docs.
- Commit: ready for `Clarify knowledge-to-code execution mainline`.

## 2026-06-03 - Split construction and downstream execution layers

- Target: separate the knowledge-construction executable layer from the later
  downstream knowledge-to-code mainline.
- Changed areas: updated `docs/core-philosophy.md`,
  `docs/knowledge-to-executable.md`, `docs/execution-roadmap.md`,
  `docs/llm_wiki-reference.md`, and `tools/README.md`; added the target plan
  under `plan/2026-06-03-split-execution-layers/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `construction executable layer`,
  `knowledge-base construction`, `downstream knowledge-to-code`, and
  `skill + tool` language across docs and tools guidance.
- Commit: ready for `Split construction and downstream execution layers`.

## 2026-06-03 - Add top-level phased distillation design

- Target: add a designer-maintained top-level design area under `docs/` and
  define staged raw resource to Markdown/Wiki distillation work.
- Changed areas: added `docs/top-level-design/README.md`,
  `docs/top-level-design/phased-distillation-design.md`, and the target plan
  under `plan/2026-06-03-top-level-design-plan/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed
  `raw_resource`, source packet, PDF/PPTX/DOCX handling, LLM responsibility
  boundaries, and `llm_wiki` reference points in the new design docs.
- Commit: ready for `Add top-level phased distillation design`.

## 2026-06-03 - Reframe top-level design as system architecture

- Target: reframe the top-level design area as the architecture plan for the
  new LLM Awesome Wiki system, not a `llm_wiki`-based knowledge-base generation
  plan, and make the design docs English-only.
- Changed areas: updated `docs/top-level-design/README.md`, replaced
  `docs/top-level-design/phased-distillation-design.md` with
  `docs/top-level-design/system-architecture-plan.md`, and added the target
  plan under `plan/2026-06-03-reframe-top-level-system-design/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed no Chinese text remains in the top-level design area,
  `llm_wiki` is framed as a reference boundary, raw-resource conversion is a
  subsystem, and PDF/PPTX/DOCX plus LLM responsibility sections are present.
- Commit: ready for `Reframe top-level design as system architecture`.

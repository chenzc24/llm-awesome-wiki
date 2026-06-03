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

## 2026-06-03 - Add plan cleanup rule

- Target: add an Agent rule requiring periodic cleanup of completed `plan/`
  entries so the planning directory stays useful.
- Changed areas: updated `AGENTS.md`; added the target plan under
  `plan/2026-06-03-add-plan-cleanup-rule/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed plan hygiene,
  completed-plan summarization, archive/removal, and in-progress protection
  language in `AGENTS.md`; `git submodule status` confirmed `llm_wiki` remained
  unchanged.
- Commit: ready for `Add plan cleanup rule`.

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

## 2026-06-03 - Refine system architecture execution layer boundaries

- Target: align `docs/top-level-design/system-architecture-plan.md` with the
  two-layer execution model: construction tools/reports inside knowledge-base
  construction, downstream domain `skill + tool` artifacts only after a stable
  knowledge release.
- Changed areas: updated the product thesis pipeline, directory comments,
  Layer 5/6/7 boundaries, Phase 0/5/6/7 wording, the LLM responsibility matrix,
  and derived execution targets; added the target plan under
  `plan/2026-06-03-refine-system-architecture-execution-layers/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `construction tools`, `stable knowledge release`,
  `downstream executable`, `domain skills`, and `domain tools` language.
- Commit: ready for `Refine architecture execution layer boundaries`.

## 2026-06-03 - Add developer README

- Target: add a root developer-facing README for onboarding contributors into
  the VSCode/Git/agent-native LLM Awesome Wiki project.
- Changed areas: added `README.md`; added the target plan under
  `plan/2026-06-03-add-developer-readme/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed `Phase 1`,
  `Repository Kernel`, `llm_wiki`, `construction tools`, `downstream`,
  `AGENTS.md`, and `plan/log.md` language in the README.
- Commit: ready for `Add developer README`.

## 2026-06-03 - Separate system repo from generated workspace

- Target: clarify that this repository is the producer/system repository, not
  an instantiated knowledge workspace.
- Changed areas: updated `README.md` and
  `docs/top-level-design/system-architecture-plan.md`; added the target plan
  under `plan/2026-06-03-separate-system-repo-and-generated-workspace/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `system repository`, `generated workspace`,
  root-level `raw/`, `wiki/`, `reports/`, and `schemas/` boundary language.
- Commit: ready for `Separate system repo from generated workspace`.

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

## 2026-06-03 - Add multi-agent maintenance rules

- Target: make root and generated-workspace maintenance rules safe for
  parallel co-worker work before downstream skill/tool development.
- Changed areas: updated `AGENTS.md`, `rules/maintenance-workflow.md`, and
  `plan/README.md`; added the target plan under
  `plan/2026-06-03-add-multi-agent-maintenance-rules/`.
- Validation: `rg` confirmed ownership, read-only files, Coordinator,
  `contracts/schemas/*` single-owner rules, minimum validation commands, and
  `llm_wiki/` read-only language; `git diff --check` passed with only Windows
  line-ending warnings; `git status --short --branch` reviewed.
- Commit: ready for `Add multi-agent maintenance rules`.

## 2026-06-03 - Add user plan namespaces

- Target: introduce per-user plan namespaces and personal logs, keep shared
  integration plans separate, and document that `docs/phase-plans/` contains
  important Coordinator-owned phase plans.
- Changed areas: updated `AGENTS.md`, `plan/README.md`,
  `rules/maintenance-workflow.md`, and `rules/README.md`; added
  `plan/users/`, `plan/users/chenzc24/`, `plan/shared/`,
  `plan/shared/integration/`, `docs/phase-plans/README.md`, and the target
  plan under `plan/2026-06-03-add-user-plan-namespaces/`.
- Validation: targeted `rg` confirmed `plan/users/<user>`,
  `plan/users/chenzc24/log.md`, `plan/shared/integration`,
  `docs/phase-plans`, Coordinator ownership, and global log language;
  `git diff --check` passed with only Windows line-ending warnings; `git
  status --short --branch` reviewed.
- Commit: ready for `Add user plan namespaces`.

## 2026-06-03 - Add workspace kernel phase one substrate

- Target: implement Phase 1 as a copy-first, VSCode-native workspace kernel
  substrate while keeping the root repository as the system producer.
- Changed areas: updated `README.md`,
  `docs/top-level-design/system-architecture-plan.md`, `templates/README.md`,
  and `tools/README.md`; added Phase 1 design under `docs/phase-plans/`, rules
  under `rules/`, contracts under `contracts/schemas/`, the copyable workspace
  kernel under `templates/workspace-kernel/`, tool skeletons under `tools/`,
  test guidance under `tests/`, and the target plan under
  `plan/2026-06-03-phase-1-workspace-kernel/`.
- Validation: `tools/validate-kernel/validate-kernel.ps1` passed; JSON schemas
  parsed with `ConvertFrom-Json`; root-level active workspace paths
  `raw/`, `wiki/`, `reports/`, and `schema.md` were absent; `git diff --check`
  passed with only Windows line-ending warnings; `git submodule status`
  confirmed `llm_wiki` remained pinned.
- Commit: completed and pushed to `origin/main` as `9366118 Add workspace
  kernel phase one substrate`.

## 2026-06-03 - Record phase one final maintenance status

- Target: correct the Phase 1 maintenance record so it reflects the actual
  committed and pushed state.
- Changed areas: updated `plan/log.md`; added the target plan under
  `plan/2026-06-03-record-phase-1-final-status/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed the Phase 1 entry references commit `9366118`; `git
  status --short --branch` showed only the intended maintenance files before
  commit.
- Commit: ready for `Record phase one final maintenance status`.

## 2026-06-03 - Close workspace kernel phase one loop

- Target: close Phase 1.1 by aligning workspace-kernel rules, templates,
  contracts, and validator expectations before starting Phase 2.
- Changed areas: updated `README.md`,
  `docs/top-level-design/system-architecture-plan.md`, rules under `rules/`,
  schema guidance under `contracts/schemas/`, workspace templates under
  `templates/workspace-kernel/`, validation under `tools/validate-kernel/`,
  test guidance under `tests/`, and added the target plan under
  `plan/2026-06-03-phase-1-1-workspace-kernel-closure/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; schema JSON parsed with
  `ConvertFrom-Json`; root-level active workspace paths were absent; targeted
  `rg` confirmed Phase 1.1 and Phase 2-not-started language; `git submodule
  status` confirmed `llm_wiki` remained pinned.
- Commit: completed and pushed to `origin/main` as `7376979 Close workspace
  kernel phase one loop`.

## 2026-06-03 - Record phase one point one final maintenance status

- Target: correct the Phase 1.1 maintenance record so it reflects the actual
  committed and pushed state.
- Changed areas: updated `plan/log.md`; added the target plan under
  `plan/2026-06-03-record-phase-1-1-final-status/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed the Phase 1.1 entry references commit `7376979`; `git
  status --short --branch` showed only the intended maintenance files before
  commit.
- Commit: ready for `Record phase one point one final maintenance status`.

## 2026-06-03 - Make document corpus the default workspace profile

- Target: minimally correct the default workspace profile so large document and
  PPT corpora preserve source and chapter structure by default, while
  research-wiki object types remain optional extensions.
- Changed areas: updated top-level direction docs, core philosophy, execution
  roadmap, `llm_wiki` reference boundary, wiki index and distillation rules,
  workspace-kernel schema/index/overview/source templates, and the kernel
  validator; added the target plan under
  `plan/2026-06-03-correct-default-document-corpus-profile/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; schema JSON parsed with
  `ConvertFrom-Json`; root-level active workspace paths were absent; targeted
  `rg` confirmed document/PPT corpus defaults, `wiki/chapters/`, and optional
  research-profile language; `git submodule status` confirmed `llm_wiki`
  remained pinned.
- Commit: ready for `Make document corpus the default workspace profile`.

## 2026-06-03 - Align distillation rounds with overview-first flow

- Target: update the distillation round rule so new work starts with broad
  source readthrough, overview creation, skeleton index, and staged
  distillation planning before detailed rounds.
- Changed areas: updated `rules/distillation-rounds.md`; added the target plan
  under
  `plan/2026-06-03-align-distillation-rounds-with-overview-first-flow/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed overview-first initialization, broad source
  readthrough, skeleton index, staged distillation plan, and detailed-page
  boundary language in `rules/distillation-rounds.md`; `git status
  --short --branch` showed only the intended files before commit.
- Commit: completed and pushed to `origin/main` as `ce33edd Align
  distillation rounds with overview first flow`.

## 2026-06-03 - Simplify workspace maintenance for single maintainer

- Target: remove co-worker, coordinator, ownership, and shared integration
  workflow rules from generated workspace maintenance guidance.
- Changed areas: updated `rules/maintenance-workflow.md`; added the target
  plan under
  `plan/2026-06-03-simplify-workspace-maintenance-single-maintainer/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `rules/maintenance-workflow.md` no longer contains
  co-worker, coordinator, ownership, shared integration, multi-agent, or branch
  policy workflow rules.
- Commit: ready for `Simplify workspace maintenance for single maintainer`.

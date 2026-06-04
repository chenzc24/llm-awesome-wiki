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
  `plan/users/chenzc24/2026-06-03-clarify-knowledge-to-code/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed
  `next-stage mainline`, `skill + tool`, `executable codebase`, and
  `knowledge-to-code` language across the mainline docs.
- Commit: ready for `Clarify knowledge-to-code execution mainline`.

## 2026-06-03 - Add plan cleanup rule

- Target: add an Agent rule requiring periodic cleanup of completed `plan/`
  entries so the planning directory stays useful.
- Changed areas: updated `AGENTS.md`; added the target plan under
  `plan/users/chenzc24/2026-06-03-add-plan-cleanup-rule/`.
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
  under `plan/users/chenzc24/2026-06-03-split-execution-layers/`.
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
  `plan/users/chenzc24/2026-06-03-refine-system-architecture-execution-layers/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `construction tools`, `stable knowledge release`,
  `downstream executable`, `domain skills`, and `domain tools` language.
- Commit: ready for `Refine architecture execution layer boundaries`.

## 2026-06-03 - Add developer README

- Target: add a root developer-facing README for onboarding contributors into
  the VSCode/Git/agent-native LLM Awesome Wiki project.
- Changed areas: added `README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-03-add-developer-readme/`.
- Validation: `git diff --check` passed; targeted `rg` confirmed `Phase 1`,
  `Repository Kernel`, `llm_wiki`, `construction tools`, `downstream`,
  `AGENTS.md`, and `plan/log.md` language in the README.
- Commit: ready for `Add developer README`.

## 2026-06-03 - Separate system repo from generated workspace

- Target: clarify that this repository is the producer/system repository, not
  an instantiated knowledge workspace.
- Changed areas: updated `README.md` and
  `docs/top-level-design/system-architecture-plan.md`; added the target plan
  under `plan/users/chenzc24/2026-06-03-separate-system-repo-and-generated-workspace/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `system repository`, `generated workspace`,
  root-level `raw/`, `wiki/`, `reports/`, and `schemas/` boundary language.
- Commit: ready for `Separate system repo from generated workspace`.

## 2026-06-03 - Add top-level phased distillation design

- Target: add a designer-maintained top-level design area under `docs/` and
  define staged raw resource to Markdown/Wiki distillation work.
- Changed areas: added `docs/top-level-design/README.md`,
  `docs/top-level-design/phased-distillation-design.md`, and the target plan
  under `plan/users/chenzc24/2026-06-03-top-level-design-plan/`.
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
  plan under `plan/users/chenzc24/2026-06-03-reframe-top-level-system-design/`.
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
  `plan/users/chenzc24/2026-06-03-add-multi-agent-maintenance-rules/`.
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
  plan under `plan/users/chenzc24/2026-06-03-add-user-plan-namespaces/`.
- Validation: targeted `rg` confirmed `plan/users/<user>`,
  `plan/users/chenzc24/log.md`, `plan/shared/integration`,
  `docs/phase-plans`, Coordinator ownership, and global log language;
  `git diff --check` passed with only Windows line-ending warnings; `git
  status --short --branch` reviewed.
- Commit: ready for `Add user plan namespaces`.

## 2026-06-03 - Migrate historical plans to chenzc24

- Target: move existing historical target plans into `plan/users/chenzc24/`,
  remove the misleading `plan/users/codex/` namespace, and clarify that
  executor agents are not user namespaces.
- Changed areas: moved root-level historical plan folders and the former
  `plan/users/codex/2026-06-03-record-document-corpus-default-final-status/`
  plan into `plan/users/chenzc24/`; updated `AGENTS.md`, `plan/README.md`,
  `plan/users/README.md`, `plan/users/chenzc24/log.md`, and `plan/log.md`.
- Validation: confirmed no root-level `plan/2026-06-03-*` target plan
  directories remain and `plan/users/codex` does not exist; targeted `rg`
  confirmed executor-agent namespace language and migrated `chenzc24` plan
  paths; `git diff --check` passed with only Windows line-ending warnings; `git
  status --short --branch` reviewed.
- Commit: ready for `Migrate historical plans to chenzc24`.

## 2026-06-03 - Add workspace kernel phase one substrate

- Target: implement Phase 1 as a copy-first, VSCode-native workspace kernel
  substrate while keeping the root repository as the system producer.
- Changed areas: updated `README.md`,
  `docs/top-level-design/system-architecture-plan.md`, `templates/README.md`,
  and `tools/README.md`; added Phase 1 design under `docs/phase-plans/`, rules
  under `rules/`, contracts under `contracts/schemas/`, the copyable workspace
  kernel under `templates/workspace-kernel/`, tool skeletons under `tools/`,
  test guidance under `tests/`, and the target plan under
  `plan/users/chenzc24/2026-06-03-phase-1-workspace-kernel/`.
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
  `plan/users/chenzc24/2026-06-03-record-phase-1-final-status/`.
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
  `plan/users/chenzc24/2026-06-03-phase-1-1-workspace-kernel-closure/`.
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
  `plan/users/chenzc24/2026-06-03-record-phase-1-1-final-status/`.
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
  `plan/users/chenzc24/2026-06-03-correct-default-document-corpus-profile/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; schema JSON parsed with
  `ConvertFrom-Json`; root-level active workspace paths were absent; targeted
  `rg` confirmed document/PPT corpus defaults, `wiki/chapters/`, and optional
  research-profile language; `git submodule status` confirmed `llm_wiki`
  remained pinned.
- Commit: completed and pushed to `origin/main` as `10a4d0a Make document
  corpus the default workspace profile`.

## 2026-06-03 - Add workspace kernel golden path templates

- Target: make Phase 1.3 usable for a first manual document/PPT distillation
  round by adding first-use guidance and workspace templates for planning,
  source inventory, source packets, wiki pages, and validation notes.
- Changed areas: updated `README.md`,
  `templates/workspace-kernel/README.md`, and
  `tools/validate-kernel/validate-kernel.ps1`; added the Phase 1.3 phase plan,
  first-round plan template, source inventory and packet templates, overview,
  source-page, chapter-page, and validation-note templates; added the target
  plan under
  `plan/users/chenzc24/2026-06-03-phase-1-3-workspace-kernel-golden-path/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 1.3, golden path, source inventory, source packet, first-round, and
  `compare gate not enabled` language; `git submodule status` confirmed
  `llm_wiki` remained pinned; `git status --short --branch` showed the intended
  Phase 1.3 files plus unrelated untracked user work under `docs/collaboration/`
  and `plan/users/chenzc24/2026-06-03-document-two-person-worksplit/`, which
  were left untouched.
- Commit: completed and pushed to `origin/main` as `804412a Add workspace
  kernel golden path templates`.

## 2026-06-03 - Align distillation rounds with overview-first flow

- Target: update the distillation round rule so new work starts with broad
  source readthrough, overview creation, skeleton index, and staged
  distillation planning before detailed rounds.
- Changed areas: updated `rules/distillation-rounds.md`; added the target plan
  under
  `plan/users/chenzc24/2026-06-03-align-distillation-rounds-with-overview-first-flow/`.
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
  `plan/users/chenzc24/2026-06-03-simplify-workspace-maintenance-single-maintainer/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed `rules/maintenance-workflow.md` no longer contains
  co-worker, coordinator, ownership, shared integration, multi-agent, or branch
  policy workflow rules.
- Commit: ready for `Simplify workspace maintenance for single maintainer`.

## 2026-06-03 - Document two-person pre-skill/tools worksplit

- Target: add a newcomer-friendly collaboration guide that explains the
  two-person owner split before downstream skill/tool development.
- Changed areas: added `docs/collaboration/README.md` and
  `docs/collaboration/two-person-pre-skill-tools-worksplit.md`; added the
  target plan under
  `plan/users/chenzc24/2026-06-03-document-two-person-worksplit/`; updated
  `plan/users/chenzc24/log.md`.
- Validation: targeted `rg` confirmed the two owner lines, pre-skill/tools
  scope, recommended branches, daily sync, and three milestones; `git diff
  --check` passed with only Windows line-ending warnings; `git status
  --short --branch` reviewed.
- Commit: ready for `Document two-person pre-skill tools worksplit`.

## 2026-06-03 - Relax dirty worktree policy

- Target: replace the global clean-worktree requirement with a dirty-state
  audit that blocks only overlapping, unclear, or shared-contract dirty files.
- Changed areas: updated `AGENTS.md` and `plan/README.md`; added the target
  plan under
  `plan/users/chenzc24/2026-06-03-relax-dirty-worktree-policy/`; updated
  `plan/users/chenzc24/log.md`.
- Validation: targeted `rg` confirmed dirty-state audit, unrelated dirty work,
  owned-file overlap, shared-contract dependency, and plan-note language; `git
  diff --check` passed with only Windows line-ending warnings; `git status
  --short --branch` reviewed.
- Commit: ready for `Relax dirty worktree policy for parallel work`.

## 2026-06-03 - Add ignored ADCtoolbox ch1 dry run workspace

- Target: add explicit ignore settings for local workspace dry runs and test
  the Phase 1.3 golden path on `ch1.pdf`.
- Changed areas: added `.gitignore`; added the target plan under
  `plan/users/chenzc24/2026-06-03-adctoolbox-ch1-pdf-dry-run/`; created an
  ignored local workspace under `workspace/local/adctoolbox-ch1-dry-run/`.
- Dry-run result: copied `ch1.pdf`, extracted PDF metadata and text with
  `pdfinfo` and `pdftotext`, rendered pages 3-8 with `pdftoppm`, created source
  inventory, source packet, overview, source page, chapter page, validation
  note, and workspace logs. The round status is `needs-review` because compare
  is not enabled and page 7 still needs stricter chart extraction for precise
  quantitative use.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  ignored workspace metadata JSON parsed with `ConvertFrom-Json`; targeted
  `rg` confirmed source inventory, source packet, source anchors, and
  `compare gate not enabled`; `git check-ignore -v` confirmed the copied PDF,
  rendered page image, and wiki output are ignored by `.gitignore`; `git
  submodule status` confirmed `llm_wiki` remained pinned; `git status --short
  --branch --untracked-files=all` showed only the intended tracked maintenance
  files.
- Commit: completed and pushed to `origin/main` as `d32621d Add ignored
  workspace dry run area`.

## 2026-06-03 - Split collaboration responsibilities by phase

- Target: split the two-person pre-skill/tool collaboration guidance into
  phase-by-phase assignments for Person A and Person B.
- Changed areas: added detailed Person A and Person B phase guides under
  `docs/collaboration/`, updated the collaboration README and two-person
  overview, and added the target plan under
  `plan/users/chenzc24/2026-06-03-split-collaboration-by-phase/`.
- Validation: targeted `rg` confirmed Phase 0, Phase 1/1.1, Person A, Person B,
  `chenzc24`, rough first draft, and pre-skill/tool language; `git diff
  --check` passed with only Windows line-ending warnings; `git submodule
  status` confirmed `llm_wiki` remained pinned.
- Commit: ready for `Split collaboration responsibilities by phase`.

## 2026-06-04 - Add MinerU reference submodule

- Target: fork `opendatalab/MinerU` into `chenzc24/MinerU` and add the fork as
  a pinned reference submodule for Person B Phase 2 raw-resource conversion
  planning.
- Changed areas: updated `.gitmodules`; added the `MinerU/` submodule at
  commit `ef4aa39`; added the target plan under
  `plan/users/chenzc24/2026-06-04-add-mineru-reference-submodule/`.
- Validation: `gh repo view chenzc24/MinerU` confirmed the fork exists with
  default branch `master`; `git submodule status` confirmed `MinerU` is pinned
  at `ef4aa39` and `llm_wiki` remains pinned; `.gitmodules` config inspection
  confirmed `MinerU` points to `https://github.com/chenzc24/MinerU.git`; `git
  diff --check` passed with only Windows line-ending warnings; `git status
  --short --branch` showed only the intended submodule and maintenance files.
- Commit: completed and pushed to `origin/co-work/czc_personB` as `59b3c9e
  Add MinerU reference submodule`.

## 2026-06-04 - Plan phase two raw resource conversion

- Target: plan Person B Phase 2 as the raw-resource-to-source-packet workflow
  layer, using `MinerU/` as a read-only parsing reference without making it a
  required runtime dependency.
- Changed areas: added `docs/phase-plans/phase-2-raw-resource-conversion.md`
  and the target plan under
  `plan/users/chenzc24/2026-06-04-plan-phase-2-raw-resource-conversion/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed Phase 2, MinerU, source-packet, CPU-first,
  generated-field, and Person A handoff language; `git submodule status`
  confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended Phase 2 planning files.
- Commit: completed and pushed to `origin/co-work/czc_personB` as `30a6449
  Plan phase two raw resource conversion`.

## 2026-06-04 - Define source intake inventory workflow

- Target: advance Phase 2.1 by defining the source intake and inventory
  workflow before source-packet writing begins.
- Changed areas: added
  `docs/phase-plans/phase-2.1-source-intake-inventory.md`; updated
  `rules/raw-to-source-packet.md`,
  `templates/workspace-kernel/raw/source-inventory.template.md`, and
  `tools/source-inventory/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-phase-2-1-source-intake-inventory/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 2.1, source-intake, source-inventory, source ID, status, hash, review
  handoff, and unsupported-source language; `git submodule status` confirmed
  `MinerU/` and `llm_wiki/` remained pinned; `git status --short --branch`
  showed only the intended Phase 2.1 files.
- Commit: completed and pushed to `origin/co-work/czc_personB` as `43c7c8d
  Define source intake inventory workflow`.

## 2026-06-04 - Add artifact economy and raw-wiki alignment design

- Target: promote artifact economy and raw-wiki alignment into top-level
  architecture constraints that apply across all phases.
- Changed areas: added
  `docs/top-level-design/artifact-economy-and-raw-wiki-alignment.md`; updated
  `docs/top-level-design/system-architecture-plan.md`,
  `docs/top-level-design/README.md`, `docs/knowledge-to-executable.md`,
  `docs/phase-plans/phase-2-raw-resource-conversion.md`, and Person A/B
  collaboration guidance; added the target plan under
  `plan/users/chenzc24/2026-06-04-add-artifact-economy-raw-wiki-alignment-design/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed raw-wiki alignment, artifact economy, one fact/one
  source of truth, readable layer, audit layer, alignment reports, and duplicate
  truth language; `git submodule status` confirmed `MinerU/` and `llm_wiki/`
  remained pinned; `git status --short --branch` showed only the intended
  design and maintenance files.
- Commit: completed and pushed to `origin/co-work/czc_personB` as `d8684ff Add
  artifact economy and raw-wiki alignment design`.

## 2026-06-04 - Reframe phase two as packet protocol

- Target: adjust Phase 2 and collaboration guidance so Phase 2 is understood as
  a raw-resource-to-source-packet protocol layer, not a project-owned
  PDF/PPTX/DOCX parser harness or MinerU-style conversion engine.
- Changed areas: updated `docs/phase-plans/phase-2-raw-resource-conversion.md`,
  `docs/phase-plans/phase-1.1-workspace-kernel-closure.md`,
  `docs/collaboration/person-a-contracts-validation-by-phase.md`,
  `docs/collaboration/person-b-workflow-surface-by-phase.md`, and
  `docs/collaboration/two-person-pre-skill-tools-worksplit.md`; added the
  target plan under
  `plan/users/chenzc24/2026-06-04-reframe-phase-2-protocol-first/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  targeted `rg` confirmed protocol-first, source packet protocol, extractor
  adapter, no-harness, and stable Person A/B ownership language; `git submodule
  status` confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended protocol-reframing files.
- Commit: completed and pushed to `origin/co-work/czc_personB` as `945104b
  Reframe phase two as packet protocol`.

## 2026-06-04 - Clarify agent-readable wiki layer

- Target: refine the artifact-economy language so the wiki layer is
  agent-readable first and human-reviewable second, rather than
  human-readable-first prose.
- Changed areas: updated top-level design language, core philosophy,
  knowledge-to-executable guidance, Phase 2 wording, Person A/B collaboration
  guidance, and workspace-kernel wiki page templates; added the target plan
  under
  `plan/users/chenzc24/2026-06-04-clarify-agent-readable-wiki-layer/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  agent-readable, human-reviewable, agent-readable/human-reviewable, and agent
  scanability language; old human-readable wiki wording was removed from the
  wiki-layer context; `git submodule status` confirmed `MinerU/` and
  `llm_wiki/` remained pinned; `git status --short --branch` showed only the
  intended terminology and template files.
- Commit: completed and pushed to `origin/main` as `fb20ded Clarify
  agent-readable wiki layer`.

## 2026-06-04 - Align top-level phase two protocol wording

- Target: align top-level architecture wording with the protocol-first Phase 2
  decision before planning Person B Phase 2.2.
- Changed areas: updated `docs/top-level-design/system-architecture-plan.md`
  and `docs/top-level-design/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-align-top-level-phase-2-protocol/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  source packet protocol, raw-wiki alignment substrate, source-type packet
  profile, optional extractor, and parser harness non-goal language; `git
  submodule status` confirmed `MinerU/` and `llm_wiki/` remained pinned; `git
  status --short --branch` showed only the intended top-level wording files.
- Commit: completed and pushed to `origin/main` as `386c94f Align top-level
  phase two protocol wording`.

## 2026-06-04 - Define source packet protocol

- Target: advance Person B Phase 2.2 by defining the minimum source packet
  protocol after a source inventory row becomes ready.
- Changed areas: added
  `docs/phase-plans/phase-2.2-source-packet-protocol.md`; updated
  `rules/raw-to-source-packet.md`,
  `templates/workspace-kernel/raw/source-packet.template.md`, and
  `templates/workspace-kernel/raw/derived/README.md`; added the target plan
  under
  `plan/users/chenzc24/2026-06-04-phase-2-2-source-packet-protocol/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 2.2, source packet protocol, audit layer, agent-readable wiki,
  metadata source of truth, anchors, generated fields, known gaps, Person A
  handoff, and review routing language; `git submodule status` confirmed
  `MinerU/` and `llm_wiki/` remained pinned; `git status --short --branch`
  showed only the intended Person B Phase 2.2 files.
- Commit: completed on `main` as `a7d89dc Define source packet protocol`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define extractor adapter protocol

- Target: advance Person B Phase 2.3 by defining how optional human, agent,
  MCP, local CLI, MinerU/local CLI, or external extractor workflows connect to
  the workspace and emit valid Phase 2.2 source packets.
- Changed areas: added
  `docs/phase-plans/phase-2.3-extractor-adapter-protocol.md` and
  `rules/extractor-adapter-protocol.md`; updated
  `docs/phase-plans/phase-2-raw-resource-conversion.md` and
  `rules/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-phase-2-3-extractor-adapter-protocol/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Extractor Adapter Protocol, optional adapter, workspace owner,
  `extraction_backend`, backend-local references, workspace anchors, failed
  visibly behavior, manual, Agent/MCP, MinerU/local CLI, and non-goals
  language; `git submodule status` confirmed `MinerU/` and `llm_wiki/`
  remained pinned; `git status --short --branch` showed only the intended
  Person B Phase 2.3 files.
- Commit: completed on `main` as `f0be934 Define extractor adapter protocol`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define source-type packet profiles

- Target: advance Person B Phase 2.4 by defining source-type minimum packet
  expectations for PDF, PPTX, DOCX, image, table/dataset, and mixed media
  sources without implementing parsers or tool specs.
- Changed areas: added
  `docs/phase-plans/phase-2.4-source-type-packet-profiles.md` and
  `rules/source-type-packet-profiles.md`; updated
  `docs/phase-plans/phase-2-raw-resource-conversion.md` and
  `rules/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-phase-2-4-source-type-packet-profiles/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Source-Type Packet Profiles, PDF, PPTX, DOCX, image, table, mixed media,
  page-level anchors, slide-level anchors, heading hierarchy, generated
  captions, review routing, and non-goals language; `git submodule status`
  confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended Person B Phase 2.4 files.
- Commit: completed on `main` as `47c2290 Define source-type packet profiles`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Clarify protocol and contract ownership

- Target: clarify at the top-level design and collaboration split that
  workflow protocols and operational rules are Person B-owned, while
  machine-readable contracts, validators, schemas, and fixtures are Person
  A-owned.
- Changed areas: updated `docs/top-level-design/system-architecture-plan.md`,
  `docs/top-level-design/README.md`,
  `docs/collaboration/two-person-pre-skill-tools-worksplit.md`,
  `docs/collaboration/person-a-contracts-validation-by-phase.md`, and
  `docs/collaboration/person-b-workflow-surface-by-phase.md`; added the target
  plan under
  `plan/users/chenzc24/2026-06-04-clarify-protocol-contract-ownership/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  workflow protocol, operational rule, machine-readable contract, template,
  Person A, Person B, schema, validator, fixture, ownership,
  `rules/*-contract.md`, and `contracts/schemas/**` language; `git submodule
  status` confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended terminology and maintenance files.
- Commit: completed on `main` as `56ffa30 Clarify protocol and contract
  ownership`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define generated fields review routing

- Target: advance Person B Phase 2.5 by defining trust boundaries, packet
  marking, review triggers, and later claim/wiki handoff rules for generated
  or model-assisted source packet content.
- Changed areas: added
  `docs/phase-plans/phase-2.5-generated-fields-review-routing.md` and
  `rules/generated-fields-review-routing.md`; updated
  `docs/phase-plans/phase-2-raw-resource-conversion.md` and
  `rules/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-phase-2-5-generated-fields-review-routing/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Generated Fields And Review Routing, source-equivalent, `ocr_text`,
  `image_caption`, `chart_summary`, `table_repair`, `formula_recognition`,
  `inferred_reading_order`, `review_required`, `review_reason`, `known_gaps`,
  generated content, Person A Handoff, and Non-Goals language; `git submodule
  status` confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended Person B Phase 2.5 files.
- Commit: completed on `main` as `ba90966 Define generated fields review
  routing`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase two tool surface specs

- Target: advance Person B Phase 2.6 by defining README-level behavior specs
  for the Phase 2 construction tool trio: `source-inventory`,
  `source-packet-convert`, and `source-packet-lint`.
- Changed areas: added
  `docs/phase-plans/phase-2.6-tool-surface-specs.md`,
  `tools/source-packet-convert/README.md`, and
  `tools/source-packet-lint/README.md`; updated
  `docs/phase-plans/phase-2-raw-resource-conversion.md`,
  `tools/source-inventory/README.md`, and `tools/README.md`; added the target
  plan under `plan/users/chenzc24/2026-06-04-phase-2-6-tool-surface-specs/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Tool Surface Specs, `source-inventory`, `source-packet-convert`,
  `source-packet-lint`, inputs, outputs, failure modes, exit codes,
  deterministic behavior, adapter boundaries, `generated_fields`,
  `review_required`, `known_gaps`, and Non-Goals language; `git submodule
  status` confirmed `MinerU/` and `llm_wiki/` remained pinned; `git status
  --short --branch` showed only the intended Person B Phase 2.6 files.
- Commit: completed on `main` as `512126b Define phase two tool surface
  specs`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Close phase two raw-to-packet workflow

- Target: close Phase 2 from the Person B workflow-surface side and collect a
  clear Person A handoff for schemas, validators, fixtures, and report needs.
- Changed areas: added `docs/phase-plans/phase-2-closure-handoff.md`; updated
  `docs/phase-plans/phase-2-raw-resource-conversion.md` and
  `docs/phase-plans/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-phase-2-closure-handoff/`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 2 Closure, Person A Handoff, complete, source inventory, source
  packet, extractor adapter, source-type packet profiles, generated fields,
  tool surface specs, schema, validator, fixtures, Phase 3, and Non-Goals
  language; `git submodule status` confirmed `MinerU/` and `llm_wiki/`
  remained pinned; `git status --short --branch` showed only the intended Phase
  2 closure files.
- Commit: completed on `main` as `a6801fd Close phase two raw-to-packet
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase three evidence claim workflow

- Target: execute and review all Person B Phase 3 workflow-surface work so
  Phase 2 source packet anchors can become evidence, claims, review items, and
  later wiki/compare handoff artifacts without becoming a second wiki.
- Changed areas: added Phase 3 phase-plan and closure-review documents; added
  `rules/source-packet-to-evidence.md`, `rules/evidence-to-claim.md`, and
  `rules/claim-review-routing.md`; added claim/evidence map and review queue
  workspace templates; updated Phase 2/3 plan indexes, distillation and wiki
  rules, workspace kernel templates, and `tools/claim-audit/README.md`.
- Design review: aligned with VSCode/Git-first, Agent-first, artifact economy,
  raw-wiki alignment, generated-evidence visibility, and Person A/B ownership
  boundaries. The default wiki surface remains source/chapter-oriented rather
  than a fragmented claim/entity graph.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; all
  `contracts/schemas/*.schema.json` parsed with `ConvertFrom-Json`; targeted
  `rg` confirmed Phase 3 rule, template, review, and tool-surface language;
  `git submodule status` confirmed reference submodules remained pinned.
- Commit: completed on `main` as `4465b0a Define phase three evidence claim
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase four wiki page routing

- Target: start Phase 4.1 from the Person B workflow-surface side by defining
  page routing and the default source/chapter-oriented wiki reading surface.
- Changed areas: added the main Phase 4 plan and `rules/wiki-page-routing.md`;
  updated phase-plan and rule indexes, `source-packet-to-wiki`,
  `wiki-index-contract`, and workspace wiki index/overview/source/chapter
  guidance.
- Design review: aligned with artifact economy and raw-wiki alignment by
  routing source identity to short source notes, distilled knowledge to chapter
  pages, claim/evidence support to reports, and optional synthesis/research
  pages only when justified.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 4.1 routing and reading-surface language; `git submodule status`
  confirmed reference submodules remained pinned.
- Commit: completed on `main` as `ee450aa Define phase four wiki page
  routing`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Harden phase four source chapter templates

- Target: continue Phase 4.2 from the Person B workflow-surface side by
  hardening source/chapter page templates and adding a wiki construction
  analysis template.
- Changed areas: added the Phase 4.2 plan and construction analysis template;
  updated the main Phase 4 plan, phase-plan index, source-packet-to-wiki and
  page-routing rules, workspace report/schema guidance, and source/chapter wiki
  templates.
- Design review: aligned with artifact economy by keeping source pages short,
  keeping chapters readable and source-backed, requiring construction analysis
  before generation, and keeping claim/evidence support in reports.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 4.2 template-hardening and wiki construction analysis language; `git
  submodule status` confirmed reference submodules remained pinned.
- Commit: completed on `main` as `dd490d4 Harden phase four source chapter
  templates`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase four wiki construction round protocol

- Target: continue Phase 4.3 from the Person B workflow-surface side by
  defining a repeatable wiki construction round protocol.
- Changed areas: added the Phase 4.3 plan; updated the main Phase 4 plan,
  phase-plan index, distillation round rule, source-packet-to-wiki rule,
  workspace README/AGENTS guidance, first-round plan, validation note,
  construction analysis template, and wiki log template.
- Design review: aligned with artifact economy by requiring fixed inputs,
  routing, construction analysis, page decision records, index/log updates,
  validation notes, and review carry-forward before a round can close.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 4.3 wiki construction round protocol language; `git submodule status`
  confirmed reference submodules remained pinned.
- Commit: completed on `main` as `41cb2b5 Define phase four wiki construction
  round protocol`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase four overview index log maintenance

- Target: continue Phase 4.4 from the Person B workflow-surface side by
  defining overview, index, and log maintenance rules for wiki construction
  rounds.
- Changed areas: added the Phase 4.4 plan and overview/log contract; updated
  the main Phase 4 plan, phase-plan and rule indexes, distillation and
  source-to-wiki rules, wiki index contract, workspace AGENTS guidance,
  overview/index/log templates, and first-round validation note template.
- Design review: aligned with artifact economy by keeping overview as a
  current corpus map, index as a navigation contract, and log as a short
  chronological event record, with explicit stale-entry and no-change checks.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 4.4 overview/index/log maintenance language; `git submodule status`
  confirmed reference submodules remained pinned.
- Commit: completed on `main` as `02e0fbb Define phase four overview index
  log maintenance`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Close phase four wiki construction workflow

- Target: close Phase 4 from the Person B workflow-surface side and record the
  Phase 4 Person A validation handoff.
- Changed areas: added `docs/phase-plans/phase-4-closure-review.md`; updated
  the main Phase 4 wiki construction plan and phase-plan index; added the
  target plan under
  `plan/users/chenzc24/2026-06-04-phase-4-5-closure-review/`.
- Design review: Phase 4 now has a coherent source/chapter-oriented wiki
  construction surface, with routing, construction analysis, page maintenance,
  overview/index/log closure, and validation handoff boundaries documented.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 4 closure and Phase 5 boundary language.
- Commit: completed on `main` as `460f014 Close phase four wiki construction
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase five compare report foundation

- Target: start Phase 5 from the Person B workflow-surface side by defining
  the compare report foundation for round quality gates.
- Changed areas: added the main Phase 5 plan, Phase 5.1 report-foundation
  plan, and workspace compare report template; expanded the compare gate rule;
  updated the phase-plan index, reports README, review queue template, first
  round validation note template, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-1-compare-report-foundation/`.
- Design review: aligned with raw-wiki alignment and artifact economy by
  making one concise compare report the default decision surface for source
  coverage, claim coverage, modality coverage, link/index checks, omissions,
  contradictions, review items, carried-forward review, and
  `pass`/`fail`/`needs-review` status.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5 compare report foundation language.
- Commit: completed on `main` as `2233f28 Define phase five compare report
  foundation`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase five source wiki coverage protocol

- Target: continue Phase 5 from the Person B workflow-surface side by defining
  source/wiki coverage and omission semantics for compare reports.
- Changed areas: added the Phase 5.2 plan and source/wiki coverage rule;
  updated the main Phase 5 plan, phase-plan and rule indexes, compare gate
  rule, workspace reports README, compare report template, first-round
  validation note template, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-2-source-wiki-coverage-omission/`.
- Design review: aligned with raw-wiki alignment and artifact economy by
  treating coverage as source disposition, not copying. The default compare
  report now carries coverage, weak coverage, omissions, deferrals, review
  routing, and scope exclusions without creating default report sprawl.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5.2 coverage and omission protocol language.
- Commit: completed on `main` as `c7f6070 Define phase five source wiki
  coverage protocol`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase five claim modality review protocol

- Target: continue Phase 5 from the Person B workflow-surface side by defining
  claim, modality, generated-evidence, unsupported-statement, and
  contradiction review semantics for compare reports.
- Changed areas: added the Phase 5.3 plan and claim/modality/contradiction
  review rule; updated the main Phase 5 plan, phase-plan and rule indexes,
  compare gate rule, workspace compare report template, claim/evidence map
  template, review queue template, first-round validation note template, and
  target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-3-claim-modality-contradiction-review/`.
- Design review: aligned with raw-wiki alignment and anti-self-evaluation by
  requiring important claims to have support, review, or not-in-scope status,
  keeping generated evidence and modality interpretations visible, and routing
  unsupported statements or contradictions to compare findings and review.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5.3 claim/modality/contradiction protocol language.
- Commit: completed on `main` as `8d2958b Define phase five claim modality
  review protocol`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase five review queue workflow

- Target: continue Phase 5 from the Person B workflow-surface side by defining
  review item lifecycle and carried-forward semantics for compare rounds.
- Changed areas: added the Phase 5.4 plan and review queue workflow rule;
  updated the main Phase 5 plan, phase-plan and rule indexes, compare gate
  rule, workspace reports README, compare report template, review queue
  template, first-round validation note template, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-4-review-queue-carry-forward/`.
- Design review: aligned with raw-wiki alignment and anti-self-evaluation by
  making unresolved review state durable across rounds. Blocking,
  nonblocking, resolved, dismissed, stale, carried-forward, and re-entered
  review states now have explicit report surfaces.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5.4 review queue workflow language.
- Commit: completed on `main` as `65fff4a Define phase five review queue
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Define phase five round closure workflow

- Target: continue Phase 5 from the Person B workflow-surface side by defining
  round closure integration across compare status, review state, validation
  notes, index, overview, and wiki log.
- Changed areas: added the Phase 5.5 plan and round closure workflow rule;
  updated the main Phase 5 plan, phase-plan and rule indexes, compare gate
  rule, distillation rounds rule, overview/log rule, workspace reports README,
  compare report template, first-round validation note template, wiki index
  template, wiki overview template, wiki log template, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-5-round-closure-integration/`.
- Design review: aligned with raw-wiki alignment and anti-self-evaluation by
  making closure depend on compare, review, validation, navigation, overview,
  and log state instead of clean-looking wiki prose. The workflow defines
  `close-pass`, `close-with-review`, and `do-not-close`.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5.5 round closure workflow language.
- Commit: completed on `main` as `32aff4f Define phase five round closure
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Close phase five compare gate workflow

- Target: close Phase 5 from the Person B workflow-surface side by reviewing
  the complete compare gates and review workflow and handing Person A/Phase 6
  validation and tooling needs forward.
- Changed areas: added the Phase 5 closure review; updated the main Phase 5
  plan, phase-plan index, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-5-6-closure-review/`.
- Design review: Phase 5 is closed as a protocol and template surface. It
  defines compare reports, source/wiki coverage, claim/modality/contradiction
  checks, review queue lifecycle, and round closure decisions, while leaving
  schemas, validators, fixtures, and tools to Phase 6.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 5 closure and Phase 6 handoff language.
- Commit: completed on `main` as `9e3aad0 Close phase five compare gate
  workflow`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Rebaseline phase six as validation tooling

- Target: rebaseline Phase 6 as workspace validation and checker tooling
  after the no-harness decision.
- Changed areas: added the Phase 6.0 rebaseline plan; updated top-level
  architecture, execution roadmap, phase-plan index, Phase 2 tool surface
  references, collaboration guidance, tool README, source packet convert
  README, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-0-validation-tooling-rebaseline/`.
- Design review: Phase 6 is now checker-first. It validates workspace artifacts
  and source packet outputs, while extractor execution and downstream
  knowledge-to-`skill + tool` generation remain out of scope.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 6.0 rebaseline language.
- Commit: completed on `main` as `0e68250 Rebaseline phase six as validation
  tooling`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Add phase six tool runtime skeleton

- Target: start Phase 6.1 by adding the checker runtime skeleton and shared
  report/exit-code conventions for future workspace validators.
- Changed areas: added the Phase 6.1 plan, shared tool conventions,
  `workspace-check` README and PowerShell skeleton, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-1-tool-runtime-skeleton/`; updated
  the Phase 6 rebaseline plan, phase-plan index, and tools README.
- Design review: Phase 6 now has a runnable checker shell that emits stable
  Markdown reports and marks future business validators as `not-implemented`
  without running extractors or parsing raw binaries.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; `workspace-check.ps1`
  smoke run passed; temporary reports were removed; targeted `rg` confirmed
  Phase 6.1 runtime skeleton language.
- Commit: completed on `main` as `990f384 Add phase six tool runtime
  skeleton`; finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Add phase six schema checker

- Target: implement Phase 6.2 schema and structured-field validation as the
  first real checker in the Phase 6 validation tooling layer.
- Changed areas: added the Phase 6.2 plan and `schema-check` tool; aligned key
  schema fields and enums; integrated schema checking into `workspace-check`;
  updated `validate-kernel`, Phase 6 docs, tool READMEs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-2-schema-structured-field-validation/`.
- Design review: Phase 6.2 checks reusable contract shape and workflow
  vocabulary only. It does not validate full workspace artifact instances or
  run extractors.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; `schema-check.ps1` and
  `workspace-check.ps1 -Mode schemas` smoke runs passed; temporary reports were
  removed; targeted `rg` confirmed Phase 6.2 schema checker language.
- Commit: completed on `main` as `b3e2c37 Add phase six schema checker`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Add phase six source artifact checkers

- Target: implement Phase 6.3 source inventory and source packet output
  validators for workspace artifacts.
- Changed areas: added the Phase 6.3 plan; implemented source inventory and
  source packet lint checkers; integrated `workspace-check -Mode source`;
  updated `validate-kernel`, Phase 6 docs, tool READMEs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-3-source-artifact-checkers/`.
- Design review: Phase 6.3 checks source identity, raw path/hash, packet path,
  metadata, anchors, generated fields, gaps, review routing, and derived
  artifact references without running extractors or generating wiki pages.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; temporary smoke
  workspace passed `source-inventory-check.ps1`, `source-packet-lint.ps1`, and
  `workspace-check.ps1 -Mode source`; targeted `rg` confirmed Phase 6.3 source
  artifact checker language.
- Commit: completed on `main` as
  `30f7cf1 Add phase six source artifact checkers`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Add phase six wiki lint checker

- Target: implement Phase 6.4 wiki lint and navigation validation for existing
  wiki artifacts.
- Changed areas: added the Phase 6.4 plan; implemented `wiki-lint`; integrated
  `workspace-check -Mode wiki`; updated `validate-kernel`, Phase 6 docs, tool
  READMEs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-4-wiki-lint-navigation/`.
- Design review: Phase 6.4 checks special wiki files, frontmatter, links, index
  membership, overview sections, and log headings without generating pages or
  resolving semantic review.
- Validation: temporary smoke workspace passed `wiki-lint.ps1` and
  `workspace-check.ps1 -Mode wiki`; `git diff --check` passed with only
  Windows line-ending warnings; `tools/validate-kernel/validate-kernel.ps1`
  passed; targeted `rg` confirmed Phase 6.4 wiki lint language.
- Commit: completed on `main` as `7541178 Add phase six wiki lint checker`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Add phase six report surface checker

- Target: implement Phase 6.5 report surface validation for compare,
  claim/evidence, review queue, and validation-note reports.
- Changed areas: added the Phase 6.5 plan; implemented `report-check`;
  integrated `workspace-check -Mode reports`; updated `validate-kernel`, Phase
  6 docs, tool READMEs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-5-report-surface-checker/`.
- Design review: Phase 6.5 checks Markdown report structure and obvious status
  consistency without extracting claims, resolving semantic truth, rewriting
  reports, generating wiki pages, or closing rounds.
- Validation: temporary smoke workspace passed `report-check.ps1` and
  `workspace-check.ps1 -Mode reports`; `git diff --check` passed with only
  Windows line-ending warnings; `tools/validate-kernel/validate-kernel.ps1`
  passed; targeted `rg` confirmed Phase 6.5 report checker language.
- Commit: completed on `main` as
  `6151b30 Add phase six report surface checker`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Add phase six round closure checker

- Target: implement Phase 6.6 round closure consistency validation.
- Changed areas: added the Phase 6.6 plan; implemented
  `round-closure-check`; integrated `workspace-check -Mode closure`; updated
  `validate-kernel`, Phase 6 docs, tool READMEs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-6-round-closure-checker/`.
- Design review: Phase 6.6 checks closure decisions against validation note,
  compare/review state, index/log visibility, and active report
  discoverability without closing rounds or resolving semantic truth.
- Validation: temporary smoke workspace passed `round-closure-check.ps1` and
  `workspace-check.ps1 -Mode closure`; `git diff --check` passed with only
  Windows line-ending warnings; `tools/validate-kernel/validate-kernel.ps1`
  passed; targeted `rg` confirmed Phase 6.6 closure checker language.
- Commit: completed on `main` as
  `5878219 Add phase six round closure checker`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Add phase six fixture runner

- Target: implement Phase 6.7 scenario fixture runner and minimum checker
  scenarios.
- Changed areas: added the Phase 6.7 plan; implemented `fixture-runner`; added
  `tests/fixtures/phase6/` pass/fail/needs-review scenarios; integrated
  `workspace-check -Mode fixtures`; updated `validate-kernel`, Phase 6 docs,
  tool READMEs, test docs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-7-fixture-runner/`.
- Design review: Phase 6.7 tests checker status and exit behavior without
  running extractors, generating artifacts, or resolving semantic review.
- Validation: `fixture-runner.ps1` passed; `workspace-check.ps1 -Mode fixtures`
  passed and invoked the fixture runner; generated smoke reports were removed;
  `git diff --check` passed with only Windows line-ending warnings;
  `tools/validate-kernel/validate-kernel.ps1` passed; targeted `rg` confirmed
  Phase 6.7 fixture validation language.
- Commit: completed on `main` as
  `b3962af Add phase six fixture runner`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Close phase six validation tooling

- Target: complete Phase 6 closure review and record the boundary to Phase 7.
- Changed areas: added the Phase 6 closure review; updated the Phase 6 main
  plan, phase-plan index, tool README, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-8-closure-review/`.
- Design review: Phase 6 is closed as validation/checker tooling, not as an
  extractor harness, wiki generator, semantic reviewer, or downstream
  `skill + tool` generator.
- Validation: `git diff --check`, `validate-kernel`, `schema-check`,
  `fixture-runner`, and `workspace-check -Mode fixtures` passed; generated
  smoke reports were removed; targeted `rg` confirmed closure and Phase 7
  boundary language.
- Commit: completed on `main` as
  `12baac7 Close phase six validation tooling`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Migrate phase six tooling to Python CLI

- Target: replace implemented Phase 6 PowerShell checker scripts with the
  Python CLI runtime.
- Changed areas: added `pyproject.toml` and `llm_wiki_tools/`; deleted
  implemented `.ps1` tool scripts; updated tool READMEs, Phase 6 docs, tests
  docs, and target plan under
  `plan/users/chenzc24/2026-06-04-phase-6-9-python-tooling-runtime/`.
- Design review: migration improves portability and maintainability without
  changing Phase 6 into an extractor harness, wiki generator, semantic
  reviewer, or downstream `skill + tool` generator.
- Validation: `git diff --check`, Python compile, `validate-kernel`,
  `schema-check`, `fixture-runner`, and `workspace-check --mode fixtures`
  passed; generated smoke reports were removed; `rg` confirmed no `.ps1` tool
  files remain and active command docs use Python CLI commands.
- Commit: completed on `main` as
  `735a4da Migrate phase six tooling to Python CLI`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Add Person B workflow closure review

- Target: close the Person B workflow-surface question for source packet
  profiles and wiki construction.
- Changed areas: added
  `docs/collaboration/person-b-workflow-closure-review.md`; updated
  `docs/collaboration/README.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-person-b-workflow-closure-review/`.
- Design review: Person B workflow prose is sufficient for Person A to begin
  fixture and validator hardening; extractor harnesses and deterministic wiki
  generation remain out of scope.
- Validation: `git diff --check` passed with only Windows line-ending
  warnings; `python -m llm_wiki_tools validate-kernel` passed; targeted `rg`
  confirmed closure review handoff and boundary language.
- Commit: completed on `main` as
  `c27ee85 Add person B workflow closure review`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Consolidate rules progressive disclosure

- Target: reorganize `rules/` from flat phase-accumulated files into
  progressive-disclosure workflow entrypoints.
- Changed areas: added evidence/claim and wiki-surface owner rules; converted
  historical split rule files into compatibility entries; rewrote the rules
  README; reduced compare-gate duplicate semantic definitions; updated
  workspace-kernel guidance, top-level rules guidance, Python kernel
  validation, and target plan under
  `plan/users/chenzc24/2026-06-04-rules-progressive-disclosure-consolidation/`.
- Design review: rule semantics are kept, but the default reader path is now
  entrypoint-first and module-based. Coverage, review lifecycle,
  claim/modality, evidence/claim, and wiki surface semantics each have one
  owner file.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `python -m llm_wiki_tools validate-kernel` passed; targeted `rg` confirmed
  progressive-disclosure entrypoints, compatibility stubs, new owner files, and
  reduced compare-gate duplicate tables.
- Commit: completed on `main` as
  `e4b6da2 Consolidate rules progressive disclosure`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Add agent skill entrypoints

- Target: add Agent-facing skill entrypoints for end-to-end LLM Wiki
  distillation.
- Changed areas: updated `AGENTS.md`; added four repo-local skills for
  end-to-end distillation, source packet workflow, wiki construction rounds,
  and quality gates; updated Python kernel validation; added the target plan
  under `plan/users/chenzc24/2026-06-04-agent-skill-entrypoints/`.
- Design review: operational workflow entry is now `skills/` plus `rules/`,
  not a new `docs/` runbook. Skills are process routers; rules remain the
  semantic source of truth.
- Validation: skill quick validation passed for all four skills; targeted `rg`
  confirmed skill names, docs/rules/skills boundary language, and no TODO
  placeholders; `git diff --check` passed with only Windows line-ending
  warnings; `python -m llm_wiki_tools validate-kernel` passed.
- Commit: completed on `main` as
  `d8860b7 Add agent skill entrypoints`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Prepare Person A dry-run v2 handoff

- Target: provide Person A with a current-system local dry-run workspace and
  clarify ownership of Python validator/checker implementation.
- Changed areas: added
  `docs/collaboration/person-a-dry-run-v2-review-brief.md`; updated
  collaboration ownership docs; created ignored local dry-run output under
  `workspace/local/adctoolbox-ch1-dry-run-v2/`; added the target plan under
  `plan/users/chenzc24/2026-06-04-person-a-dry-run-v2-handoff/`.
- Design review: the handoff distinguishes Person B workflow/template ownership
  from Person A schema, fixture, and `llm_wiki_tools/**` checker
  implementation ownership.
- Validation: local v2 passed `workspace-check --mode all`; `git diff
  --check`, `python -m llm_wiki_tools validate-kernel`, and targeted `rg`
  passed during final commit validation.
- Commit: completed on `main` as
  `845ce1a Clarify person A validation handoff`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Collapse tool docs into Python package

- Target: remove root-level `tools/` as a standalone documentation directory
  and put the current checker command index beside the runnable Python CLI.
- Changed areas: added `llm_wiki_tools/README.md`; updated
  `llm_wiki_tools/cli.py` kernel validation; removed obsolete root-level
  `tools/**` README/spec files; updated current README, top-level architecture,
  execution-roadmap, collaboration, and Phase 6 closure references.
- Design review: workflow semantics remain in `rules/**`; historical phase
  planning remains in `docs/phase-plans/**`; runnable checker implementation
  and concise command usage now live under `llm_wiki_tools/**`.
- Validation: `python -m py_compile llm_wiki_tools/cli.py
  llm_wiki_tools/__main__.py` passed; `python -m llm_wiki_tools
  validate-kernel` passed; root-level `tools/` no longer exists.
- Commit: completed on `main` as
  `d480ae2 Collapse tool docs into Python package`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Slim duplicate rules prose

- Target: compact the largest rule owner documents after progressive
  disclosure consolidation.
- Changed areas: slimmed the raw-to-source-packet, distillation-round,
  source-packet-to-wiki, wiki-surface, evidence/claim, and compare-gate rules;
  added the target plan under
  `plan/users/chenzc24/2026-06-04-rules-slimming-pass/`.
- Design review: no rule path was removed and no schema or checker behavior was
  changed. Duplicate explanations were collapsed into owner-rule references
  while preserving the workflow-critical fields, statuses, review triggers,
  and acceptance criteria.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `python -m llm_wiki_tools validate-kernel` passed; targeted `rg` confirmed
  required distillation-flow terms; the six edited rule files were reduced by
  424 net lines.
- Commit: completed on `main` as
  `1f0408e Slim duplicate rules prose`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Remove rules compatibility stubs

- Target: remove obsolete compatibility stub files from `rules/` so the
  current rules directory exposes only semantic owner entrypoints.
- Changed areas: deleted six compatibility stubs, updated the rules entry map,
  removed the old `wiki-index-contract` validator requirement, updated current
  Person B collaboration references, and added the target plan under
  `plan/users/chenzc24/2026-06-04-remove-rules-compatibility-stubs/`.
- Design review: this is a navigation cleanup only. Evidence/claim rules and
  wiki surface rules keep their consolidated owner files; historical records
  were not rewritten.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `python -m llm_wiki_tools validate-kernel` passed; targeted `rg` confirmed
  the deleted stub paths are gone from current-facing entrypoints; `Test-Path`
  confirmed all six stub files are absent.
- Commit: completed on `main` as
  `6e4d03a Remove obsolete rule compatibility stubs`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Group rules by workflow area

- Target: make `rules/` structurally match progressive disclosure by grouping
  rule owner files into workflow, source, wiki, claims, and review directories.
- Changed areas: moved the active rule files into grouped subdirectories;
  updated `rules/README.md`, Agent skill references, current docs, and kernel
  validation required paths; added the target plan under
  `plan/users/chenzc24/2026-06-04-rules-directory-restructure/`.
- Design review: this is a navigation and path cleanup, not a semantic change.
  `rules/README.md` remains the first rule entrypoint and now shows the
  directory map before the golden path and semantic ownership map.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `python -m llm_wiki_tools validate-kernel` passed; targeted `rg` confirmed
  current-facing references use grouped rule paths; `rg --files rules`
  confirmed the grouped layout.
- Commit: completed on `main` as
  `a016187 Group rules by workflow area`; finalized by the follow-up
  maintenance-status commit.

## 2026-06-04 - Consolidate workflow runtime into skills

- Target: complete the Stage 1-3 runtime migration from workflow rules into
  skills.
- Changed areas: rewrote the four LLM Wiki skills as runtime cards; added a
  parity review proving coverage against the old `rules/workflow/**` baseline;
  removed `rules/workflow/**`; updated the rules index, current README,
  architecture, collaboration handoff docs, skill metadata, and kernel
  validator required paths; added the target plan under
  `plan/users/chenzc24/2026-06-04-skill-runtime-consolidation-stage-3/`.
- Design review: normal execution now starts from an active skill. Detailed
  rules remain available for source, wiki, claim, and review edge cases, but
  no longer act as the default workflow runtime.
- Validation: `git diff --check` passed with only Windows line-ending
  warnings; `python -m py_compile llm_wiki_tools/cli.py
  llm_wiki_tools/__main__.py` passed; `python -m llm_wiki_tools
  validate-kernel` passed; targeted `rg` confirmed runtime and
  progressive-disclosure language in skills and rules; `rules/workflow`
  references are limited to migration review/historical wording, and the local
  `rules/workflow` directory is absent.
- Commit: completed on `main` as
  `eef4fc6 Consolidate workflow runtime into skills`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Run ADCtoolbox ch2-ch4 PDF distillation test

- Target: test the current workflow on three real ADCtoolbox PDF lecture decks
  in an ignored local workspace.
- Changed areas: generated
  `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/` with copied raw PDFs,
  source inventory, source packets, source/chapter wiki pages, overview, index,
  wiki log, construction analysis, compare report, review queue, validation
  note, and `.checks/` reports; added the target plan under
  `plan/users/chenzc24/2026-06-04-adctoolbox-ch2-ch4-pdf-distill-test/`.
- Design review: the real-PDF dry run exercised the intended path from raw
  source copies to source packets, wiki construction, reports, and closure. The
  output is a first-pass text-based distillation and intentionally carries
  visual/equation review forward as `close-with-review`.
- Validation: `workspace-check --mode all` passed for the generated workspace;
  schema, source inventory, source packet, wiki lint, report, closure, and
  fixture checks passed.
- Commit: completed on `main` as
  `1883a3f Record ADCtoolbox ch2-ch4 distillation test`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Refresh README and archive old concept note

- Target: update the root README as the current Person B-facing system
  entrypoint, archive the old root `llm-wiki.md` concept note, and remove the
  obsolete root workspace divergence note.
- Changed areas: rewrote `README.md`; moved `llm-wiki.md` to
  `docs/archive/llm-wiki.md`; deleted
  `workspace/human-agent-rule-divergence.md`; added the target plan under
  `plan/users/chenzc24/2026-06-04-person-b-readme-archive-cleanup/`.
- Design review: README now reflects Phase 6 completion, skill runtime
  entrypoints, rules as detailed references, `llm_wiki_tools/` as the checker
  CLI, and the system repo as not an active knowledge workspace.
- Validation: `git diff --check` passed with only Windows line-ending warnings;
  `python -m llm_wiki_tools validate-kernel` passed; targeted `rg` confirmed
  current README entrypoint language; file checks confirmed root `llm-wiki.md`
  is absent, archived `docs/archive/llm-wiki.md` exists, and
  `workspace/human-agent-rule-divergence.md` is deleted.
- Commit: completed on `main` as
  `b762b2e Refresh README and archive old concept note`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-04 - Harden wiki coverage gate

- Target: make document/PPT wiki construction closure coverage-aware after the
  ADCtoolbox ch3 dry run exposed overly shallow but structurally valid
  distillation.
- Changed areas: updated the wiki-round and quality-gate runtime skills,
  `rules/wiki/source-wiki-coverage-protocol.md`, report templates, the
  `report-check` checker, and Phase 6 report-check fixtures.
- Design review: skills remain the runtime entrypoint and rules remain the
  detailed semantic reference. The new check is mechanical: compare reports
  must expose source coverage, anchor disposition, and wiki page coverage; it
  still does not pretend to judge semantic truth or generate wiki prose.
- Validation: `git diff --check`, `py_compile`, `validate-kernel`,
  `fixture-runner`, and `workspace-check --mode fixtures` passed. The ignored
  ADCtoolbox ch2-ch4 workspace now fails at report-check because the old
  compare report lacks the required coverage tables.
- Commit: completed on `main` as `c811361 Harden wiki coverage gate`;
  finalized by the follow-up maintenance-status commit.

## 2026-06-04 - Run ADCtoolbox ch2-ch4 hardened redistillation

- Target: test the hardened coverage gate by redistilling the three ADCtoolbox
  PDF decks in a fresh ignored local workspace.
- Changed areas: generated
  `workspace/local/adctoolbox-ch2-ch4-hardened-redistill/` with copied raw
  PDFs, source packets, source/chapter wiki pages, construction analysis,
  compare report, review queue, validation note, and checker reports. Added
  the target plan under
  `plan/users/chenzc24/2026-06-04-adctoolbox-ch2-ch4-hardened-redistill/`.
- Design review: the new workspace demonstrates the intended strengthened
  loop. The compare report now includes source coverage, page-level anchor
  disposition, and wiki page coverage, so the earlier ch3 shallow-summary
  failure mode is no longer invisible.
- Validation: `workspace-check --mode all` passed for the generated workspace;
  schema, source inventory, source packet, wiki lint, report, closure, and
  fixture checks passed.
- Commit: completed on `main` as
  `8c10dba Record ADCtoolbox hardened redistillation`; finalized by the
  follow-up maintenance-status commit.

## 2026-06-05 - Minimal formula derivation coverage hardening

- Target: prevent important formula and derivation loss from being treated only
  as nonblocking modality review.
- Changed areas: updated the wiki-round and quality-gate runtime skills,
  `rules/wiki/source-wiki-coverage-protocol.md`, and existing compare and
  validation templates. Added the target plan under
  `plan/users/chenzc24/2026-06-05-minimal-formula-derivation-coverage-hardening/`.
- Design review: this is intentionally minimal. It adds no new schema, checker,
  or separate formula protocol; it clarifies existing coverage semantics so
  accepted wiki knowledge cannot depend on unreadable formulas or derivations
  while still claiming knowledge coverage pass.
- Validation: `git diff --check`, `validate-kernel`, and `fixture-runner`
  passed.
- Commit: completed on `main` as
  `5fd8ff3 Clarify formula derivation coverage semantics`; finalized by the
  follow-up maintenance-status commit.

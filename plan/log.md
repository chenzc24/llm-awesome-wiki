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
- Commit: pending.

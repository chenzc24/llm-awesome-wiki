# LLM Awesome Wiki

LLM Awesome Wiki is a VSCode-native, Git-first knowledge distillation system
for humans and agents.

It is not an Obsidian vault, not the `llm_wiki` desktop app, and not a
PDF/PPTX extractor harness. The system repository defines the reusable
workflow: skills, rules, templates, schemas, checker tools, fixtures, and
maintenance discipline for creating independent knowledge workspace repos.

## What This System Does

The default workflow is:

```text
raw resources
-> source inventory and source packets
-> semantic draft from source packets plus raw/rendered/external reading
-> grounding pass to source anchors, evidence, and review items
-> accepted source/chapter wiki pages
-> compare, review, lint, and closure reports
-> stable knowledge release
-> later downstream specs, skills, tools, tests, and code
```

Source packets are required, but they are an audit baseline rather than the
semantic ceiling for wiki construction. A wiki round may use direct reading of
raw files, rendered pages, external extractor output, or high-density notes to
draft knowledge, then it must ground accepted knowledge back to stable source
anchors or route uncertainty to review.

Two execution layers stay separate:

- **Knowledge-construction layer**: checks and maintains the wiki workflow
  itself with source inventory, source packet lint, wiki lint, reports, review
  queues, and closure checks.
- **Downstream knowledge-to-code layer**: later `skill + tool` or code
  artifacts derived from a stable, traceable knowledge release.

Do not collapse these into one pass.

## Current Status

The repository has completed the first major system pass:

- Phase 1 defined a copyable workspace kernel.
- Phases 2 through 5 defined source packet, evidence/claim, wiki construction,
  compare, review, and closure protocols.
- Phase 6 implemented the checker-first Python CLI under `llm_wiki_tools/`.
- Runtime workflow entrypoints now live under `skills/`.
- Detailed workflow semantics live under `rules/`.
- Historical plans and design records live under `docs/`.

The old root `llm-wiki.md` concept note has been archived at
`docs/archive/llm-wiki.md`. It is background material, not the current runtime
entrypoint.

Phase 7, downstream knowledge-to-`skill + tool`, is not active until the
knowledge-construction loop is proven on real workspace fixtures.

## Repository Layout

This is the **system repository**, not an active knowledge workspace.

```text
AGENTS.md                  # required rules for agents working in this repo
contracts/                 # reusable machine-readable schema contracts
docs/                      # design records, phase plans, collaboration notes
docs/archive/              # archived concept/background documents
llm_wiki/                  # pinned reference submodule, read-only by default
llm_wiki_tools/            # runnable Python checker CLI and command index
MinerU/                    # pinned optional extractor reference submodule
plan/                      # target plans and maintenance logs
rules/                     # detailed source, wiki, claim, and review rules
skills/                    # runtime agent entrypoints
templates/                 # copyable workspace kernel and artifact templates
tests/                     # fixture and checker validation material
```

A generated knowledge workspace may contain:

```text
raw/sources/               # immutable source files
raw/derived/               # source packets and extracted media
wiki/                      # maintained source/chapter knowledge pages
reports/                   # compare, coverage, lint, review, closure outputs
contracts/                 # copied or referenced schema/config contracts
skills/                    # runtime guides and optional downstream skills
tools/                     # workspace-local helpers if a user chooses to add them
tests/                     # workspace-specific validation and fixtures
```

Do not create live root-level `raw/`, `wiki/`, `reports/`, or `schema.md` in
this system repo. Workspace data belongs in generated workspace repos,
examples, fixtures, or ignored local scratch areas.

## Runtime Entrypoints

For agents:

- Start from `skills/llm-wiki-distill/SKILL.md`.
- Use `skills/llm-wiki-source-packet/SKILL.md` for source packet work.
- Use `skills/llm-wiki-wiki-round/SKILL.md` for wiki construction rounds.
- Use `skills/llm-wiki-quality-gate/SKILL.md` for compare, review, validation,
  and closure.

For detailed semantics:

- Use `rules/README.md` as the rule index.
- Source packet behavior lives under `rules/source/`.
- Wiki construction behavior lives under `rules/wiki/`.
- Evidence and claim behavior lives under `rules/claims/`.
- Review lifecycle behavior lives under `rules/review/`.

For executable checks:

```bash
python -m llm_wiki_tools validate-kernel
python -m llm_wiki_tools workspace-check --workspace . --mode all
```

See `llm_wiki_tools/README.md` for the current command index.

## Key Documents

- `AGENTS.md`: repository working rules for agents.
- `docs/top-level-design/system-architecture-plan.md`: top-level system
  architecture.
- `docs/core-philosophy.md`: core design principles.
- `docs/knowledge-to-executable.md`: construction layer vs downstream
  knowledge-to-code layer.
- `docs/llm_wiki-reference.md`: how the `llm_wiki` submodule is used as
  reference material.
- `docs/phase-plans/phase-6-closure-review.md`: current checker-layer closure
  summary.
- `docs/collaboration/`: Person A / Person B ownership and handoff notes.
- `docs/archive/llm-wiki.md`: archived original concept note.
- `plan/log.md`: merged maintenance history.

## Working Rules

Before modifying the repository:

1. Run `git status --short --branch`.
2. Audit dirty state and ownership.
3. Create a target-specific plan under `plan/users/<user>/<date-goal-slug>/`.
4. Edit only the files owned by that target plan.

After modifying:

1. Update personal and global maintenance logs as required.
2. Run the validation listed in the target plan.
3. Stage only intended files.
4. Commit with a clear message.
5. Push to `origin/main`, unless a different branch or remote is explicitly
   requested.

See `AGENTS.md` for the full rules.

## Relationship To Reference Repos

`llm_wiki/` is a pinned reference submodule. It is useful for studying source
identity, ingest, image handling, frontmatter cleanup, review queues, search,
and graph-derived gap discovery. It is not this repository's runtime or product
target.

`MinerU/` is a pinned optional extractor reference submodule. It may inform how
external extraction backends shape outputs, but this repository does not own a
MinerU runner or a document parsing harness.

Do not edit either submodule unless a target plan explicitly asks to update the
reference pointer or work inside that submodule.

## How Developers Should Join

Start here:

1. Read this README.
2. Read `AGENTS.md`.
3. Read `docs/top-level-design/system-architecture-plan.md`.
4. Check `plan/log.md` for recent decisions.
5. For implementation work, create a new target plan before editing files.

Good current contributions are narrow and evidence-backed:

- improve real workspace fixtures
- improve semantic-draft and grounding templates for real document/PPT corpora
- harden checker behavior in `llm_wiki_tools/`
- clarify rule language where validators expose ambiguity
- improve workspace kernel templates
- document stable knowledge-release criteria

Avoid broad tasks like "build the whole system", "generate all wiki pages", or
"turn Phase 7 on" before the construction loop is proven on real examples.

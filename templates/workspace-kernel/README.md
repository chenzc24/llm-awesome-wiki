# Workspace Skeleton

This directory is the copyable skeleton for a new knowledge workspace
repository. It creates the workspace artifact layout.

It is not the complete kernel bundle by itself. A complete knowledge workspace
kernel also needs vendored or synchronized `skills/`, `rules/`,
`contracts/schemas/`, and checker access from the system repo. See
`KERNEL-MANIFEST.md`.

The default profile is a document/PPT corpus workflow. Preserve source
structure, keep chapter order readable, and make source coverage auditable.
Research-wiki pages such as concepts, entities, comparisons, queries, and broad
synthesis are optional extensions.

Source packets are required audit baselines, not the semantic ceiling. A wiki
round may draft from source packets plus raw/rendered views, external extractor
output, or high-density reading notes. Accepted wiki knowledge must then be
grounded to source anchors, evidence, accepted review, or explicit review
items.

## First Ten Minutes

1. Read `AGENTS.md`.
2. Confirm the kernel bundle state:
   - `skills/` is copied or synchronized
   - `rules/` is copied or synchronized
   - `contracts/schemas/` is copied or pinned
   - checker access is development tool mode or portable tool mode
3. Start runtime work from `skills/llm-wiki-distill/SKILL.md`.
4. Use `rules/README.md` only as the detailed reference index when a skill
   asks for extra rule detail.
5. Edit `purpose.md` so the workspace has a concrete corpus goal.
6. Edit `schema.md` only enough to name expected source, chapter, and report
   conventions.
7. Copy `plan/first-round-plan.template.md` into
   `plan/<date-first-round-slug>/plan.md`.
8. Put original files under `raw/sources/`.
9. Copy `raw/source-inventory.template.md` into a round-specific inventory
   file under `raw/derived/` or `reports/inventory/`.
10. Copy `raw/source-packet.template.md` into
   `raw/derived/<source-id>/source.md` for each processed source.
11. Copy `reports/claim-evidence-map.template.md` into `reports/review/` when
   the round creates important source-backed claims.
12. Copy `reports/wiki-construction-analysis.template.md` into `reports/`
   before creating or updating wiki pages. Use it for semantic drafting and
   grounding.
13. Use the wiki templates to create `wiki/overview.md`, source pages, and
   chapter pages.
14. Copy `reports/first-round-validation-note.template.md` into `reports/` and
   record what was checked.
15. Update `wiki/index.md`, `wiki/log.md`, and `plan/log.md`, then commit.

## Golden Path

```text
configure purpose/schema
-> add raw sources
-> write source inventory
-> write source packet
-> write semantic draft
-> run grounding pass
-> map important claims to evidence
-> route wiki surface updates
-> write construction analysis
-> create overview and index skeleton
-> create source and chapter pages
-> record validation note
-> update logs
-> commit
```

## First Round Boundaries

- Do not write accepted wiki pages directly from raw or rendered sources
  without a grounding pass.
- Do not let lossy source packets suppress important formulas, derivations,
  examples, or tables.
- Do not create or update wiki pages before semantic drafting, routing, and
  construction analysis.
- Do not split a document/PPT corpus into research-style object pages by
  default.
- Do not turn every sentence into a claim record; map only important,
  source-backed claims that affect wiki, review, compare, or downstream use.
- Do not mark compare as passed unless a real compare check exists.
- Record `compare gate not enabled` when compare is deferred.
- Do not generate downstream skills, tools, or executable code in the first
  workspace construction round.

## Where Things Go

```text
skills/            runtime agent entrypoints copied from the system repo
rules/             detailed reference rules copied from the system repo
contracts/schemas/ machine contracts copied or pinned from the system repo
raw/sources/       original source files
raw/derived/       inventories, source packets, extracted media
wiki/sources/      source or deck summary pages
wiki/chapters/     distilled chapter or section pages
reports/           construction analysis, validation notes, claim/evidence
                   maps, lint, coverage, compare, review
plan/              target plans and maintenance log
```

Do not edit system repo rules, skills, templates, schemas, or tool source in
the same commit as live workspace `raw/`, `wiki/`, or `reports/` changes.

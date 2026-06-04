# Workspace Kernel

This directory is a copyable kernel for a new knowledge workspace repository.
Copy its contents into a new repo, open that repo in VSCode, and run the first
manual document/PPT distillation round from inside the workspace.

The default profile is a document/PPT corpus workflow. Preserve source
structure, keep chapter order readable, and make source coverage auditable.
Research-wiki pages such as concepts, entities, comparisons, queries, and broad
synthesis are optional extensions.

## First Ten Minutes

1. Read `AGENTS.md`.
2. If `rules/` has been copied into the workspace, read `rules/README.md` and
   use the default golden path as the first entrypoint.
3. Edit `purpose.md` so the workspace has a concrete corpus goal.
4. Edit `schema.md` only enough to name expected source, chapter, and report
   conventions.
5. Copy `plan/first-round-plan.template.md` into
   `plan/<date-first-round-slug>/plan.md`.
6. Put original files under `raw/sources/`.
7. Copy `raw/source-inventory.template.md` into a round-specific inventory
   file under `raw/derived/` or `reports/inventory/`.
8. Copy `raw/source-packet.template.md` into
   `raw/derived/<source-id>/source.md` for each processed source.
9. Copy `reports/claim-evidence-map.template.md` into `reports/review/` when
   the round creates important source-backed claims.
10. Copy `reports/wiki-construction-analysis.template.md` into `reports/`
   before creating or updating wiki pages.
11. Use the wiki templates to create `wiki/overview.md`, source pages, and
   chapter pages.
12. Copy `reports/first-round-validation-note.template.md` into `reports/` and
   record what was checked.
13. Update `wiki/index.md`, `wiki/log.md`, and `plan/log.md`, then commit.

## Golden Path

```text
configure purpose/schema
-> add raw sources
-> write source inventory
-> write source packet
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

- Do not write final wiki pages directly from binary raw files when a source
  packet is feasible.
- Do not create or update wiki pages before routing and construction analysis.
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
raw/sources/       original source files
raw/derived/       inventories, source packets, extracted media
wiki/sources/      source or deck summary pages
wiki/chapters/     distilled chapter or section pages
reports/           construction analysis, validation notes, claim/evidence
                   maps, lint, coverage, compare, review
plan/              target plans and maintenance log
```

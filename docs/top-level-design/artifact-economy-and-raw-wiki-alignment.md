# Artifact Economy And Raw-Wiki Alignment

This document defines a cross-cutting architecture constraint for every phase
of LLM Awesome Wiki.

The goal is not to make the repository look minimal for its own sake. The goal
is to keep the knowledge base faithful, readable, and maintainable as raw
sources, extracted packets, wiki pages, reports, and future executable artifacts
grow.

## Core Thesis

The primary quality axis is **raw-wiki alignment**:

```text
raw source
-> stable source identity
-> source packet anchors
-> readable wiki references
-> alignment reports
-> review or correction
```

A wiki page is useful only if its important knowledge can be traced back to raw
source material at reasonable cost.

Artifact economy is the discipline that prevents this alignment system from
collapsing under duplicate files, repeated fields, and verbose process records.
Concise structure is a means. Faithful alignment is the end.

## Audience Layers

Every artifact should have one primary audience.

| Layer | Audience | Purpose |
| --- | --- | --- |
| Raw layer | tools, auditors | Preserve immutable source files. |
| Audit layer | tools, agents, reviewers | Record extraction identity, anchors, generated fields, gaps, and coverage. |
| Readable layer | humans, agents | Present distilled knowledge in a form people can read and use. |
| Report layer | reviewers, gates | Record validation results, coverage gaps, blockers, and review queues. |
| Release/spec layer | downstream builders | Provide stable inputs for executable specs, skills, tools, and tests. |

Do not optimize every layer for the same reader. Audit artifacts may be
verbose. Wiki pages should be readable. Logs should be short event records.
Reports should state decisions, blockers, and coverage gaps.

## One Fact, One Source Of Truth

The system should avoid copying the same operational fact across inventory,
metadata, packet prose, wiki pages, reports, and logs.

Default ownership:

| Fact | Source of truth |
| --- | --- |
| Raw path, hash, kind, added date | source inventory or packet metadata |
| Extraction method, version, status | packet metadata |
| Page, slide, section, table, image anchors | source packet anchor records |
| Human-readable knowledge | wiki pages |
| Validation result for a round | report or validation note |
| Commit and workflow event history | plan or wiki logs |
| Unresolved judgment | review queue or review report |

Other files may reference these facts, but should not maintain competing copies
unless the duplication is deliberate and checked.

## Readable Layer Is Protected

The wiki is not the place to dump every extracted field.

Readable wiki pages should:

- preserve source/chapter structure when that is the default workspace profile
- cite source packet anchors for important claims
- avoid repeating hashes, extraction tool details, and full source inventories
- keep source pages short when chapter pages already carry the readable content
- prefer clear prose and compact tables over audit-style bookkeeping

Readable wiki pages should not:

- become a second source packet
- repeat every validation note
- carry every extraction gap unless it affects the reader's understanding
- index every generated audit artifact

## Audit Layer Can Be Verbose, But Should Be Generated

Verbose audit files are acceptable when they improve traceability or validation.
They become dangerous when humans or LLMs must manually maintain duplicated
fields.

Phase 2 tools should therefore generate or update the repetitive parts of:

- source inventory rows
- source packet metadata
- extracted text files
- rendered page or slide references
- coverage reports
- validation summaries

Agents should spend their attention on semantic judgment: what matters, what is
uncertain, and what should be reviewed.

## Raw-Wiki Alignment Reports

Alignment reports are a first-class construction artifact. They answer whether
the readable wiki still corresponds to the raw material.

Minimum report questions:

- Which raw sources have packets?
- Which source packet anchors are cited by wiki pages?
- Which important wiki claims have no source anchor?
- Which extracted modalities were skipped or deferred?
- Did any raw source hash change after wiki pages were written?
- Did any packet gap lead to an overconfident wiki statement?

These reports should be under `reports/alignment/` or another explicitly
configured report path. They should be concise enough to review, while linking
to detailed audit artifacts when needed.

## Workspace Shape Implications

A generated workspace should default to a small readable surface and a separate
audit surface:

```text
raw/
  sources/          # immutable raw files
  derived/          # generated packets, metadata, extracted text, media

wiki/
  index.md          # readable navigation
  overview.md       # concise corpus map
  chapters/         # primary readable knowledge layer
  sources/          # optional, short source notes
  synthesis/        # optional cross-source conclusions

reports/
  alignment/        # raw-wiki alignment checks
  coverage/         # source/anchor/modal coverage
  review/           # unresolved human judgment
  validation/       # short round outcomes
```

This shape may vary by workspace, but the separation should not disappear:
audit artifacts support the readable layer; they should not replace it.

## Phase Implications

- Phase 1 kernel work must not make verbose artifacts look like the default
  reading path.
- Phase 2 raw-resource work must define source identities, anchors, generated
  fields, and gaps so later wiki alignment can be checked.
- Phase 3 claim/evidence work must avoid creating duplicate truth sources for
  the same claim.
- Phase 4 wiki construction must optimize for readable pages with traceable
  anchors.
- Phase 5 compare and review must produce concise alignment and coverage
  reports, not report sprawl.
- Phase 6 tools should automate repetitive audit updates and validation.
- Phase 7 downstream executable artifacts should consume stable readable
  knowledge and specs, not raw audit noise.

## Design Test

Before adding a default artifact, ask:

1. Who is the primary audience?
2. Does this improve raw-wiki alignment?
3. Is it the source of truth for any fact?
4. If it duplicates a fact, how is the duplicate checked or updated?
5. Should a tool generate it instead of an LLM or human maintaining it?
6. Does it make the readable layer clearer or noisier?

If the artifact does not improve alignment, readability, validation, review, or
downstream execution, it should not be part of the default workflow.

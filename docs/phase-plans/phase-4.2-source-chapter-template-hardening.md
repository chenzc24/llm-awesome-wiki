# Phase 4.2 Source And Chapter Template Hardening

Phase 4.2 hardens the source and chapter page templates after Phase 4.1 page
routing.

The goal is to make a copied workspace template concrete enough that an agent
can write readable wiki pages from routed source packet input without turning
the wiki into a second source packet, a claim/evidence table, or a fragmented
research graph.

## Scope

Phase 4.2 owns:

- source page template expectations
- chapter page template expectations
- wiki construction analysis template
- report and schema guidance for where construction analysis belongs
- rule references that require analysis before generation

Phase 4.2 does not implement:

- wiki page generation
- wiki-lint tools
- compare gates
- schemas or validators
- tests or fixtures
- optional research graph page templates
- downstream `skill + tool` artifacts

## Required Flow

```text
source packet
+ claim/evidence map
+ review queue
-> page routing decision
-> wiki construction analysis report
-> source/chapter page update
-> index/log/validation handoff
```

The construction analysis report is the visible bridge between routing and
page generation. It records what the agent inspected, what page should be
created or updated, why that route is correct, and what judgment must remain
in review.

## Source Page Template Goal

Source pages are short notes for one source, deck, document, or source packet.

They should answer:

- what source is this?
- where is the source packet?
- what structure does the source have?
- which chapter pages use it?
- what gaps or review items matter?

They should not:

- repeat full extracted text
- repeat full source packet metadata
- duplicate the anchor index unless a few anchors help navigation
- become a polished copy of `raw/derived/<source-id>/source.md`

## Chapter Page Template Goal

Chapter pages are the main distilled knowledge surface.

They should answer:

- what source packets, page ranges, slide ranges, or sections are in scope?
- what are the key source-backed points?
- which source packet anchors or evidence items support important claims?
- what practical implications matter for later specs, tools, tests, or
  templates?
- what gaps or review decisions remain?

They should not:

- become a table of every evidence and claim item
- hide generated-evidence uncertainty
- mix unrelated chapters only because terms overlap
- replace claim/evidence reports
- start downstream code generation

## Template Design

Templates should be specific enough to guide an agent but not so verbose that
every page becomes process paperwork.

Default source/chapter pages should prefer:

- stable frontmatter
- compact scope sections
- concise source-backed prose
- source references in `<source_id>#<anchor_id>` form
- small tables only where they improve scanning
- explicit gaps and review sections

Default pages should avoid:

- raw hashes and extractor internals unless relevant
- repeated source packet metadata
- long validation logs
- every claim/evidence row
- long philosophical summaries

## Person A Handoff

Person B should not edit `contracts/schemas/**` in Phase 4.2.

Potential validation needs for Person A:

- frontmatter validation for source and chapter page templates
- `sources` entries that can reference source IDs or packet identities
- optional `claim_ids` when important claims are tracked
- source reference validation for `<source_id>#<anchor_id>` strings in tables
  or prose
- report validation for wiki construction analysis outputs

## Acceptance Criteria

Phase 4.2 is complete when:

- source page template is clear, short, and anti-duplication oriented
- chapter page template is source-backed and readable
- construction analysis template exists before page generation
- report and schema guidance mention wiki construction analysis
- rules point agents to construction analysis after routing
- Phase 4.1 routing boundaries remain intact

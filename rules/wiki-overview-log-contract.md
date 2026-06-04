# Wiki Overview And Log Contract

`wiki/overview.md` and `wiki/log.md` are maintenance surfaces for the wiki.

`wiki/overview.md` is the current corpus map. `wiki/log.md` is the
chronological record of wiki-facing work. Neither file is the place for full
source packet content, claim/evidence tables, or validation report detail.

## Overview Role

The overview should help an agent or human understand:

- what the workspace covers
- which source groups matter
- where the main chapter reading path begins
- what coverage is missing
- what high-level review questions remain
- which reports or review queues matter now

It should not be:

- a final synthesis
- a second source packet
- a claim/evidence report
- a full index
- a chronological log

## Overview Refresh Triggers

Refresh `wiki/overview.md` when a round changes:

- corpus purpose, scope, or audience
- major source groups or deck groups
- chapter structure or reading path
- coverage state
- high-level gaps or review themes
- accepted cross-source synthesis direction

Do not refresh it for small typo-only edits unless they affect navigation,
coverage, or accepted knowledge.

## Overview Minimum Sections

Default overview sections:

- Corpus Map
- Important Sources Or Decks
- Chapter Structure
- Current Coverage
- Known Gaps And Review Items

Workspaces may rename sections, but the overview should remain concise and
scannable.

## Log Role

`wiki/log.md` records chronological wiki-facing events.

A useful log entry should include:

- date
- change type
- target
- sources or source packets touched
- construction analysis path when wiki pages changed
- page decisions
- reports or validation notes
- review items created, resolved, or carried forward
- commit and push status when known

The log should not copy full reports, long explanations, source packet text,
or claim/evidence maps.

## Log Update Triggers

Update `wiki/log.md` when a round:

- creates, updates, merges, retitles, or deletes wiki pages
- inspects pages and records `leave-unchanged` decisions
- changes overview or index
- creates or updates reports that gate wiki acceptance
- changes review item status
- carries unresolved review forward

## Round Closure Requirements

Before closing a wiki construction round, record:

- compare report path and status
- closure decision
- overview update status
- index update status
- wiki log entry status
- validation note path
- active reports or review queues linked from index when needed
- carried-forward review items
- next action or next round

If overview or index did not change, record that the round inspected them and
why no update was needed.

Use `round-closure-workflow.md` for closure decisions:

- `close-pass`: index, overview, log, compare, validation, and review state are
  acceptable
- `close-with-review`: unresolved nonblocking review is carried forward with
  reason, owner or next action, and target round or condition
- `do-not-close`: blocking findings, missing validation, stale navigation, or
  unresolved required review prevents closure

## Acceptance Criteria

- overview remains a concise corpus map
- index remains the navigation contract
- log remains chronological and short
- stale navigation or log omissions become validation findings
- reports are linked instead of copied
- closure decisions remain discoverable from the validation note and wiki log

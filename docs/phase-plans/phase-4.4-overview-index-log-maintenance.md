# Phase 4.4 Overview Index Log Maintenance

Phase 4.4 defines how `wiki/overview.md`, `wiki/index.md`, and `wiki/log.md`
stay useful as wiki construction rounds create, update, merge, defer, or leave
pages unchanged.

Phase 4.1 defined page routing. Phase 4.2 hardened source/chapter page
templates. Phase 4.3 defined the round protocol. Phase 4.4 makes sure every
round leaves the workspace navigable.

## Scope

Phase 4.4 owns:

- overview refresh triggers
- index integrity rules
- wiki log entry expectations
- stale entry handling
- navigation and maintenance checks in validation notes
- workspace templates for overview, index, and log

Phase 4.4 does not implement:

- wiki-lint tools
- compare gates
- link checkers
- schema or validator changes
- tests or fixtures
- Obsidian workflows
- downstream `skill + tool` artifacts

## Artifact Roles

| Artifact | Role | Not For |
| --- | --- | --- |
| `wiki/overview.md` | Current corpus map, coverage picture, and high-level reading path. | Final synthesis or claim/evidence report. |
| `wiki/index.md` | Navigation contract for accepted pages and important active reports. | Raw inventory, anchor index, or every claim/evidence row. |
| `wiki/log.md` | Chronological event record for wiki-facing changes. | Knowledge prose, validation report, or detailed review queue. |

These files are maintenance surfaces. They make the wiki usable; they do not
replace source packets, chapter pages, reports, or logs under `plan/`.

## Overview Refresh

Refresh `wiki/overview.md` when a round changes:

- corpus purpose or scope
- major source groups
- chapter structure
- current coverage state
- important gaps or review themes
- accepted optional synthesis direction

Do not refresh overview for tiny typo-only page edits unless the edit changes
navigation, coverage, or accepted knowledge.

## Index Integrity

Update `wiki/index.md` when a round:

- creates an accepted page
- deletes a page
- merges pages
- retitles or moves a page
- changes page type
- creates or closes an important active report that should remain discoverable

Do not index every raw file, source packet anchor, evidence row, claim row, or
validation detail.

## Wiki Log

Update `wiki/log.md` when a round:

- creates, updates, merges, defers, or leaves pages unchanged after inspection
- changes overview or index
- creates or resolves review items
- changes claim/evidence support used by wiki pages
- records validation status for wiki-facing work

Keep log entries short. Link reports instead of copying them.

## Round Closure Checks

A wiki construction round may close only after recording:

- overview update status
- index update status
- wiki log entry
- stale index entry handling
- active report links when needed
- review carry-forward
- validation note path

If no overview update was needed, record why. If no index update was needed,
record that no accepted page navigation changed.

## Person A Handoff

Person B should not edit `contracts/schemas/**` in Phase 4.4.

Potential validation needs for Person A:

- parseable overview frontmatter
- parseable index sections
- index links resolve
- every accepted non-special wiki page has an index entry
- stale index entries are reported
- wiki log headings are parseable
- validation notes reference overview/index/log status

## Acceptance Criteria

Phase 4.4 is complete when:

- overview refresh triggers are documented
- index integrity rules are documented
- wiki log entry expectations are documented
- workspace overview/index/log templates reflect maintenance roles
- validation note template checks overview/index/log status
- source-packet-to-wiki and distillation rounds mention overview/index/log
  closure requirements

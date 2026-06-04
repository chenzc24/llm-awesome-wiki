# Phase 2.6 Tool Surface Specs

Phase 2.6 defines README-level behavior specs for the Phase 2 construction
tool surface.

Phase 2.1 through Phase 2.5 define the raw-to-source-packet workflow. Phase 2.6
translates that workflow into future tool interfaces without implementing the
tools.

This phase is still specification-first. It does not write scripts, implement
CLI commands, run extractors, edit schemas, create fixtures, generate wiki
pages, extract claims, implement compare gates, or start downstream skill/tool
work.

## Position In Phase 2

Phase 2.6 covers the tool surface for:

```text
raw sources
-> source-inventory
-> source-packet-convert
-> source-packet-lint
-> valid source packet handoff
```

These are construction tools for the knowledge workflow. They are not
downstream domain skills or executable knowledge artifacts.

## Tool Surface Principles

Phase 2 tools should:

- run from the workspace repository root
- accept workspace-relative paths
- write explicit reports instead of silently changing semantic artifacts
- distinguish deterministic checks from adapter, model, or human-assisted work
- preserve inventory ownership of `source_id`
- preserve packet ownership of metadata, anchors, generated fields, known gaps,
  review routing, and derived artifacts
- expose failure modes through reports and exit codes

The specs may name future command shapes, but those names are proposals until a
tool implementation task accepts them.

## Source Inventory Tool

`source-inventory` covers Phase 2.1.

Purpose:

```text
raw/sources/
-> source inventory rows
-> source inventory report
```

The tool should scan raw sources, propose or update inventory rows, compute hash
state when possible, detect changed sources, and report intake problems.

It should not parse raw content into packets.

## Source Packet Convert Tool

`source-packet-convert` covers the execution surface for Phase 2.2 through
Phase 2.5.

Purpose:

```text
ready inventory row
-> optional adapter/manual workflow
-> source packet directory
-> conversion report
```

The tool should define how a future command would invoke or coordinate a manual
workflow, Agent/MCP workflow, local CLI backend, MinerU-like backend, or custom
adapter while still leaving the workspace source packet as the durable output.

It should not make the backend the workspace owner. Backend-local outputs must
map to workspace anchors.

## Source Packet Lint Tool

`source-packet-lint` checks source packets after conversion.

Purpose:

```text
source packet directory
-> deterministic packet checks
-> lint report
```

The tool should check packet metadata, anchors, source-type profile
expectations, generated field marking, known gaps, review routing, and visible
failure behavior.

It should not decide final knowledge truth, extract claims, generate wiki
pages, or replace compare gates.

## Exit-Code Convention

Future Phase 2 tools should use the same proposed exit-code convention:

- `0`: pass for the requested mode
- `1`: deterministic failure
- `2`: review required without deterministic failure
- `3`: configuration or runtime error

These values are workflow proposals. Person A may later accept, refine, or
validate them in schema, validator, fixture, or test work.

## Person A Handoff

Workflow needs that Person A may later validate:

- inventory reports distinguish pass, fail, and needs-review
- conversion reports expose adapter/backend, status, generated fields, known
  gaps, and review reasons
- lint reports expose deterministic failures separately from review-required
  items
- tool reports can reference packet anchors as `<source_id>#<anchor_id>`
- exit-code expectations are testable once tools are implemented

Person B should keep these as handoff proposals unless Person A accepts schema,
validator, fixture, or implementation changes.

## Non-Goals

Phase 2.6 should not:

- implement `.ps1`, `.py`, shell, MCP, or CLI commands
- run MinerU, OCR, VLM, MCP, Poppler, LibreOffice, or other extractors
- edit `contracts/schemas/**`
- create tests or fixtures
- generate source packets
- generate wiki pages
- extract claims
- implement compare gates
- start downstream domain `skill + tool` work

## Completion Criteria

Phase 2.6 is complete when:

- `source-inventory` has an aligned README-level behavior spec
- `source-packet-convert` has a README-level behavior spec
- `source-packet-lint` has a README-level behavior spec
- tool specs name inputs, outputs, reports, failure modes, deterministic
  behavior, adapter/model/human-assisted boundaries, and exit-code expectations
- Phase 2 tool specs remain implementation-neutral
- Phase 2 is ready for closure and Person A validation handoff

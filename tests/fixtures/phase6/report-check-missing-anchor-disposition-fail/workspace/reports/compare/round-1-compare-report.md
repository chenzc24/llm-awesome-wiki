# Compare Report

## Round Scope

- Round plan: plan/round-1.md
- Date: 2026-06-04
- Compare report id: cmp-round-1
- Status: pass
- Distillation depth: full-round
- Scope statement: one source packet and one chapter page
- Source packets in scope: raw/derived/source-id/source.md
- Source range in scope: source-id#p001
- Out of scope: none
- Scope exclusion reason: none

## Status Summary

- Decision: pass
- Blocking findings: none
- Needs human review: none
- Knowledge coverage status: pass
- Modality review status: pass
- Carried forward: none
- Closure handoff: close-pass
- Next action: close round

## Input Artifacts

| artifact | path | status | notes |
| --- | --- | --- | --- |
| source inventory | raw/source-inventory.md | present | fixture |
| source packet | raw/derived/source-id/source.md | present | fixture |
| wiki construction analysis | reports/wiki-construction-analysis.md | present | fixture |
| wiki overview | wiki/overview.md | present | fixture |
| wiki index | wiki/index.md | present | fixture |
| wiki log | wiki/log.md | present | fixture |
| validation note | reports/validation/round-1-validation-note.md | present | fixture |

## Check Matrix

| check | category | result | blocking | evidence |
| --- | --- | --- | --- | --- |
| source coverage | manual-protocol | pass | no | source-id#p001 |
| claim coverage | manual-protocol | pass | no | no claims in fixture |
| modality coverage | manual-protocol | pass | no | text only |
| link and index integrity | deterministic | pass | no | wiki/index.md |

## Source Coverage

| source_id | packet_path | source_scope | coverage_unit | wiki_coverage | disposition | reason | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| source-id | raw/derived/source-id/source.md | page 1 | page | wiki/chapters/intro.md | covered | represented in chapter page | pass | fixture |

## Wiki Page Coverage

| wiki_page | page_type | declared_source_scope | actual_source_refs | coverage_gaps | disposition | status_impact | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| wiki/chapters/intro.md | chapter | source-id#p001 | source-id#p001 | none | covered | pass | fixture |

## Decision And Next Actions

- Final status: pass
- May round advance: yes
- Closure decision: close-pass
- Required fixes before advance: none
- Review items to resolve: none
- Review items carried forward: none
- Follow-up round: none

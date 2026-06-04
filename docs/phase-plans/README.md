# Phase Plans

This directory contains phase-level system plans for LLM Awesome Wiki.

Phase plans are important shared plans. They are not personal execution plans
and should not live under `plan/users/<user>/`.

Rules:

- Phase plans are Coordinator-owned by default.
- A co-worker may edit a specific phase-plan file only when their target plan
  explicitly lists that file under `Owned files`.
- Proposals for phase-plan changes should be recorded in personal plans,
  personal logs, review notes, or integration plans before editing shared phase
  documents.
- Phase plans describe stage boundaries, goals, deliverables, acceptance
  criteria, and sequencing. Day-to-day execution plans belong under
  `plan/users/<user>/` or `plan/shared/integration/`.

## Phase 2

- `phase-2-raw-resource-conversion.md`: main Phase 2 raw-to-source-packet
  protocol plan.
- `phase-2-closure-handoff.md`: Phase 2 closure summary and Person A
  validation handoff.

## Phase 3

- `phase-3-evidence-claim-workflow.md`: main Phase 3
  source-packet-to-evidence-and-claim workflow plan.
- `phase-3-closure-review.md`: Phase 3 design review, closure summary, and
  Person A validation handoff.

## Phase 4

- `phase-4-wiki-construction-engine.md`: main Phase 4 wiki construction plan,
  including the active Phase 4.1 page-routing scope.
- `phase-4.2-source-chapter-template-hardening.md`: Phase 4.2 source/chapter
  page template hardening and wiki construction analysis plan.
- `phase-4.3-wiki-construction-round-protocol.md`: Phase 4.3 round protocol
  for selecting inputs, writing construction analysis, generating or merging
  pages, updating index/log, and recording validation.
- `phase-4.4-overview-index-log-maintenance.md`: Phase 4.4 overview, index,
  and wiki log maintenance rules.
- `phase-4-closure-review.md`: Phase 4 closure review, design confirmation,
  and Person A validation handoff.

## Phase 5

- `phase-5-compare-gates-review-workflow.md`: main Phase 5 compare gates and
  review workflow plan.
- `phase-5.1-compare-report-foundation.md`: Phase 5.1 compare report
  foundation, status semantics, and report-template scope.
- `phase-5.2-source-wiki-coverage-omission-protocol.md`: Phase 5.2
  source/wiki coverage, anchor disposition, omission, and scope-exclusion
  protocol.
- `phase-5.3-claim-modality-contradiction-review-protocol.md`: Phase 5.3
  claim support, generated evidence, modality, unsupported statement, and
  contradiction review protocol.
- `phase-5.4-review-queue-carry-forward-workflow.md`: Phase 5.4 review item
  lifecycle, blocking level, resolution, dismissal, stale, and carried-forward
  workflow.
- `phase-5.5-round-closure-integration.md`: Phase 5.5 round closure
  integration across compare status, review state, validation notes, index,
  overview, and wiki log.
- `phase-5-closure-review.md`: Phase 5 closure review, design confirmation,
  and Person A/Phase 6 validation and tooling handoff.

## Phase 6

- `phase-6-validation-tooling-rebaseline.md`: Phase 6.0 rebaseline that
  reframes Phase 6 as workspace validation and checker tooling rather than an
  extractor harness.
- `phase-6.1-tool-runtime-skeleton.md`: Phase 6.1 checker runtime skeleton,
  shared report conventions, exit-code semantics, and `workspace-check`
  smoke-run entrypoint.
- `phase-6.2-schema-structured-field-validation.md`: Phase 6.2 schema and
  structured-field checker for reusable contract files and stable workflow
  enums.
- `phase-6.3-source-artifact-checkers.md`: Phase 6.3 source inventory and
  source packet output checkers for workspace artifacts.
- `phase-6.4-wiki-lint-navigation.md`: Phase 6.4 wiki frontmatter, link,
  index, overview, and log navigation checker.
- `phase-6.5-report-surface-checker.md`: Phase 6.5 compare, claim/evidence,
  review queue, and validation-note report surface checker.
- `phase-6.6-round-closure-checker.md`: Phase 6.6 round closure consistency
  checker across validation notes, compare/review state, index, overview, and
  wiki log.

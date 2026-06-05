# Collaboration

This directory contains collaboration guidance for humans and agents working on
LLM Awesome Wiki.

These documents explain how to split work safely across a small team without
changing the top-level system architecture or phase plans on every task.

Current guides:

- `two-person-pre-skill-tools-worksplit.md`: newcomer-friendly two-person split
  for all major work before downstream skill/tool development.
- `person-a-contracts-validation-by-phase.md`: phase-by-phase assignment for
  the coworker acting as Contracts + Validation Owner.
- `person-b-workflow-surface-by-phase.md`: phase-by-phase assignment for
  `chenzc24` as Workflow + Tool Surface Owner.
- `person-b-workflow-closure-review.md`: closure review confirming that Person
  B source packet profile and wiki construction workflow surfaces are ready for
  Person A fixture and validator hardening.
- `person-a-implementation-closure-review.md`: closure review confirming that
  Person A contracts, checkers, and representative fixtures are complete as the
  current validation substrate before Phase 7.
- `skill-runtime-vs-workflow-rules-review.md`: parity review confirming that
  workflow runtime moved from `rules/workflow/**` into `skills/**`, with old
  workflow-rule entrypoints removed after review.
- `person-a-dry-run-v2-review-brief.md`: handoff brief for the local
  `adctoolbox-ch1-dry-run-v2` workspace that Person A can use to derive
  fixtures and checker expectations.

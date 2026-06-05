# Top-Level Design

This directory contains designer-maintained top-level design plans for the new
LLM Awesome Wiki system. These documents are not execution logs and should not
change during every task. They define stable architecture decisions, subsystem
boundaries, build phases, validation gates, and rules for deriving concrete
execution plans.

## Maintenance Role

- Maintain this directory only when system-level architecture, phase boundaries,
  directory contracts, or quality gates change.
- Derive ordinary execution work from these documents into
  `plan/users/<user>/<date-goal-slug>/plan.md` for individual work, or
  `plan/shared/integration/<date-goal-slug>/plan.md` for shared integration.
- Do not place one-off task details in this directory.
- Every derived execution plan should name the relevant system phase, expected
  files, validation steps, and commit intent.
- `llm_wiki/` may be studied as a reference implementation, but it is not the
  foundation or runtime of this system.
- Design documents in this directory should be written in English.

## Current Design Documents

- `system-architecture-plan.md`: top-level system construction plan for LLM
  Awesome Wiki, including architecture layers, staged build phases,
  source packet protocol and raw-wiki alignment as the Phase 2 substrate, LLM
  responsibility boundaries, quality gates, protocol/contract/template
  vocabulary, and the limited reference role of `llm_wiki`.
- `workspace-topology-contract.md`: structural contract for how the system repo,
  workspace skeleton, workspace kernel bundle, and independent knowledge
  workspace repos relate to each other.
- `artifact-economy-and-raw-wiki-alignment.md`: cross-cutting design principle
  for keeping agent-readable, human-reviewable wiki output aligned with raw
  sources without creating duplicate truth sources or verbose default
  artifacts.

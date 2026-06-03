# Schema Contracts

The schemas in this directory define minimum shapes for Phase 1 and Phase 1.1
workspace artifacts. They intentionally stay small: future phases can add
stricter validation once real tools and fixtures exist.

These schemas are not a raw conversion implementation, compare gate engine, or
wiki generator. They only provide enough shared structure for rules, templates,
reports, and future tools to speak the same language.

Use these schemas for:

- validating generated reports
- checking source inventory and packet metadata
- stabilizing claim, evidence, and review item records
- keeping wiki index metadata machine-readable when a workspace chooses to
  emit structured index data

Phase 2 tools may copy, extend, or version these contracts, but should not
silently change their meaning inside existing workspaces.

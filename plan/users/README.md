# User Plan Namespaces

This directory contains personal planning namespaces for individual co-workers.
User directories represent human/co-worker ownership, not executor agents.

Use:

```text
plan/users/<user>/<date-goal-slug>/plan.md
plan/users/<user>/log.md
```

Rules:

- Each co-worker owns their own user directory.
- Agent names such as `codex` are not user namespaces. If an agent acts on
  behalf of a human owner, use the human owner's namespace.
- Personal task plans must declare `Owned files` and `Read-only files`.
- Personal logs record individual task outcomes, validation, unresolved issues,
  and commit references.
- The global `plan/log.md` is reserved for merged or integration-level history.

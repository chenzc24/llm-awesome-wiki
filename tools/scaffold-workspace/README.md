# Scaffold Workspace Tool

Future tool family for initializing or updating a knowledge workspace from the
copyable workspace kernel.

Planned command shape:

```text
init <target-path>
sync <target-path>
diff <target-path>
```

Phase 1 is copy-first and does not implement these commands. A developer may
manually copy `templates/workspace-kernel/` into a new workspace repository.

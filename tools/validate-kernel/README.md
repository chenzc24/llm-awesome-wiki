# Validate Kernel

`validate-kernel` checks that the system repository still looks like a
workspace-kernel producer rather than an active knowledge workspace.

Run from the repository root:

```bash
python -m llm_wiki_tools validate-kernel
```

The validator checks:

- required Phase 1 rules, contracts, templates, tools, and tests exist
- root-level active workspace outputs do not exist
- JSON Schema files parse as JSON
- workspace artifact directories appear only inside the template
- no legacy script implementation remains under `tools/`

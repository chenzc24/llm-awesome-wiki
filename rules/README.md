# Rules

This directory contains operational contracts for generated knowledge
workspaces. These are not top-level philosophy documents. They are the rules an
agent follows inside a workspace repo when moving from raw source material to
source packets, wiki pages, reports, and maintenance logs.

The rules are designed for VSCode, Git, CLI tools, and repo-local agents. They
may use Markdown conventions that also work in Obsidian, but Obsidian is not a
required dependency.

## Rule Files

- `raw-to-source-packet.md`: convert raw material into auditable source packets.
- `extractor-adapter-protocol.md`: connect optional human, agent, MCP, local
  CLI, or extractor backends to the source packet protocol without making them
  workspace owners.
- `source-type-packet-profiles.md`: define minimum source packet expectations
  for PDF, PPTX, DOCX, image, table/dataset, and mixed media sources.
- `generated-fields-review-routing.md`: mark generated or model-assisted
  packet content and route important uncertainty to review before claim/wiki
  handoff.
- `source-packet-to-wiki.md`: distill source packets into maintained wiki
  pages.
- `wiki-index-contract.md`: maintain `wiki/index.md` as the navigation entry.
- `compare-gate-contract.md`: compare source coverage and claim coverage before
  advancing a distillation round.
- `distillation-rounds.md`: run wiki construction in small reviewable rounds.
- `maintenance-workflow.md`: keep workspace plans, logs, commits, and reports
  disciplined, including per-user plan namespaces and personal logs for
  multi-agent work.

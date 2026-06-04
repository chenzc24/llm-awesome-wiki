# Phase 6 Report Conventions

Phase 6 tools are checker tools. They validate workspace artifacts and emit
reports. They do not run extractors, parse raw binary documents as their main
job, generate wiki pages, or resolve semantic review.

## Exit Codes

Use these exit codes:

| exit_code | meaning |
| --- | --- |
| `0` | requested checks passed or a skeleton smoke run completed |
| `1` | deterministic validation failure |
| `2` | review required without deterministic failure |
| `3` | configuration or runtime error |

Exit codes must describe checker results. They must not describe extractor
backend success.

## Status Values

Use these checker statuses:

- `pass`
- `fail`
- `needs-review`
- `not-implemented`
- `error`

`not-implemented` is allowed for Phase 6 skeletons. It must not be converted to
`pass` for a real validation target.

## Minimum Report Sections

Every checker report should include:

- tool name
- tool phase or version
- workspace path
- mode
- started timestamp
- status
- exit code
- checks run
- checks not implemented
- findings
- next actions

## Report Rules

- Use workspace-relative paths when possible.
- Do not include raw source content.
- Do not rewrite wiki pages from a report.
- Do not resolve semantic review from a checker.
- Record missing deterministic support as `not-implemented`, `fail`, or
  `needs-review` according to scope.

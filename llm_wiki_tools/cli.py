from __future__ import annotations

import argparse
import datetime as _dt
import hashlib
import json
import os
import re
import shutil
import sys
import tempfile
import uuid
from pathlib import Path
from typing import Any, Callable


STATUSES = {"pass", "fail", "needs-review", "not-implemented", "error"}
EXIT_PASS = 0
EXIT_FAIL = 1
EXIT_REVIEW = 2
EXIT_ERROR = 3


def utc_now() -> str:
    return _dt.datetime.now(_dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def list_text(items: list[str]) -> str:
    if not items:
        return "- none"
    return "\n".join(f"- {item}" for item in items)


def resolve_report_path(path: str) -> Path:
    report = Path(path)
    if not report.is_absolute():
        report = Path.cwd() / report
    report.parent.mkdir(parents=True, exist_ok=True)
    return report


def write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def workspace_file(workspace: Path, relative_path: str) -> Path:
    return workspace / relative_path.replace("/", os.sep)


def workspace_relative(workspace: Path, path: Path) -> str:
    try:
        return path.resolve().relative_to(workspace.resolve()).as_posix()
    except ValueError:
        return str(path)


def test_workspace_relative_path(value: str, required_prefix: str = "") -> bool:
    if not value or value.strip() == "":
        return False
    path = value.strip()
    if Path(path).is_absolute() or "\\" in path:
        return False
    if ".." in path.split("/"):
        return False
    if required_prefix:
        return path == required_prefix or path.startswith(required_prefix + "/")
    return True


def test_safe_relative_path(value: str) -> bool:
    return test_workspace_relative_path(value, "")


def is_sha256(value: str) -> bool:
    return bool(re.fullmatch(r"[A-Fa-f0-9]{64}", value or ""))


def file_sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def review_flag(value: Any) -> bool | None:
    if isinstance(value, bool):
        return value
    text = str(value if value is not None else "").strip().lower()
    if text in {"yes", "true", "1"}:
        return True
    if text in {"no", "false", "0", ""}:
        return False
    return None


def to_list(value: Any) -> list[str]:
    if value is None:
        return []
    if isinstance(value, list):
        return [str(v).strip() for v in value if str(v).strip()]
    if isinstance(value, tuple):
        return [str(v).strip() for v in value if str(v).strip()]
    text = str(value).strip()
    if text in {"", "[]"}:
        return []
    if text.startswith("[") and text.endswith("]"):
        inner = text[1:-1].strip()
        if not inner:
            return []
        return [part.strip().strip("'\"") for part in inner.split(",") if part.strip().strip("'\"")]
    return [text]


def empty_value(value: Any) -> bool:
    if value is None:
        return True
    if isinstance(value, (list, tuple)):
        return len(value) == 0
    return str(value).strip() in {"", "[]", "replace-me"}


def split_markdown_row(line: str) -> list[str]:
    text = line.strip()
    if text.startswith("|"):
        text = text[1:]
    if text.endswith("|"):
        text = text[:-1]
    return [cell.strip() for cell in text.split("|")]


def is_markdown_separator(line: str) -> bool:
    if not line.strip().startswith("|"):
        return False
    cells = split_markdown_row(line)
    return bool(cells) and all(re.fullmatch(r":?-{3,}:?", cell) for cell in cells)


def read_markdown_tables(lines: list[str], lower_headers: bool = False) -> list[dict[str, Any]]:
    tables: list[dict[str, Any]] = []
    i = 0
    while i < len(lines) - 1:
        if lines[i].strip().startswith("|") and is_markdown_separator(lines[i + 1]):
            headers = split_markdown_row(lines[i])
            if lower_headers:
                headers = [h.lower() for h in headers]
            rows: list[dict[str, Any]] = []
            j = i + 2
            while j < len(lines) and lines[j].strip().startswith("|"):
                cells = split_markdown_row(lines[j])
                row: dict[str, Any] = {"line_number": j + 1}
                for k, header in enumerate(headers):
                    row[header] = cells[k] if k < len(cells) else ""
                rows.append(row)
                j += 1
            tables.append({"headers": headers, "rows": rows})
            i = j
            continue
        i += 1
    return tables


def read_first_markdown_table(path: Path) -> dict[str, Any]:
    tables = read_markdown_tables(path.read_text(encoding="utf-8").splitlines())
    if tables:
        return tables[0]
    return {"headers": [], "rows": []}


def parse_simple_yaml(lines: list[str]) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for line in lines:
        trimmed = line.strip()
        if not trimmed or trimmed.startswith("#"):
            continue
        match = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", trimmed)
        if not match:
            continue
        key, value = match.group(1), match.group(2).strip()
        if (value.startswith("'") and value.endswith("'")) or (
            value.startswith('"') and value.endswith('"')
        ):
            value = value[1:-1]
        if value.startswith("[") and value.endswith("]"):
            result[key] = to_list(value)
        elif value.lower() in {"true", "false"}:
            result[key] = value.lower() == "true"
        else:
            result[key] = value
    return result


def read_frontmatter(path: Path) -> dict[str, Any] | None:
    lines = path.read_text(encoding="utf-8").splitlines()
    if len(lines) < 3 or lines[0].strip() != "---":
        return None
    frontmatter: list[str] = []
    for line in lines[1:]:
        if line.strip() == "---":
            return parse_simple_yaml(frontmatter)
        frontmatter.append(line)
    return None


def map_contains(mapping: Any, name: str) -> bool:
    return isinstance(mapping, dict) and name in mapping


def map_value(mapping: Any, name: str) -> Any:
    if not isinstance(mapping, dict):
        return None
    return mapping.get(name)


def normalize_enum(value: str) -> str:
    return str(value or "").strip().strip("`").strip().lower()


def placeholder_value(value: str) -> bool:
    text = str(value or "").strip().lower()
    return text == "" or bool(re.search(r"replace this row|replace-me|pass/fail|yes/no|open/in-review", text))


def closure_placeholder(value: str) -> bool:
    text = str(value or "").strip().lower()
    return text == "" or bool(re.search(r"replace|yes/no|`,| or ", text))


def get_field_value(content: str, field_name: str) -> str:
    match = re.search(rf"(?im)^-\s*{re.escape(field_name)}\s*:\s*(.+?)\s*$", content)
    if not match:
        return ""
    return match.group(1).strip()


def has_section(content: str, section: str) -> bool:
    return bool(re.search(rf"(?im)^##\s+{re.escape(section)}\s*$", content))


def require_sections(label: str, content: str, sections: list[str], failures: list[str]) -> None:
    for section in sections:
        if not has_section(content, section):
            failures.append(f"{label}: missing section '{section}'.")


def find_table(tables: list[dict[str, Any]], required_headers: list[str]) -> dict[str, Any] | None:
    for table in tables:
        if all(header in table["headers"] for header in required_headers):
            return table
    return None


def get_cell(row: dict[str, Any], name: str) -> str:
    return str(row.get(name, "") or "")


def report_status(path: Path) -> str:
    if not path.exists():
        return ""
    match = re.search(r"(?im)^-\s*Status\s*:\s*(.+?)\s*$", path.read_text(encoding="utf-8"))
    return match.group(1).strip().lower() if match else ""


def finish_status(failures: list[str], review_findings: list[str]) -> tuple[str, int]:
    if failures:
        return "fail", EXIT_FAIL
    if review_findings:
        return "needs-review", EXIT_REVIEW
    return "pass", EXIT_PASS


def resolve_workspace(path: str, failures: list[str]) -> Path:
    workspace = Path(path)
    try:
        return workspace.resolve(strict=True)
    except FileNotFoundError:
        failures.append(f"Workspace path does not exist: {path}")
        return workspace


def json_path(obj: Any, path: str) -> Any:
    current = obj
    for segment in path.split("."):
        if not isinstance(current, dict) or segment not in current:
            return None
        current = current[segment]
    return current


def cmd_validate_kernel(args: argparse.Namespace) -> int:
    root = Path(args.root).resolve()
    failures: list[str] = []

    required_paths = [
        "README.md",
        "AGENTS.md",
        "pyproject.toml",
        "llm_wiki_tools/__init__.py",
        "llm_wiki_tools/__main__.py",
        "llm_wiki_tools/cli.py",
        "docs/top-level-design/system-architecture-plan.md",
        "docs/phase-plans/phase-1-workspace-kernel.md",
        "docs/phase-plans/phase-1.1-workspace-kernel-closure.md",
        "docs/phase-plans/phase-1.2-document-corpus-default.md",
        "docs/phase-plans/phase-1.3-workspace-kernel-golden-path.md",
        "docs/phase-plans/phase-6-closure-review.md",
        "rules/README.md",
        "rules/raw-to-source-packet.md",
        "rules/source-packet-to-wiki.md",
        "rules/evidence-claim-workflow.md",
        "rules/wiki-surface-workflow.md",
        "rules/wiki-index-contract.md",
        "rules/compare-gate-contract.md",
        "rules/distillation-rounds.md",
        "rules/maintenance-workflow.md",
        "contracts/schemas/source-inventory.schema.json",
        "contracts/schemas/source-packet.schema.json",
        "contracts/schemas/evidence-record.schema.json",
        "contracts/schemas/claim-record.schema.json",
        "contracts/schemas/wiki-page.schema.json",
        "contracts/schemas/wiki-index.schema.json",
        "contracts/schemas/compare-report.schema.json",
        "contracts/schemas/review-item.schema.json",
        "templates/workspace-kernel/AGENTS.md",
        "templates/workspace-kernel/README.md",
        "templates/workspace-kernel/purpose.md",
        "templates/workspace-kernel/schema.md",
        "templates/workspace-kernel/plan/README.md",
        "templates/workspace-kernel/plan/log.md",
        "templates/workspace-kernel/plan/first-round-plan.template.md",
        "templates/workspace-kernel/raw/README.md",
        "templates/workspace-kernel/raw/source-inventory.template.md",
        "templates/workspace-kernel/raw/source-packet.template.md",
        "templates/workspace-kernel/raw/sources",
        "templates/workspace-kernel/raw/sources/README.md",
        "templates/workspace-kernel/raw/derived",
        "templates/workspace-kernel/raw/derived/README.md",
        "templates/workspace-kernel/wiki/index.md",
        "templates/workspace-kernel/wiki/overview.md",
        "templates/workspace-kernel/wiki/overview.template.md",
        "templates/workspace-kernel/wiki/log.md",
        "templates/workspace-kernel/wiki/sources/README.md",
        "templates/workspace-kernel/wiki/sources/source-page.template.md",
        "templates/workspace-kernel/wiki/chapters/README.md",
        "templates/workspace-kernel/wiki/chapters/chapter-page.template.md",
        "templates/workspace-kernel/reports",
        "templates/workspace-kernel/reports/README.md",
        "templates/workspace-kernel/reports/first-round-validation-note.template.md",
        "templates/workspace-kernel/tools/README.md",
        "templates/workspace-kernel/contracts/README.md",
        "tools/validate-kernel/README.md",
        "tools/shared/README.md",
        "tools/shared/report-conventions.md",
        "tools/workspace-check/README.md",
        "tools/schema-check/README.md",
        "tools/source-inventory/README.md",
        "tools/source-packet-lint/README.md",
        "tools/wiki-lint/README.md",
        "tools/report-check/README.md",
        "tools/round-closure-check/README.md",
        "tools/fixture-runner/README.md",
        "tools/compare-gate/README.md",
        "tools/claim-audit/README.md",
        "tools/scaffold-workspace/README.md",
        "tests/README.md",
        "tests/fixtures/README.md",
    ]

    for relative in required_paths:
        if not (root / relative).exists():
            failures.append(f"Missing required path: {relative}")

    for root_only in ["raw", "wiki", "reports", "schema.md", "schemas"]:
        if (root / root_only).exists():
            failures.append(f"Root repository must not contain active workspace path: {root_only}")

    ps1_files = [p for p in (root / "tools").rglob("*.ps1") if p.is_file()]
    for ps1 in ps1_files:
        failures.append(f"PowerShell tool implementation is no longer allowed: {workspace_relative(root, ps1)}")

    schema_dir = root / "contracts" / "schemas"
    if schema_dir.exists():
        schema_files = list(schema_dir.glob("*.schema.json"))
        if len(schema_files) < 8:
            failures.append("Expected at least 8 schema files under contracts/schemas.")
        for schema_file in schema_files:
            try:
                json.loads(schema_file.read_text(encoding="utf-8"))
            except json.JSONDecodeError:
                failures.append(f"Invalid JSON schema: {schema_file}")

    if failures:
        for failure in failures:
            print(f"validate-kernel: {failure}", file=sys.stderr)
        return EXIT_FAIL
    print("validate-kernel: OK")
    return EXIT_PASS


def cmd_schema_check(args: argparse.Namespace) -> int:
    tool_name = "schema-check"
    tool_phase = "Phase 6.2 schema and structured-field validation"
    started = utc_now()
    checked: list[str] = []
    failures: list[str] = []
    next_actions: list[str] = []
    schemas: dict[str, Any] = {}

    workspace = resolve_workspace(args.workspace, failures)
    schema_path = workspace_file(workspace, args.schema_dir)
    required_schema_files = [
        "source-inventory.schema.json",
        "source-packet.schema.json",
        "evidence-record.schema.json",
        "claim-record.schema.json",
        "wiki-page.schema.json",
        "wiki-index.schema.json",
        "compare-report.schema.json",
        "review-item.schema.json",
    ]

    def require_json_path(schema: Any, schema_name: str, path: str) -> None:
        if json_path(schema, path) is None:
            failures.append(f"{schema_name} missing required JSON path: {path}")

    def require_enum_values(schema: Any, schema_name: str, path: str, expected: list[str]) -> None:
        enum_values = json_path(schema, path)
        if enum_values is None:
            failures.append(f"{schema_name} missing enum path: {path}")
            return
        for value in expected:
            if value not in enum_values:
                failures.append(f"{schema_name} enum {path} missing value: {value}")

    def require_object_properties(schema: Any, schema_name: str, path: str, properties: list[str]) -> None:
        found = json_path(schema, path)
        if not isinstance(found, dict):
            failures.append(f"{schema_name} missing properties path: {path}")
            return
        for name in properties:
            if name not in found:
                failures.append(f"{schema_name} missing property {name} at {path}")

    if not failures:
        if not schema_path.exists():
            failures.append(f"Missing schema directory: {args.schema_dir}")
        else:
            for file_name in required_schema_files:
                file_path = schema_path / file_name
                if not file_path.exists():
                    failures.append(f"Missing required schema file: {file_name}")
                    continue
                try:
                    schema = json.loads(file_path.read_text(encoding="utf-8"))
                except json.JSONDecodeError:
                    failures.append(f"Invalid JSON schema file: {file_name}")
                    continue
                schemas[file_name] = schema
                checked.append(file_name)
                for metadata_path in ["$schema", "$id", "title", "type", "properties"]:
                    require_json_path(schema, file_name, metadata_path)

    if "source-inventory.schema.json" in schemas:
        schema = schemas["source-inventory.schema.json"]
        require_object_properties(
            schema,
            "source-inventory.schema.json",
            "properties.sources.items.properties",
            ["source_id", "raw_path", "source_kind", "raw_sha256", "status", "packet_path", "review_required", "notes"],
        )
        require_enum_values(
            schema,
            "source-inventory.schema.json",
            "properties.sources.items.properties.status.enum",
            ["new", "ready", "processed", "changed", "ignored", "failed", "needs-review"],
        )

    if "source-packet.schema.json" in schemas:
        schema = schemas["source-packet.schema.json"]
        require_object_properties(
            schema,
            "source-packet.schema.json",
            "properties",
            [
                "source_id",
                "raw_path",
                "raw_sha256",
                "source_kind",
                "inventory_status_at_extraction",
                "extraction_backend",
                "extraction_method",
                "extraction_version",
                "extraction_status",
                "modalities",
                "generated_fields",
                "known_gaps",
                "review_required",
                "review_reason",
                "derived_artifacts",
                "anchors",
            ],
        )
        require_enum_values(
            schema,
            "source-packet.schema.json",
            "properties.extraction_status.enum",
            ["complete", "partial", "failed", "manual-review"],
        )

    if "claim-record.schema.json" in schemas:
        require_enum_values(
            schemas["claim-record.schema.json"],
            "claim-record.schema.json",
            "properties.status.enum",
            [
                "supported",
                "weak",
                "unsupported",
                "contested",
                "generated-derived",
                "reviewed-generated",
                "needs-review",
                "not-in-scope",
                "stale",
            ],
        )

    if "compare-report.schema.json" in schemas:
        schema = schemas["compare-report.schema.json"]
        require_enum_values(schema, "compare-report.schema.json", "properties.status.enum", ["pass", "fail", "needs-review"])
        require_enum_values(
            schema,
            "compare-report.schema.json",
            "properties.checks.items.properties.status.enum",
            ["pass", "fail", "needs-review", "not-enabled"],
        )

    if "review-item.schema.json" in schemas:
        schema = schemas["review-item.schema.json"]
        require_enum_values(
            schema,
            "review-item.schema.json",
            "properties.status.enum",
            ["open", "in-review", "resolved", "dismissed", "carried-forward", "blocked", "stale"],
        )
        require_enum_values(
            schema,
            "review-item.schema.json",
            "properties.blocking_level.enum",
            ["blocking", "nonblocking", "informational"],
        )

    status, exit_code = ("fail", EXIT_FAIL) if failures else ("pass", EXIT_PASS)
    if failures:
        next_actions.append("Fix schema structure or enum mismatches and rerun schema-check.")
    else:
        next_actions.append("Proceed to Phase 6.3 source inventory and source packet checks.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Schema Check Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Schema directory: {args.schema_dir}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}

## Schema Files Checked

{list_text(checked)}

## Findings

{list_text(failures)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Not a JSON Schema engine.
- Does not validate workspace instances.
- Does not run extractors.
- Does not parse raw binary documents.
- Does not generate source packets or wiki pages.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def cmd_source_inventory_check(args: argparse.Namespace) -> int:
    tool_name = "source-inventory-check"
    tool_phase = "Phase 6.3 source inventory validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    valid_statuses = {"new", "ready", "processed", "changed", "ignored", "failed", "needs-review"}
    valid_hash_states = {"pending", "not-hashable", "manifest"}
    required_columns = [
        "source_id",
        "raw_path",
        "source_kind",
        "raw_sha256",
        "added_at",
        "status",
        "packet_path",
        "review_required",
        "notes",
    ]

    workspace = resolve_workspace(args.workspace, failures)
    if not failures:
        checks_run.append("workspace path exists")

    inventory_path: Path | None = None
    if not failures:
        inventory_path = Path(args.inventory) if Path(args.inventory).is_absolute() else workspace_file(workspace, args.inventory)
        if not inventory_path.exists():
            template_inventory = workspace_file(workspace, "raw/source-inventory.template.md")
            if args.inventory == "raw/source-inventory.md" and template_inventory.exists():
                inventory_path = template_inventory
                review_findings.append("Using template inventory because raw/source-inventory.md was not found: raw/source-inventory.template.md")
            else:
                failures.append(f"Inventory file does not exist: {args.inventory}")

    rows_checked = 0
    if not failures and inventory_path is not None:
        checks_run.append("inventory file exists")
        table = read_first_markdown_table(inventory_path)
        if not table["headers"]:
            failures.append("Inventory file does not contain a Markdown table.")
        else:
            checks_run.append("inventory Markdown table parsed")
            for required in required_columns:
                if required not in table["headers"]:
                    failures.append(f"Inventory table is missing required column: {required}")
            seen_ids: dict[str, int] = {}
            for row in table["rows"]:
                rows_checked += 1
                line = int(row.get("line_number", 0))
                source_id = get_cell(row, "source_id").strip()
                raw_path = get_cell(row, "raw_path").strip()
                source_kind = get_cell(row, "source_kind").strip()
                raw_hash = get_cell(row, "raw_sha256").strip()
                status = get_cell(row, "status").strip()
                packet_path = get_cell(row, "packet_path").strip()
                review_value = get_cell(row, "review_required").strip()
                notes = get_cell(row, "notes").strip()
                label = source_id or f"line {line}"

                if not source_id:
                    failures.append(f"Inventory row {line} has blank source_id.")
                elif source_id in seen_ids:
                    failures.append(f"Duplicate source_id '{source_id}' on line {line}; first seen on line {seen_ids[source_id]}.")
                else:
                    seen_ids[source_id] = line

                if re.search(r"\s|/|\\", source_id) or source_id != source_id.lower():
                    review_findings.append(f"{label}: source_id should be stable, workspace-relative, and preferably lowercase ASCII.")

                if not test_workspace_relative_path(raw_path, "raw/sources"):
                    failures.append(f"{label}: raw_path must be workspace-relative under raw/sources/: {raw_path}")
                else:
                    raw_file_path = workspace_file(workspace, raw_path)
                    if status != "ignored" and not raw_file_path.exists():
                        failures.append(f"{label}: raw_path does not exist: {raw_path}")

                if not source_kind:
                    failures.append(f"{label}: source_kind is blank.")
                if status not in valid_statuses:
                    failures.append(f"{label}: unknown status '{status}'.")

                flag = review_flag(review_value)
                if flag is None:
                    failures.append(f"{label}: review_required must be yes/no/true/false, got '{review_value}'.")

                if not raw_hash:
                    review_findings.append(f"{label}: raw_sha256 is blank.")
                elif not is_sha256(raw_hash) and raw_hash not in valid_hash_states:
                    failures.append(f"{label}: raw_sha256 must be SHA-256 or one of pending/not-hashable/manifest, got '{raw_hash}'.")
                elif raw_hash == "pending" and status in {"ready", "processed"}:
                    review_findings.append(f"{label}: status '{status}' still has raw_sha256 pending.")

                if is_sha256(raw_hash) and test_workspace_relative_path(raw_path, "raw/sources"):
                    raw_file_path = workspace_file(workspace, raw_path)
                    if raw_file_path.exists() and raw_file_path.is_file() and file_sha256(raw_file_path).lower() != raw_hash.lower():
                        failures.append(f"{label}: raw_sha256 mismatch for {raw_path}.")

                if status == "processed" and not packet_path:
                    failures.append(f"{label}: processed row must have packet_path.")
                if packet_path:
                    if not test_workspace_relative_path(packet_path, "raw/derived"):
                        failures.append(f"{label}: packet_path must be workspace-relative under raw/derived/: {packet_path}")
                    elif status == "processed" and not workspace_file(workspace, packet_path).exists():
                        failures.append(f"{label}: processed packet_path does not exist: {packet_path}")

                if status in {"failed", "needs-review"}:
                    if flag is not True:
                        failures.append(f"{label}: status '{status}' must set review_required to yes/true.")
                    if not notes:
                        review_findings.append(f"{label}: status '{status}' should explain review reason in notes.")
                if source_kind == "unknown" and flag is not True:
                    review_findings.append(f"{label}: unknown source_kind should require review.")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix deterministic inventory failures and rerun source-inventory-check.")
    elif review_findings:
        next_actions.append("Review inventory findings before treating intake as complete.")
    else:
        next_actions.append("Proceed to source packet lint or the next workspace validation step.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Source Inventory Check Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Inventory: {inventory_path}
- Raw directory: {args.raw_dir}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Rows checked: {rows_checked}

## Checks Run

{list_text(checks_run)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not parse raw document content.
- Does not write source packets.
- Does not run extractors, OCR, VLM, MinerU, or MCP adapters.
- Does not generate wiki pages.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def read_inventory_packet_paths(path: Path) -> list[str]:
    if not path.exists():
        return []
    tables = read_markdown_tables(path.read_text(encoding="utf-8").splitlines())
    for table in tables:
        if "packet_path" in table["headers"]:
            return [get_cell(row, "packet_path").strip() for row in table["rows"] if get_cell(row, "packet_path").strip()]
    return []


def read_metadata(packet_dir: Path, source_path: Path) -> tuple[str, dict[str, Any]] | None:
    for name in ["metadata.json", "metadata.yml", "metadata.yaml"]:
        candidate = packet_dir / name
        if not candidate.exists():
            continue
        if candidate.suffix == ".json":
            return str(candidate), json.loads(candidate.read_text(encoding="utf-8"))
        return str(candidate), parse_simple_yaml(candidate.read_text(encoding="utf-8").splitlines())
    if source_path.exists():
        frontmatter = read_frontmatter(source_path)
        if frontmatter is not None:
            return f"{source_path} frontmatter", frontmatter
    return None


def cmd_source_packet_lint(args: argparse.Namespace) -> int:
    tool_name = "source-packet-lint"
    tool_phase = "Phase 6.3 source packet validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    valid_statuses = {"complete", "partial", "failed", "manual-review"}
    valid_hash_states = {"pending", "not-hashable", "manifest"}
    required_metadata = [
        "type",
        "source_id",
        "raw_path",
        "raw_sha256",
        "source_kind",
        "inventory_status_at_extraction",
        "extraction_backend",
        "extraction_method",
        "extraction_version",
        "extraction_status",
        "modalities",
        "generated_fields",
        "known_gaps",
        "review_required",
        "review_reason",
        "derived_artifacts",
    ]
    required_anchor_columns = ["anchor_id", "location", "content_kind", "label", "source_derived", "generated", "media_ref", "review_required"]

    workspace = resolve_workspace(args.workspace, failures)
    if not failures:
        checks_run.append("workspace path exists")

    packet_inputs: list[str] = []
    if not failures:
        if args.packet:
            packet_inputs.append(args.packet)
        else:
            inventory_path = Path(args.inventory) if Path(args.inventory).is_absolute() else workspace_file(workspace, args.inventory)
            if not inventory_path.exists() and args.inventory == "raw/source-inventory.md":
                template_inventory = workspace_file(workspace, "raw/source-inventory.template.md")
                if template_inventory.exists():
                    inventory_path = template_inventory
                    review_findings.append("Using template inventory because raw/source-inventory.md was not found: raw/source-inventory.template.md")
            if not inventory_path.exists():
                failures.append(f"Inventory file does not exist and no packet was specified: {args.inventory}")
            else:
                checks_run.append("inventory packet paths parsed")
                packet_inputs.extend(read_inventory_packet_paths(inventory_path))
                if not packet_inputs:
                    review_findings.append("No packet_path values found in inventory.")

    packets_checked = 0
    for packet_input in packet_inputs:
        packet_path = Path(packet_input) if Path(packet_input).is_absolute() else workspace_file(workspace, packet_input)
        source_path = packet_path / "source.md" if packet_path.is_dir() else packet_path
        packet_dir = packet_path if packet_path.is_dir() else packet_path.parent
        packet_label = packet_input
        packets_checked += 1

        if not packet_path.exists():
            failures.append(f"{packet_label}: packet path does not exist.")
            continue
        if not source_path.exists():
            failures.append(f"{packet_label}: source.md does not exist.")
            continue
        if source_path.name != "source.md":
            review_findings.append(f"{packet_label}: packet source file is not named source.md.")

        checks_run.append(f"source packet exists: {packet_label}")
        try:
            metadata_record = read_metadata(packet_dir, source_path)
        except Exception:
            metadata_record = None
        if metadata_record is None:
            failures.append(f"{packet_label}: metadata.json, metadata.yml, metadata.yaml, or source.md frontmatter is missing.")
            continue
        checks_run.append(f"packet metadata parsed: {packet_label}")
        metadata = metadata_record[1]

        for field in required_metadata:
            if field not in metadata:
                failures.append(f"{packet_label}: missing metadata field '{field}'.")

        if metadata.get("type") is not None and str(metadata.get("type")).strip() != "source-packet":
            failures.append(f"{packet_label}: metadata type must be source-packet.")

        source_id = str(metadata.get("source_id", "")).strip()
        raw_path = str(metadata.get("raw_path", "")).strip()
        raw_hash = str(metadata.get("raw_sha256", "")).strip()
        source_kind = str(metadata.get("source_kind", "")).strip()
        extraction_status = str(metadata.get("extraction_status", "")).strip()
        flag = review_flag(metadata.get("review_required"))
        review_reason = str(metadata.get("review_reason", "")).strip()
        known_gaps = to_list(metadata.get("known_gaps"))
        generated_fields = to_list(metadata.get("generated_fields"))
        derived_artifacts = to_list(metadata.get("derived_artifacts"))
        modalities = to_list(metadata.get("modalities"))

        if empty_value(source_id):
            failures.append(f"{packet_label}: source_id is blank or placeholder.")
        if empty_value(raw_path):
            failures.append(f"{packet_label}: raw_path is blank or placeholder.")
        elif not test_workspace_relative_path(raw_path, "raw/sources"):
            failures.append(f"{packet_label}: raw_path must be workspace-relative under raw/sources/: {raw_path}")
        if empty_value(source_kind):
            failures.append(f"{packet_label}: source_kind is blank or placeholder.")
        if extraction_status not in valid_statuses:
            failures.append(f"{packet_label}: extraction_status must be complete/partial/failed/manual-review, got '{extraction_status}'.")
        if not modalities:
            review_findings.append(f"{packet_label}: modalities is empty.")

        if not raw_hash:
            review_findings.append(f"{packet_label}: raw_sha256 is blank.")
        elif not is_sha256(raw_hash) and raw_hash not in valid_hash_states:
            failures.append(f"{packet_label}: raw_sha256 must be SHA-256 or one of pending/not-hashable/manifest, got '{raw_hash}'.")
        elif is_sha256(raw_hash) and test_workspace_relative_path(raw_path, "raw/sources"):
            raw_file = workspace_file(workspace, raw_path)
            if raw_file.exists() and raw_file.is_file() and file_sha256(raw_file).lower() != raw_hash.lower():
                failures.append(f"{packet_label}: raw_sha256 mismatch for {raw_path}.")

        if source_id:
            expected_dir = workspace_file(workspace, f"raw/derived/{source_id}").resolve()
            if packet_dir.resolve() != expected_dir:
                failures.append(f"{packet_label}: packet directory should be raw/derived/{source_id}.")

        lines = source_path.read_text(encoding="utf-8").splitlines()
        anchor_table = next((table for table in read_markdown_tables(lines) if "anchor_id" in table["headers"]), None)
        if anchor_table is None:
            if extraction_status in {"complete", "partial"}:
                failures.append(f"{packet_label}: complete or partial packet must contain an anchor table.")
            else:
                review_findings.append(f"{packet_label}: no anchor table; acceptable only because extraction_status is '{extraction_status}'.")
        else:
            for column in required_anchor_columns:
                if column not in anchor_table["headers"]:
                    review_findings.append(f"{packet_label}: anchor table is missing recommended column '{column}'.")
            seen_anchors: dict[str, int] = {}
            for anchor in anchor_table["rows"]:
                anchor_id = get_cell(anchor, "anchor_id").strip()
                line = int(anchor.get("line_number", 0))
                if not anchor_id:
                    failures.append(f"{packet_label}: anchor row on line {line} has blank anchor_id.")
                elif anchor_id in seen_anchors:
                    failures.append(f"{packet_label}: duplicate anchor_id '{anchor_id}' on line {line}; first seen on line {seen_anchors[anchor_id]}.")
                else:
                    seen_anchors[anchor_id] = line
                if re.search(r"\s|#|\\", anchor_id):
                    review_findings.append(f"{packet_label}: anchor_id '{anchor_id}' should be citation-safe.")
                generated = review_flag(get_cell(anchor, "generated")) if "generated" in anchor else False
                anchor_review = review_flag(get_cell(anchor, "review_required")) if "review_required" in anchor else False
                if generated is True and not generated_fields:
                    review_findings.append(f"{packet_label}: generated anchor '{anchor_id}' exists but generated_fields is empty.")
                if generated is True and anchor_review is not True:
                    review_findings.append(f"{packet_label}: generated anchor '{anchor_id}' should require review unless already justified elsewhere.")
            if not anchor_table["rows"] and extraction_status in {"complete", "partial"}:
                failures.append(f"{packet_label}: complete or partial packet has no anchors.")

        if extraction_status in {"partial", "failed", "manual-review"}:
            if not known_gaps:
                failures.append(f"{packet_label}: extraction_status '{extraction_status}' requires known_gaps.")
            if flag is not True:
                failures.append(f"{packet_label}: extraction_status '{extraction_status}' requires review_required true/yes.")
            if empty_value(review_reason):
                failures.append(f"{packet_label}: extraction_status '{extraction_status}' requires a useful review_reason.")
        elif flag is True and empty_value(review_reason):
            review_findings.append(f"{packet_label}: review_required is true but review_reason is empty.")
        elif flag is None:
            failures.append(f"{packet_label}: review_required must be yes/no/true/false.")

        for artifact in derived_artifacts:
            if not test_safe_relative_path(artifact):
                failures.append(f"{packet_label}: derived artifact path must be safe and relative: {artifact}")
                continue
            workspace_artifact = workspace_file(workspace, artifact)
            packet_artifact = packet_dir / artifact.replace("/", os.sep)
            if not workspace_artifact.exists() and not packet_artifact.exists():
                review_findings.append(f"{packet_label}: derived artifact reference does not exist locally: {artifact}")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix deterministic source packet failures and rerun source-packet-lint.")
    elif review_findings:
        next_actions.append("Review packet findings before treating packets as ready for wiki or compare work.")
    else:
        next_actions.append("Proceed to evidence, wiki, compare, or the next validation step.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Source Packet Lint Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Packet input: {args.packet}
- Inventory: {args.inventory}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Packets checked: {packets_checked}

## Checks Run

{list_text(checks_run)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not parse raw binary documents.
- Does not run extractors, OCR, VLM, MinerU, or MCP adapters.
- Does not generate source packets.
- Does not decide semantic truth.
- Does not generate wiki pages.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def wiki_links(content: str) -> list[str]:
    targets = []
    for match in re.finditer(r"\[\[([^\]]+)\]\]", content):
        target = match.group(1).strip()
        if "|" in target:
            target = target.split("|", 1)[0].strip()
        if target:
            targets.append(target)
    return targets


def markdown_links(content: str) -> list[str]:
    targets = []
    for match in re.finditer(r"(?<!!)\[[^\]]+\]\(([^)]+)\)", content):
        target = match.group(1).strip().strip("<>")
        if target:
            targets.append(target)
    return targets


def normalize_wiki_target(target: str) -> str:
    clean = target.strip()
    if "#" in clean:
        clean = clean.split("#", 1)[0].strip()
    if clean.endswith(".md"):
        clean = clean[:-3]
    clean = clean.lstrip("/")
    if clean.startswith("wiki/"):
        clean = clean[5:]
    return clean


def add_keyed_record(target_map: dict[str, list[dict[str, Any]]], key: str, record: dict[str, Any]) -> None:
    if not key:
        return
    target_map.setdefault(key, [])
    if not any(existing["full_path"] == record["full_path"] for existing in target_map[key]):
        target_map[key].append(record)


def resolve_wiki_target(target: str, target_map: dict[str, list[dict[str, Any]]]) -> tuple[str, dict[str, Any] | None]:
    clean = normalize_wiki_target(target)
    if not clean:
        return "anchor-only", None
    records = target_map.get(clean)
    if not records:
        return "missing", None
    if len(records) > 1:
        return "ambiguous", records[0]
    return "resolved", records[0]


def is_external_link(target: str) -> bool:
    return bool(re.match(r"^(https?|mailto|tel):", target))


def resolve_local_markdown_link(target: str, current_file: Path, workspace: Path) -> tuple[str, Path | None]:
    if is_external_link(target):
        return "external", None
    clean = target.split("#", 1)[0].strip()
    if not clean:
        return "anchor-only", current_file
    if Path(clean).is_absolute():
        return "unsafe", Path(clean)
    current_candidate = (current_file.parent / clean.replace("/", os.sep)).resolve()
    if current_candidate.exists():
        return "resolved", current_candidate
    workspace_candidate = workspace_file(workspace, clean).resolve()
    if workspace_candidate.exists():
        return "resolved", workspace_candidate
    return "missing", current_candidate


def cmd_wiki_lint(args: argparse.Namespace) -> int:
    tool_name = "wiki-lint"
    tool_phase = "Phase 6.4 wiki lint and navigation validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    required_frontmatter = ["type", "title", "sources", "created", "updated"]
    overview_sections = ["Corpus Map", "Important Sources Or Decks", "Chapter Structure", "Current Coverage", "Known Gaps"]

    workspace = resolve_workspace(args.workspace, failures)
    if not failures:
        checks_run.append("workspace path exists")
    wiki_path = workspace_file(workspace, args.wiki_dir)
    index_path = wiki_path / "index.md"
    overview_path = wiki_path / "overview.md"
    log_path = wiki_path / "log.md"
    content_pages: list[dict[str, Any]] = []
    target_map: dict[str, list[dict[str, Any]]] = {}
    indexed_wiki_rel_paths: set[str] = set()
    pages_checked = 0
    links_checked = 0

    if not failures:
        if not wiki_path.is_dir():
            failures.append(f"Wiki directory does not exist: {args.wiki_dir}")
        else:
            checks_run.append("wiki directory exists")
            for name, path in [("index", index_path), ("overview", overview_path), ("log", log_path)]:
                if not path.exists():
                    failures.append(f"Missing special wiki file: wiki/{name}.md")
                else:
                    wiki_rel = path.relative_to(wiki_path).as_posix()
                    record = {
                        "full_path": str(path),
                        "workspace_rel": workspace_relative(workspace, path),
                        "wiki_rel": wiki_rel,
                        "wiki_rel_no_ext": wiki_rel[:-3],
                        "base_name": path.stem,
                        "is_special": True,
                    }
                    add_keyed_record(target_map, record["wiki_rel_no_ext"], record)
                    add_keyed_record(target_map, record["base_name"], record)

            for file in wiki_path.rglob("*.md"):
                if file.name == "README.md" or file.name.endswith(".template.md"):
                    continue
                if file in {index_path, overview_path, log_path}:
                    continue
                wiki_rel = file.relative_to(wiki_path).as_posix()
                record = {
                    "full_path": str(file),
                    "workspace_rel": workspace_relative(workspace, file),
                    "wiki_rel": wiki_rel,
                    "wiki_rel_no_ext": wiki_rel[:-3],
                    "base_name": file.stem,
                    "is_special": False,
                }
                content_pages.append(record)
                add_keyed_record(target_map, record["wiki_rel_no_ext"], record)
                add_keyed_record(target_map, record["base_name"], record)
            checks_run.append("wiki pages discovered")
            if not content_pages:
                review_findings.append("No active content pages found under wiki/.")

    if not failures:
        for page in content_pages:
            pages_checked += 1
            label = page["workspace_rel"]
            path = Path(page["full_path"])
            frontmatter = read_frontmatter(path)
            if frontmatter is None:
                failures.append(f"{label}: missing YAML frontmatter.")
            else:
                for field in required_frontmatter:
                    if field not in frontmatter:
                        failures.append(f"{label}: missing frontmatter field '{field}'.")
                page_type = str(frontmatter.get("type", "")).strip()
                if not page_type:
                    failures.append(f"{label}: frontmatter type is blank.")
                elif page["wiki_rel"].startswith("chapters/") and page_type != "chapter":
                    review_findings.append(f"{label}: page under wiki/chapters/ should normally use type 'chapter'.")
                elif page["wiki_rel"].startswith("sources/") and page_type != "source":
                    review_findings.append(f"{label}: page under wiki/sources/ should normally use type 'source'.")
                for date_field in ["created", "updated"]:
                    value = str(frontmatter.get(date_field, "")).strip()
                    if value == "YYYY-MM-DD":
                        review_findings.append(f"{label}: frontmatter {date_field} still uses placeholder YYYY-MM-DD.")
                    elif value and not re.fullmatch(r"\d{4}-\d{2}-\d{2}", value):
                        review_findings.append(f"{label}: frontmatter {date_field} should use YYYY-MM-DD format.")

            content = path.read_text(encoding="utf-8")
            outgoing = 0
            for target in wiki_links(content):
                links_checked += 1
                state, _record = resolve_wiki_target(target, target_map)
                if state == "missing":
                    failures.append(f"{label}: broken wikilink '[[{target}]]'.")
                elif state == "ambiguous":
                    review_findings.append(f"{label}: ambiguous wikilink '[[{target}]]'.")
                    outgoing += 1
                elif state == "resolved":
                    outgoing += 1
            for target in markdown_links(content):
                links_checked += 1
                state, _path = resolve_local_markdown_link(target, path, workspace)
                if state == "missing":
                    failures.append(f"{label}: broken Markdown link '({target})'.")
                elif state == "unsafe":
                    failures.append(f"{label}: Markdown link must not use absolute local path: {target}")
                elif state in {"resolved", "external", "anchor-only"}:
                    outgoing += 1
            if outgoing == 0:
                review_findings.append(f"{label}: content page has no outgoing wiki, local, or external links.")
        checks_run.append("content page frontmatter and links checked")

    if not failures and index_path.exists():
        index_content = index_path.read_text(encoding="utf-8")
        for target in wiki_links(index_content):
            links_checked += 1
            state, record = resolve_wiki_target(target, target_map)
            if state == "missing":
                failures.append(f"wiki/index.md: broken wikilink '[[{target}]]'.")
            elif state == "ambiguous":
                review_findings.append(f"wiki/index.md: ambiguous wikilink '[[{target}]]'.")
                if record:
                    indexed_wiki_rel_paths.add(record["wiki_rel"])
            elif state == "resolved" and record:
                indexed_wiki_rel_paths.add(record["wiki_rel"])
        for target in markdown_links(index_content):
            links_checked += 1
            state, resolved = resolve_local_markdown_link(target, index_path, workspace)
            if state == "missing":
                failures.append(f"wiki/index.md: broken Markdown link '({target})'.")
            elif state == "unsafe":
                failures.append(f"wiki/index.md: Markdown link must not use absolute local path: {target}")
            elif state == "resolved" and resolved and resolved.suffix == ".md":
                try:
                    indexed_wiki_rel_paths.add(resolved.relative_to(wiki_path).as_posix())
                except ValueError:
                    pass
        if "overview.md" not in indexed_wiki_rel_paths:
            failures.append("wiki/index.md: overview.md must be discoverable from the index.")
        for page in content_pages:
            if page["wiki_rel"] not in indexed_wiki_rel_paths:
                failures.append(f"wiki/index.md: content page is missing from index: {page['wiki_rel']}")
        checks_run.append("index links and membership checked")

    if not failures and overview_path.exists():
        overview_content = overview_path.read_text(encoding="utf-8")
        for section in overview_sections:
            if not re.search(rf"(?m)^##\s+{re.escape(section)}", overview_content):
                review_findings.append(f"wiki/overview.md: expected overview section not found or renamed: {section}")
        checks_run.append("overview maintenance sections checked")

    if not failures and log_path.exists():
        log_content = log_path.read_text(encoding="utf-8")
        if not re.search(r"(?m)^##\s+\[\d{4}-\d{2}-\d{2}\]", log_content):
            review_findings.append("wiki/log.md: no dated log entry heading found.")
        checks_run.append("wiki log dated entry checked")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix deterministic wiki lint failures and rerun wiki-lint.")
    elif review_findings:
        next_actions.append("Review wiki lint findings before treating navigation as complete.")
    else:
        next_actions.append("Proceed to compare/report validation or the next Phase 6 checker target.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Wiki Lint Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Wiki directory: {args.wiki_dir}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Pages checked: {pages_checked}
- Links checked: {links_checked}

## Checks Run

{list_text(checks_run)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not generate wiki pages.
- Does not rewrite links or frontmatter.
- Does not run compare gates.
- Does not inspect raw binary documents.
- Does not resolve semantic review.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def source_ref_list(value: str) -> bool:
    return not placeholder_value(value) and bool(re.search(r"[A-Za-z0-9_.\-/]+#[A-Za-z0-9_.\-/]+", value))


def id_list(value: str) -> bool:
    return not placeholder_value(value) and bool(re.search(r"[A-Za-z0-9_.\-/]+", value))


def cmd_report_check(args: argparse.Namespace) -> int:
    tool_name = "report-check"
    tool_phase = "Phase 6.5 report surface validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    classified_reports: list[str] = []
    valid_round_statuses = {"pass", "fail", "needs-review"}
    valid_check_results = {"pass", "fail", "needs-review", "not-enabled", "not-run"}
    valid_check_categories = {"deterministic", "manual-protocol", "human-review"}
    valid_closure_decisions = {"close-pass", "close-with-review", "do-not-close"}
    valid_claim_statuses = {
        "draft",
        "supported",
        "weak",
        "unsupported",
        "contested",
        "generated-derived",
        "reviewed-generated",
        "needs-review",
        "not-in-scope",
        "stale",
    }
    valid_review_statuses = {"open", "in-review", "resolved", "dismissed", "carried-forward", "blocked", "stale"}
    valid_blocking_levels = {"blocking", "nonblocking", "informational"}
    valid_queue_statuses = {"active", "needs-review", "blocked", "closed"}

    def check_compare(label: str, content: str, tables: list[dict[str, Any]]) -> None:
        require_sections(label, content, ["Round Scope", "Status Summary", "Input Artifacts", "Check Matrix", "Decision And Next Actions"], failures)
        status = normalize_enum(get_field_value(content, "Status"))
        if status not in valid_round_statuses:
            failures.append(f"{label}: compare report Status must be pass/fail/needs-review.")
        if status == "pass" and "compare gate not enabled" in content:
            failures.append(f"{label}: pass cannot be used when compare gate is not enabled.")
        matrix = find_table(tables, ["check", "category", "result", "blocking", "evidence"])
        if matrix is None:
            failures.append(f"{label}: missing Check Matrix table.")
            return
        for row in matrix["rows"]:
            check = get_cell(row, "check")
            category = normalize_enum(get_cell(row, "category"))
            result = normalize_enum(get_cell(row, "result"))
            blocking = normalize_enum(get_cell(row, "blocking"))
            line = get_cell(row, "line_number")
            if placeholder_value(check):
                review_findings.append(f"{label}: check matrix row {line} still looks like a placeholder.")
                continue
            if category not in valid_check_categories:
                failures.append(f"{label}: check matrix row {line} has invalid category '{category}'.")
            if result not in valid_check_results:
                failures.append(f"{label}: check matrix row {line} has invalid result '{result}'.")
            if blocking not in {"yes", "no"}:
                failures.append(f"{label}: check matrix row {line} blocking must be yes/no.")
            if status == "pass" and result in {"fail", "needs-review", "not-enabled", "not-run"}:
                failures.append(f"{label}: report status pass conflicts with check '{check}' result '{result}'.")
            if status == "pass" and blocking == "yes":
                failures.append(f"{label}: report status pass conflicts with blocking check '{check}'.")

    def check_claim(label: str, content: str, tables: list[dict[str, Any]]) -> None:
        require_sections(label, content, ["Evidence Map", "Claim Map", "Review Handoff", "Result"], failures)
        evidence = find_table(tables, ["evidence_id", "source_ref", "evidence_kind"])
        if evidence is None:
            failures.append(f"{label}: missing Evidence Map table.")
        else:
            for row in evidence["rows"]:
                evidence_id = get_cell(row, "evidence_id")
                source_ref = get_cell(row, "source_ref")
                line = get_cell(row, "line_number")
                if not id_list(evidence_id):
                    review_findings.append(f"{label}: evidence row {line} has blank or placeholder evidence_id.")
                if not source_ref_list(source_ref):
                    failures.append(f"{label}: evidence row {line} source_ref must use <source_id>#<anchor_id> form.")
        claim_table = find_table(tables, ["claim_id", "claim", "status", "evidence_ids"])
        if claim_table is None:
            failures.append(f"{label}: missing Claim Map table.")
            return
        for row in claim_table["rows"]:
            claim_id = get_cell(row, "claim_id")
            status = normalize_enum(get_cell(row, "status"))
            evidence_ids = get_cell(row, "evidence_ids")
            review_ids = get_cell(row, "review_item_ids")
            line = get_cell(row, "line_number")
            if not id_list(claim_id):
                review_findings.append(f"{label}: claim row {line} has blank or placeholder claim_id.")
            if status not in valid_claim_statuses:
                failures.append(f"{label}: claim row {line} has invalid status '{status}'.")
            if status == "supported" and not id_list(evidence_ids):
                failures.append(f"{label}: supported claim row {line} must have evidence_ids.")
            if status in {"weak", "unsupported", "contested", "generated-derived", "needs-review", "stale"} and not id_list(review_ids):
                review_findings.append(f"{label}: claim row {line} with status '{status}' should route to review_item_ids.")

    def check_review(label: str, content: str, tables: list[dict[str, Any]]) -> None:
        require_sections(label, content, ["Scope", "Open Review Items", "Carried Forward", "Notes"], failures)
        queue_status = normalize_enum(get_field_value(content, "Queue status"))
        if queue_status and queue_status not in valid_queue_statuses:
            failures.append(f"{label}: Queue status must be active/needs-review/blocked/closed.")
        open_items = find_table(tables, ["review_item_id", "status", "blocking_level", "decision_needed"])
        if open_items is None:
            failures.append(f"{label}: missing Open Review Items table.")
        else:
            for row in open_items["rows"]:
                review_id = get_cell(row, "review_item_id")
                status = normalize_enum(get_cell(row, "status"))
                blocking = normalize_enum(get_cell(row, "blocking_level"))
                decision = get_cell(row, "decision_needed")
                line = get_cell(row, "line_number")
                if not id_list(review_id):
                    review_findings.append(f"{label}: review row {line} has blank or placeholder review_item_id.")
                if status not in valid_review_statuses:
                    failures.append(f"{label}: review row {line} has invalid status '{status}'.")
                if blocking not in valid_blocking_levels:
                    failures.append(f"{label}: review row {line} has invalid blocking_level '{blocking}'.")
                if status in {"open", "in-review", "blocked", "stale"} and placeholder_value(decision):
                    review_findings.append(f"{label}: active review row {line} needs decision_needed.")
        carried = find_table(tables, ["review_item_id", "blocking_level", "blocks_pass"])
        if carried:
            for row in carried["rows"]:
                review_id = get_cell(row, "review_item_id")
                blocking = normalize_enum(get_cell(row, "blocking_level"))
                blocks_pass = normalize_enum(get_cell(row, "blocks_pass"))
                line = get_cell(row, "line_number")
                if placeholder_value(review_id):
                    continue
                if blocking not in valid_blocking_levels:
                    failures.append(f"{label}: carried-forward row {line} has invalid blocking_level '{blocking}'.")
                if blocks_pass not in {"yes", "no"}:
                    failures.append(f"{label}: carried-forward row {line} blocks_pass must be yes/no.")
                if blocking == "blocking" and blocks_pass != "yes":
                    failures.append(f"{label}: blocking carried-forward review '{review_id}' must block pass.")

    def check_validation(label: str, content: str) -> None:
        require_sections(label, content, ["Round", "Checks Performed", "Compare Status", "Round Closure", "Result"], failures)
        status = normalize_enum(get_field_value(content, "Status"))
        closure = normalize_enum(get_field_value(content, "Closure decision"))
        compare_status = normalize_enum(get_field_value(content, "Compare status"))
        if status and status not in valid_round_statuses:
            failures.append(f"{label}: Status must be pass/fail/needs-review.")
        if closure and closure not in valid_closure_decisions:
            failures.append(f"{label}: Closure decision must be close-pass/close-with-review/do-not-close.")
        if compare_status and compare_status not in {"pass", "fail", "needs-review", "compare gate not enabled"}:
            failures.append(f"{label}: Compare status has invalid value '{compare_status}'.")
        if closure == "close-pass" and compare_status != "pass":
            failures.append(f"{label}: close-pass requires Compare status pass.")
        if status == "pass" and compare_status == "compare gate not enabled":
            failures.append(f"{label}: pass cannot be used when compare gate is not enabled.")

    workspace = resolve_workspace(args.workspace, failures)
    if not failures:
        checks_run.append("workspace path exists")
    reports_path = workspace_file(workspace, args.reports_dir)
    reports_checked = 0

    if not failures:
        if not reports_path.is_dir():
            review_findings.append(f"Reports directory does not exist: {args.reports_dir}")
        else:
            checks_run.append("reports directory exists")
            for file in reports_path.rglob("*.md"):
                if file.name.endswith(".template.md") or file.name == "README.md":
                    continue
                label = workspace_relative(workspace, file)
                normalized_path = label.replace("\\", "/").lower()
                content = file.read_text(encoding="utf-8")
                tables = read_markdown_tables(content.splitlines(), lower_headers=True)
                matched = False
                if re.search(r"reports/compare/", normalized_path) or re.search(r"compare-report", file.name.lower()):
                    reports_checked += 1
                    matched = True
                    classified_reports.append(f"compare: {label}")
                    check_compare(label, content, tables)
                if re.search(r"claim-evidence", normalized_path) or re.search(r"claim-evidence", file.name.lower()):
                    reports_checked += 1
                    matched = True
                    classified_reports.append(f"claim-evidence: {label}")
                    check_claim(label, content, tables)
                if re.search(r"review-queue", normalized_path) or re.search(r"review-queue", file.name.lower()):
                    reports_checked += 1
                    matched = True
                    classified_reports.append(f"review-queue: {label}")
                    check_review(label, content, tables)
                if re.search(r"reports/validation/", normalized_path) or re.search(r"validation-note", file.name.lower()):
                    reports_checked += 1
                    matched = True
                    classified_reports.append(f"validation-note: {label}")
                    check_validation(label, content)
                if not matched:
                    warnings.append(f"Unclassified report ignored: {label}")
            if reports_checked == 0:
                review_findings.append("No compare, claim/evidence, review queue, or validation-note reports found.")
            checks_run.append("report files discovered and classified")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix deterministic report-surface failures and rerun report-check.")
    elif review_findings:
        next_actions.append("Review report findings before treating report surfaces as complete.")
    else:
        next_actions.append("Proceed to round closure validation or the next Phase 6 checker target.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Report Check Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Reports directory: {args.reports_dir}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Reports checked: {reports_checked}

## Checks Run

{list_text(checks_run)}

## Classified Reports

{list_text(classified_reports)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not extract claims from wiki pages or raw files.
- Does not decide semantic truth.
- Does not rewrite reports.
- Does not generate wiki pages.
- Does not close rounds.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def recorded_path_exists(workspace: Path, recorded_path: str) -> bool:
    clean = str(recorded_path or "").strip()
    if clean == "" or re.match(r"(?i)^(none|n/a)$", clean):
        return True
    if " " in clean:
        clean = re.split(r"\s+", clean)[0]
    if clean.startswith("[") and "](" in clean:
        match = re.search(r"\]\(([^)]+)\)", clean)
        if match:
            clean = match.group(1)
    clean = clean.split("#", 1)[0].strip().strip("<>")
    if not clean:
        return True
    path = Path(clean) if Path(clean).is_absolute() else workspace_file(workspace, clean)
    return path.exists()


def is_yes(value: str) -> bool:
    return normalize_enum(value) == "yes"


def is_no(value: str) -> bool:
    return normalize_enum(value) == "no"


def cmd_round_closure_check(args: argparse.Namespace) -> int:
    tool_name = "round-closure-check"
    tool_phase = "Phase 6.6 round closure validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    valid_statuses = {"pass", "fail", "needs-review"}
    valid_compare_statuses = {"pass", "fail", "needs-review", "compare gate not enabled"}
    valid_closure = {"close-pass", "close-with-review", "do-not-close"}
    closure_notes_checked = 0

    def require_field(label: str, name: str, value: str) -> None:
        if closure_placeholder(value):
            failures.append(f"{label}: required closure field '{name}' is missing or placeholder.")

    workspace = resolve_workspace(args.workspace, failures)
    if not failures:
        checks_run.append("workspace path exists")
    reports_path = workspace_file(workspace, args.reports_dir)
    wiki_path = workspace_file(workspace, args.wiki_dir)
    index_path = wiki_path / "index.md"
    log_path = wiki_path / "log.md"
    index_content = ""
    log_content = ""

    if not failures:
        if not reports_path.is_dir():
            review_findings.append(f"Reports directory does not exist: {args.reports_dir}")
        else:
            checks_run.append("reports directory exists")
        if index_path.exists():
            index_content = index_path.read_text(encoding="utf-8")
            checks_run.append("wiki index read")
        else:
            failures.append("wiki/index.md is required for closure validation.")
        if log_path.exists():
            log_content = log_path.read_text(encoding="utf-8")
            checks_run.append("wiki log read")
        else:
            failures.append("wiki/log.md is required for closure validation.")

    if not failures and reports_path.is_dir():
        validation_notes = [
            p
            for p in reports_path.rglob("*.md")
            if not p.name.endswith(".template.md")
            and ("validation" in p.parts or re.search(r"validation-note", p.name.lower()))
        ]
        if not validation_notes:
            review_findings.append("No validation notes found under reports/.")
        for note in validation_notes:
            closure_notes_checked += 1
            label = workspace_relative(workspace, note)
            content = note.read_text(encoding="utf-8")
            status = normalize_enum(get_field_value(content, "Status"))
            closure = normalize_enum(get_field_value(content, "Closure decision"))
            compare_status = normalize_enum(get_field_value(content, "Compare status"))
            compare_report = get_field_value(content, "Compare report")
            review_queue = get_field_value(content, "Review queue")
            round_can_close = get_field_value(content, "Round can close")
            advance_normally = get_field_value(content, "Round can advance normally")
            advance_with_review = get_field_value(content, "Round can advance with review")
            reason = get_field_value(content, "Reason")
            next_action = get_field_value(content, "Next round or next action")
            compare_supports = get_field_value(content, "Compare report status supports closure")
            review_supports = get_field_value(content, "Review queue status supports closure")
            index_supports = get_field_value(content, "Index status supports closure")
            overview_supports = get_field_value(content, "Overview status supports closure")
            log_supports = get_field_value(content, "Wiki log status supports closure")
            blocking_review = get_field_value(content, "Blocking review items")
            blocking_carried = get_field_value(content, "Blocking carried-forward review")
            nonblocking_carried = get_field_value(content, "Nonblocking carried-forward review")
            carried_reason = get_field_value(content, "Carried-forward reason and next action")

            for field, value in [
                ("Status", status),
                ("Closure decision", closure),
                ("Compare status", compare_status),
                ("Reason", reason),
                ("Next round or next action", next_action),
            ]:
                require_field(label, field, value)

            if status not in valid_statuses:
                failures.append(f"{label}: Status must be pass/fail/needs-review.")
            if closure not in valid_closure:
                failures.append(f"{label}: Closure decision must be close-pass/close-with-review/do-not-close.")
            if compare_status not in valid_compare_statuses:
                failures.append(f"{label}: Compare status has invalid value '{compare_status}'.")
            if not recorded_path_exists(workspace, compare_report):
                failures.append(f"{label}: referenced compare report does not exist: {compare_report}")
            if not recorded_path_exists(workspace, review_queue):
                failures.append(f"{label}: referenced review queue does not exist: {review_queue}")

            if closure == "close-pass":
                if status != "pass":
                    failures.append(f"{label}: close-pass requires Status pass.")
                if compare_status != "pass":
                    failures.append(f"{label}: close-pass requires Compare status pass.")
                for field, value in [
                    ("Round can close", round_can_close),
                    ("Round can advance normally", advance_normally),
                    ("Compare report status supports closure", compare_supports),
                    ("Review queue status supports closure", review_supports),
                    ("Index status supports closure", index_supports),
                    ("Overview status supports closure", overview_supports),
                    ("Wiki log status supports closure", log_supports),
                ]:
                    if not is_yes(value):
                        failures.append(f"{label}: close-pass requires '{field}' to be yes.")
                if not is_no(advance_with_review):
                    review_findings.append(f"{label}: close-pass should normally set 'Round can advance with review' to no.")
                if not closure_placeholder(blocking_review) and normalize_enum(blocking_review) not in {"none", "0", "no"}:
                    failures.append(f"{label}: close-pass cannot have blocking review items.")
                if not closure_placeholder(blocking_carried) and normalize_enum(blocking_carried) not in {"none", "0", "no"}:
                    failures.append(f"{label}: close-pass cannot have blocking carried-forward review.")
            elif closure == "close-with-review":
                if status != "needs-review":
                    failures.append(f"{label}: close-with-review requires Status needs-review.")
                if compare_status != "needs-review":
                    failures.append(f"{label}: close-with-review requires Compare status needs-review.")
                if not is_yes(round_can_close):
                    failures.append(f"{label}: close-with-review requires Round can close yes.")
                if not is_yes(advance_with_review):
                    failures.append(f"{label}: close-with-review requires Round can advance with review yes.")
                if closure_placeholder(nonblocking_carried) and closure_placeholder(carried_reason):
                    failures.append(f"{label}: close-with-review requires carried-forward review reason and next action.")
                if not closure_placeholder(blocking_carried) and normalize_enum(blocking_carried) not in {"none", "0", "no"}:
                    failures.append(f"{label}: close-with-review cannot carry blocking review as nonblocking closure.")
                if compare_report and compare_report not in index_content:
                    review_findings.append(f"{label}: close-with-review should keep active compare report discoverable from wiki/index.md.")
                if review_queue and review_queue not in index_content:
                    review_findings.append(f"{label}: close-with-review should keep active review queue discoverable from wiki/index.md.")
            elif closure == "do-not-close":
                if is_yes(round_can_close):
                    failures.append(f"{label}: do-not-close cannot set Round can close yes.")
                if is_yes(advance_normally):
                    failures.append(f"{label}: do-not-close cannot set Round can advance normally yes.")
            if compare_status == "compare gate not enabled" and closure == "close-pass":
                failures.append(f"{label}: compare gate not enabled is not close-pass.")
            if closure and closure not in log_content:
                review_findings.append(f"{label}: wiki/log.md does not visibly record closure decision '{closure}'.")
        checks_run.append("validation notes inspected")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix deterministic round closure failures and rerun round-closure-check.")
    elif review_findings:
        next_actions.append("Review closure findings before treating rounds as closed.")
    else:
        next_actions.append("Proceed to fixtures or the next Phase 6 checker target.")

    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Round Closure Check Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Reports directory: {args.reports_dir}
- Wiki directory: {args.wiki_dir}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Validation notes checked: {closure_notes_checked}

## Checks Run

{list_text(checks_run)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not close rounds.
- Does not rewrite validation notes, reports, or wiki pages.
- Does not resolve review items.
- Does not decide semantic truth.
- Does not generate reports.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


COMMAND_RUNNERS: dict[str, Callable[[argparse.Namespace], int]] = {}


def cmd_fixture_runner(args: argparse.Namespace) -> int:
    tool_name = "fixture-runner"
    tool_phase = "Phase 6.7 scenario fixture validation"
    started = utc_now()
    checks_run: list[str] = []
    failures: list[str] = []
    review_findings: list[str] = []
    warnings: list[str] = []
    next_actions: list[str] = []
    scenario_results: list[str] = []
    fixture_root = Path(args.fixture_root)
    if not fixture_root.is_absolute():
        fixture_root = Path.cwd() / fixture_root

    if not fixture_root.is_dir():
        failures.append(f"Fixture root does not exist: {args.fixture_root}")
    else:
        checks_run.append("fixture root exists")

    temp_root = Path(tempfile.gettempdir()) / f"llm-awesome-wiki-fixtures-{uuid.uuid4().hex}"
    temp_root.mkdir(parents=True, exist_ok=True)
    scenarios_run = 0
    tool_commands = {
        "wiki-lint": cmd_wiki_lint,
        "report-check": cmd_report_check,
        "round-closure-check": cmd_round_closure_check,
        "workspace-check": cmd_workspace_check,
    }

    try:
        if not failures:
            scenario_files = list(fixture_root.rglob("scenario.json"))
            if not scenario_files:
                failures.append(f"No scenario.json files found under {args.fixture_root}.")
            for scenario_file in scenario_files:
                scenario = json.loads(scenario_file.read_text(encoding="utf-8"))
                name = str(scenario.get("name", ""))
                tool = str(scenario.get("tool", ""))
                mode = str(scenario.get("mode", ""))
                expected_exit = int(scenario.get("expected_exit_code", 0))
                expected_status = str(scenario.get("expected_status", "")).lower()
                scenario_dir = scenario_file.parent
                workspace_source = scenario_dir / "workspace"
                scenario_temp = temp_root / name
                scenario_report = temp_root / f"{name}-report.md"
                scenarios_run += 1
                if not name:
                    failures.append(f"{scenario_file}: scenario name is required.")
                    continue
                if tool not in tool_commands:
                    failures.append(f"{name}: unknown tool '{tool}'.")
                    continue
                if not workspace_source.is_dir():
                    failures.append(f"{name}: workspace directory is missing.")
                    continue
                shutil.copytree(workspace_source, scenario_temp)
                if tool == "workspace-check":
                    if not mode:
                        failures.append(f"{name}: workspace-check scenarios must set mode.")
                        continue
                    child_args = argparse.Namespace(workspace=str(scenario_temp), mode=mode, report=str(scenario_report))
                elif tool == "wiki-lint":
                    child_args = argparse.Namespace(workspace=str(scenario_temp), wiki_dir="wiki", report=str(scenario_report))
                elif tool == "report-check":
                    child_args = argparse.Namespace(workspace=str(scenario_temp), reports_dir="reports", report=str(scenario_report))
                else:
                    child_args = argparse.Namespace(workspace=str(scenario_temp), reports_dir="reports", wiki_dir="wiki", report=str(scenario_report))
                actual_exit = tool_commands[tool](child_args)
                actual_status = report_status(scenario_report)
                result = "pass"
                if actual_exit != expected_exit:
                    result = "fail"
                    failures.append(f"{name}: expected exit {expected_exit} but got {actual_exit}.")
                if actual_status != expected_status:
                    result = "fail"
                    failures.append(f"{name}: expected status '{expected_status}' but got '{actual_status}'.")
                scenario_results.append(f"| {name} | {tool} | {expected_exit} | {actual_exit} | {expected_status} | {actual_status} | {result} |")
            checks_run.append("scenario files executed")
    finally:
        if not args.keep_temp:
            resolved = temp_root.resolve()
            temp_prefix = Path(tempfile.gettempdir()).resolve()
            if str(resolved).lower().startswith(str(temp_prefix).lower()):
                shutil.rmtree(resolved, ignore_errors=True)
            else:
                raise RuntimeError(f"Refusing to remove fixture temp directory outside OS temp: {resolved}")

    status, exit_code = finish_status(failures, review_findings)
    if failures:
        next_actions.append("Fix failing fixture scenarios and rerun fixture-runner.")
    elif review_findings:
        next_actions.append("Review fixture-runner findings before treating fixtures as complete.")
    else:
        next_actions.append("Proceed to Phase 6 closure review.")

    scenario_table = (
        "| scenario | tool | expected_exit | actual_exit | expected_status | actual_status | result |\n"
        "| --- | --- | --- | --- | --- | --- | --- |\n"
        + "\n".join(scenario_results)
        if scenario_results
        else "No scenarios executed."
    )
    report_path = resolve_report_path(args.report)
    write_text(
        report_path,
        f"""# Fixture Runner Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Fixture root: {fixture_root}
- Started: {started}
- Status: {status}
- Exit code: {exit_code}
- Scenarios run: {scenarios_run}

## Scenario Results

{scenario_table}

## Checks Run

{list_text(checks_run)}

## Failures

{list_text(failures)}

## Review Findings

{list_text(review_findings)}

## Warnings

{list_text(warnings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not run extractors.
- Does not parse raw binary documents.
- Does not resolve semantic review.
- Does not generate source packets or wiki pages.
""",
    )
    print(f"{tool_name}: {status} (exit {exit_code})")
    print(f"report: {report_path}")
    return exit_code


def merge_child_result(
    check_name: str,
    child_exit: int,
    child_report: Path,
    checks_run: list[str],
    findings: list[str],
    state: dict[str, Any],
) -> None:
    checks_run.append(check_name)
    if child_exit == EXIT_PASS:
        findings.append(f"{check_name} passed. Report: {child_report}")
    elif child_exit == EXIT_FAIL:
        if state["exit_code"] != EXIT_ERROR:
            state["status"] = "fail"
            state["exit_code"] = EXIT_FAIL
        findings.append(f"{check_name} failed. Report: {child_report}")
    elif child_exit == EXIT_REVIEW:
        if state["exit_code"] == EXIT_PASS:
            state["status"] = "needs-review"
            state["exit_code"] = EXIT_REVIEW
        findings.append(f"{check_name} needs review. Report: {child_report}")
    else:
        state["status"] = "error"
        state["exit_code"] = EXIT_ERROR
        findings.append(f"{check_name} runtime error. Report: {child_report}")


def cmd_workspace_check(args: argparse.Namespace) -> int:
    tool_name = "workspace-check"
    tool_phase = "Phase 6.9 Python runtime with schema, source, wiki, report, closure, and fixture checks"
    started = utc_now()
    checks_run: list[str] = []
    checks_not_implemented: list[str] = []
    findings: list[str] = []
    next_actions: list[str] = []
    state: dict[str, Any] = {"status": "pass", "exit_code": EXIT_PASS}
    report_path = resolve_report_path(args.report)
    report_dir = report_path.parent
    mode = args.mode

    workspace = resolve_workspace(args.workspace, findings)
    if findings:
        state["status"] = "error"
        state["exit_code"] = EXIT_ERROR
    else:
        checks_run.append("workspace path exists")

    if state["exit_code"] == EXIT_PASS:
        if mode in {"schemas", "all"}:
            child_report = report_dir / "schema-check-report.md"
            child_exit = cmd_schema_check(argparse.Namespace(workspace=str(workspace), schema_dir="contracts/schemas", report=str(child_report)))
            merge_child_result("schema and structured-field validation", child_exit, child_report, checks_run, findings, state)
        if mode in {"source", "all"}:
            inv_report = report_dir / "source-inventory-check-report.md"
            inv_exit = cmd_source_inventory_check(
                argparse.Namespace(workspace=str(workspace), inventory="raw/source-inventory.md", raw_dir="raw/sources", report=str(inv_report))
            )
            merge_child_result("source inventory check", inv_exit, inv_report, checks_run, findings, state)
            packet_report = report_dir / "source-packet-lint-report.md"
            packet_exit = cmd_source_packet_lint(
                argparse.Namespace(workspace=str(workspace), inventory="raw/source-inventory.md", packet="", report=str(packet_report))
            )
            merge_child_result("source packet lint", packet_exit, packet_report, checks_run, findings, state)
        if mode in {"wiki", "all"}:
            child_report = report_dir / "wiki-lint-report.md"
            child_exit = cmd_wiki_lint(argparse.Namespace(workspace=str(workspace), wiki_dir="wiki", report=str(child_report)))
            merge_child_result("wiki lint and navigation validation", child_exit, child_report, checks_run, findings, state)
        if mode in {"reports", "all"}:
            child_report = report_dir / "report-check-report.md"
            child_exit = cmd_report_check(argparse.Namespace(workspace=str(workspace), reports_dir="reports", report=str(child_report)))
            merge_child_result("report surface validation", child_exit, child_report, checks_run, findings, state)
        if mode in {"closure", "all"}:
            child_report = report_dir / "round-closure-check-report.md"
            child_exit = cmd_round_closure_check(argparse.Namespace(workspace=str(workspace), reports_dir="reports", wiki_dir="wiki", report=str(child_report)))
            merge_child_result("round closure validation", child_exit, child_report, checks_run, findings, state)
        if mode in {"fixtures", "all"}:
            child_report = report_dir / "fixture-runner-report.md"
            child_exit = cmd_fixture_runner(argparse.Namespace(fixture_root="tests/fixtures/phase6", report=str(child_report), keep_temp=False))
            merge_child_result("fixture runner validation", child_exit, child_report, checks_run, findings, state)
        if mode == "smoke":
            next_actions.append("Run workspace-check with --mode schemas or --mode source for implemented Phase 6 validators.")
        if state["exit_code"] == EXIT_PASS:
            next_actions.append("Proceed to the next Phase 6 checker target.")
        elif state["exit_code"] == EXIT_REVIEW:
            next_actions.append("Review not-implemented checks before treating the workspace as fully validated.")
    else:
        next_actions.append("Fix configuration or runtime error and rerun workspace-check.")

    write_text(
        report_path,
        f"""# Workspace Check Report

## Summary

- Tool: {tool_name}
- Phase: {tool_phase}
- Workspace: {workspace}
- Mode: {mode}
- Started: {started}
- Status: {state["status"]}
- Exit code: {state["exit_code"]}

## Checks Run

{list_text(checks_run)}

## Checks Not Implemented

{list_text(checks_not_implemented)}

## Findings

{list_text(findings)}

## Next Actions

{list_text(next_actions)}

## Non-Goals

- Does not run extractors.
- Does not parse raw binary documents.
- Does not generate source packets or wiki pages.
- Does not resolve semantic review.
""",
    )
    print(f"{tool_name}: {state['status']} (exit {state['exit_code']})")
    print(f"report: {report_path}")
    return int(state["exit_code"])


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="llm_wiki_tools", description="LLM Awesome Wiki validation/checker tooling.")
    sub = parser.add_subparsers(dest="command", required=True)

    p = sub.add_parser("validate-kernel")
    p.add_argument("--root", default=".")
    p.set_defaults(func=cmd_validate_kernel)

    p = sub.add_parser("schema-check")
    p.add_argument("--workspace", default=".")
    p.add_argument("--schema-dir", default="contracts/schemas")
    p.add_argument("--report", default="schema-check-report.md")
    p.set_defaults(func=cmd_schema_check)

    p = sub.add_parser("source-inventory-check")
    p.add_argument("--workspace", default=".")
    p.add_argument("--inventory", default="raw/source-inventory.md")
    p.add_argument("--raw-dir", default="raw/sources")
    p.add_argument("--report", default="source-inventory-check-report.md")
    p.set_defaults(func=cmd_source_inventory_check)

    p = sub.add_parser("source-packet-lint")
    p.add_argument("--workspace", default=".")
    p.add_argument("--inventory", default="raw/source-inventory.md")
    p.add_argument("--packet", default="")
    p.add_argument("--report", default="source-packet-lint-report.md")
    p.set_defaults(func=cmd_source_packet_lint)

    p = sub.add_parser("wiki-lint")
    p.add_argument("--workspace", default=".")
    p.add_argument("--wiki-dir", default="wiki")
    p.add_argument("--report", default="wiki-lint-report.md")
    p.set_defaults(func=cmd_wiki_lint)

    p = sub.add_parser("report-check")
    p.add_argument("--workspace", default=".")
    p.add_argument("--reports-dir", default="reports")
    p.add_argument("--report", default="report-check-report.md")
    p.set_defaults(func=cmd_report_check)

    p = sub.add_parser("round-closure-check")
    p.add_argument("--workspace", default=".")
    p.add_argument("--reports-dir", default="reports")
    p.add_argument("--wiki-dir", default="wiki")
    p.add_argument("--report", default="round-closure-check-report.md")
    p.set_defaults(func=cmd_round_closure_check)

    p = sub.add_parser("fixture-runner")
    p.add_argument("--fixture-root", default="tests/fixtures/phase6")
    p.add_argument("--report", default="fixture-runner-report.md")
    p.add_argument("--keep-temp", action="store_true")
    p.set_defaults(func=cmd_fixture_runner)

    p = sub.add_parser("workspace-check")
    p.add_argument("--workspace", default=".")
    p.add_argument("--mode", default="smoke", choices=["smoke", "all", "schemas", "source", "wiki", "reports", "closure", "fixtures"])
    p.add_argument("--report", default="workspace-check-report.md")
    p.set_defaults(func=cmd_workspace_check)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    return int(args.func(args))

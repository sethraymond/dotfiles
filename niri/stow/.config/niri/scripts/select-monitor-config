#!/usr/bin/env python3

import json
import os
import re
import subprocess
import sys
from pathlib import Path
from pprint import pprint

MONITOR_DIR = Path.home() / ".config" / "niri" / "monitors"
TARGET_LINK = MONITOR_DIR / "monitors.kdl"


def get_connected_ids() -> set[str]:
    """Return the set of connected output identifiers from `niri msg --json outputs`."""
    result = subprocess.run(
        ["niri", "msg", "--json", "outputs"],
        check=True,
        capture_output=True,
        text=True,
    )
    data = json.loads(result.stdout)

    connected_ids: set[str] = set()

    for name, settings in data.items():
        connected_ids.add(name)

        make = settings.get("make")
        model = settings.get("model")
        serial = settings.get("serial")
        if make and model and serial:
            connected_ids.add(f"{make} {model} {serial}")
    return connected_ids


def get_config_output_ids(config_path: Path) -> list[str]:
    """Extract output identifiers from lines like: output "eDP-1" { ... }"""
    pattern = re.compile(r'^\s*output\s+"([^"]+)"', re.MULTILINE)
    text = config_path.read_text(encoding="utf-8")
    return pattern.findall(text)


def replace_symlink(target: Path, source: Path) -> None:
    """Atomically replace target with a symlink to source."""
    tmp_link = target.with_name(f".{target.name}.tmp")
    try:
        if tmp_link.exists() or tmp_link.is_symlink():
            tmp_link.unlink()
        tmp_link.symlink_to(source)
        os.replace(tmp_link, target)
    finally:
        if tmp_link.exists() or tmp_link.is_symlink():
            tmp_link.unlink(missing_ok=True)


def remove_target(target: Path) -> None:
    if target.exists() or target.is_symlink():
        target.unlink()


def find_best_match(connected_ids: set[str]) -> Path | None:
    """Return the first config file with any matching output identifier."""
    for config_path in sorted(MONITOR_DIR.glob("*.kdl")):
        if config_path.name == "monitors.kdl":
            continue

        config_ids = get_config_output_ids(config_path)
        if any(config_id in connected_ids for config_id in config_ids):
            return config_path

    return None


def main() -> int:
    try:
        connected_ids = get_connected_ids()
    except subprocess.CalledProcessError as e:
        print(f"Failed to query niri outputs: {e}", file=sys.stderr)
        return 1
    except json.JSONDecodeError as e:
        print(f"Failed to parse niri JSON output: {e}", file=sys.stderr)
        return 1

    if not connected_ids:
        remove_target(TARGET_LINK)
        return 0

    match = find_best_match(connected_ids)

    if match is not None:
        replace_symlink(TARGET_LINK, match)
        print(f"Linked {TARGET_LINK} -> {match}")
    else:
        remove_target(TARGET_LINK)
        print(f"No matching monitor config found; removed {TARGET_LINK}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

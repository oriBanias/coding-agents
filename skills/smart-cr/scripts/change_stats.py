#!/usr/bin/env python3
"""Measure local Git changes without excluding files from review."""

import argparse
import json
from pathlib import Path
import subprocess
import sys


def git(repo, *args):
    result = subprocess.run(
        ["git", "-C", str(repo), *args],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if result.returncode:
        raise RuntimeError(
            result.stderr.decode("utf-8", errors="replace").strip()
        )
    return result.stdout


def collect(repo, scope):
    files = {}

    def entry(path):
        return files.setdefault(path, {
            "path": path,
            "additions": 0,
            "deletions": 0,
            "lines_changed": 0,
            "binary": False,
            "count_unknown": False,
            "layers": [],
        })

    layers = ["staged", "unstaged"] if scope == "both" else [scope]

    for layer in layers:
        args = [
            "diff",
            "--no-ext-diff",
            "--no-textconv",
            "--numstat",
            "-z",
            "--no-renames",
            "--ignore-submodules=none",
        ]
        if layer == "staged":
            args.append("--cached")

        for record in git(repo, *args).split(b"\0"):
            if not record:
                continue

            added, deleted, raw_path = record.split(b"\t", 2)
            path = raw_path.decode("utf-8", errors="surrogateescape")
            item = entry(path)
            item["layers"].append(layer)

            if added == b"-" or deleted == b"-":
                item["binary"] = True
                item["count_unknown"] = True
            else:
                item["additions"] += int(added)
                item["deletions"] += int(deleted)

    if scope in {"unstaged", "both"}:
        output = git(
            repo, "ls-files", "--others", "--exclude-standard", "-z"
        )
        for raw_path in output.split(b"\0"):
            if raw_path:
                item = entry(
                    raw_path.decode("utf-8", errors="surrogateescape")
                )
                item["layers"].append("untracked")
                # Do not open untracked files merely to measure size.
                item["count_unknown"] = True

    result = sorted(files.values(), key=lambda item: item["path"])

    for item in result:
        item["lines_changed"] = (
            None if item["count_unknown"]
            else item["additions"] + item["deletions"]
        )

    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--repo",
        default=".",
        help="Repository or directory within it",
    )
    parser.add_argument(
        "--scope",
        choices=("unstaged", "staged", "both"),
        default="both",
    )
    args = parser.parse_args()

    try:
        raw_root = git(args.repo, "rev-parse", "--show-toplevel")
        root = Path(
            raw_root.decode(
                "utf-8", errors="surrogateescape"
            ).rstrip("\r\n")
        )
        files = collect(root, args.scope)
    except (OSError, RuntimeError, ValueError) as exc:
        print("change_stats: " + str(exc), file=sys.stderr)
        return 1

    known = [
        item["lines_changed"]
        for item in files
        if item["lines_changed"] is not None
    ]
    unknown = any(item["count_unknown"] for item in files)
    maximum = max(known, default=0)

    if not files:
        tier = "none"
    elif unknown:
        tier = "inspect-first"
    elif len(files) <= 2 and maximum < 30:
        tier = "tiny"
    elif len(files) <= 5 and maximum < 50:
        tier = "minimal"
    else:
        tier = "larger"

    json.dump({
        "repository": str(root),
        "scope": args.scope,
        "changed_files": len(files),
        "known_lines_changed": sum(known),
        "has_unknown_counts": unknown,
        "suggested_tier": tier,
        "files": files,
    }, sys.stdout, indent=2, ensure_ascii=True)

    sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())

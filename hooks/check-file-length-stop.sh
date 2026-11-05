#!/usr/bin/env bash
# Claude Code Stop hook.
# Requires Git Bash, Node.js and Git on Windows.
#
# Counts all lines in uncommitted UTF-8 text files, not just agent edits.
# Does not modify files.
# The stop_hook_active guard avoids repeated blocks.
# Symlinks, non-UTF-8 and NUL-containing files are skipped.
#
# Save this file and its companion policy with LF line endings.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POLICY_FILE="$SCRIPT_DIR/file-length-policy.sh"

if [ ! -r "$POLICY_FILE" ]; then
  printf '%s\n' \
    'File-length check unavailable: companion policy missing.' >&2
  exit 1
fi

source "$POLICY_FILE"

for dependency in node git; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'File-length check unavailable: %s missing.\n' \
      "$dependency" >&2
    exit 1
  fi
done

exec node -e "$(cat <<'NODE'
"use strict";

const fs = require("node:fs");
const path = require("node:path");
const { execFileSync } = require("node:child_process");

const [
  limitArg,
  dirsArg,
  filesArg,
  pathsArg,
  ignoreFile
] = process.argv.slice(1);

const split = value => value.split(",").filter(Boolean);
const limit = Number(limitArg);
const dirs = new Set(split(dirsArg));

function glob(pattern) {
  let result = "^";

  for (let i = 0; i < pattern.length; i++) {
    const c = pattern[i];

    if (c === "*" && pattern[i + 1] === "*") {
      i++;

      if (pattern[i + 1] === "/") {
        i++;
        result += "(?:.*/)?";
      } else {
        result += ".*";
      }
    } else if (c === "*") {
      result += "[^/]*";
    } else if (c === "?") {
      result += "[^/]";
    } else {
      result += c.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    }
  }

  return new RegExp(result + "$", "s");
}

function main() {
  if (!Number.isSafeInteger(limit) || limit < 1) {
    throw new Error("Invalid MAX_LINES");
  }

  const payload = JSON.parse(
    fs.readFileSync(0, "utf8").replace(/^\uFEFF/, "")
  );

  if (payload.stop_hook_active === true) return;

  if (payload.hook_event_name !== "Stop") {
    throw new Error("Expected Stop event");
  }

  if (
    typeof payload.cwd !== "string" ||
    !path.isAbsolute(payload.cwd)
  ) {
    throw new Error("Invalid working directory");
  }

  const git = (args, cwd) => execFileSync("git", args, {
    cwd,
    encoding: "utf8",
    windowsHide: true,
    timeout: 10000,
    maxBuffer: 16 * 1024 * 1024,
    stdio: ["ignore", "pipe", "pipe"]
  });

  let root;

  try {
    root = git(
      ["rev-parse", "--show-toplevel"],
      payload.cwd
    ).trim();
  } catch (error) {
    if (String(error.stderr).includes("not a git repository")) {
      return;
    }

    throw error;
  }

  const baseRules = split(filesArg).map(glob);
  const pathRules = split(pathsArg);
  let customRules = [];

  const customPath = path.join(root, ignoreFile);

  if (fs.existsSync(customPath)) {
    const config = JSON.parse(
      fs.readFileSync(customPath, "utf8").replace(/^\uFEFF/, "")
    );

    if (
      !Array.isArray(config.ignored_paths) ||
      !config.ignored_paths.every(
        p => typeof p === "string" && p.length > 0
      )
    ) {
      throw new Error(
        "ignored_paths must be an array of nonempty strings"
      );
    }

    customRules = config.ignored_paths.map(p => ({
      full: p.includes("/"),
      re: glob(p)
    }));
  }

  const files = new Set([
    ...git(
      ["diff", "--name-only", "-z", "--diff-filter=ACMR", "--"],
      root
    ).split("\0"),

    ...git(
      [
        "diff",
        "--cached",
        "--name-only",
        "-z",
        "--diff-filter=ACMR",
        "--"
      ],
      root
    ).split("\0"),

    ...git(
      ["ls-files", "--others", "--exclude-standard", "-z", "--"],
      root
    ).split("\0")
  ].filter(Boolean));

  const oversized = [];
  const decoder = new TextDecoder("utf-8", { fatal: true });

  for (const rel of [...files].sort()) {
    const parts = rel.split("/");
    const base = parts[parts.length - 1];

    const ignored =
      parts.slice(0, -1).some(p => dirs.has(p)) ||
      baseRules.some(re => re.test(base)) ||
      pathRules.some(
        p => ("/" + rel).includes("/" + p + "/")
      ) ||
      customRules.some(
        rule => rule.re.test(rule.full ? rel : base)
      );

    if (ignored) continue;

    const file = path.join(root, rel);
    let stat;

    try {
      stat = fs.lstatSync(file);
    } catch (error) {
      if (error.code === "ENOENT") continue;
      throw error;
    }

    if (!stat.isFile() || stat.isSymbolicLink()) continue;

    const bytes = fs.readFileSync(file);
    if (bytes.includes(0)) continue;

    let text;

    try {
      text = decoder.decode(bytes);
    } catch (_) {
      continue;
    }

    const lines = text.length === 0
      ? 0
      : text.split(/\r\n|\n|\r/).length -
        (/[\r\n]$/.test(text) ? 1 : 0);

    if (lines > limit) {
      oversized.push(
        `${JSON.stringify(rel)} (${lines} lines)`
      );
    }
  }

  if (oversized.length) {
    const shown = oversized.slice(0, 20).join(", ");
    const extra = oversized.length > 20
      ? `; plus ${oversized.length - 20} more`
      : "";

    process.stdout.write(JSON.stringify({
      decision: "block",
      reason:
        `Uncommitted files exceed ${limit} physical lines: ` +
        `${shown}${extra}. ` +
        "These may include pre-existing user changes. " +
        "Ask the user whether to address them before refactoring " +
        "or splitting. Do not modify them just to satisfy this " +
        "check without confirmation. If declined, leave them unchanged."
    }) + "\n");
  }
}

try {
  main();
} catch (_) {
  console.error(
    "File-length check failed. Review the hook input, policy, " +
    "project ignore JSON, Git status and dependencies; " +
    "validation was not completed."
  );

  process.exitCode = 1;
}
NODE
)" "$MAX_LINES" "$IGNORE_DIRS" "$IGNORE_FILES" \
   "$IGNORE_PATHS" "$PROJECT_IGNORE_FILE"

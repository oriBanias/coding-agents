#!/usr/bin/env bash
# Claude Code PreToolUse hook. Requires Git Bash and Node.js on Windows.
# Register with matcher ".*"; invoke with bash and the quoted absolute path.
# Policy: ask before operations naming .env* or .dev.vars* files.
# Exempt templates: .env[.<name>].example/sample/template and equivalent
# .dev.vars templates. Exemptions are naming conventions, not secret scans.
# Uses Claude Code's approval flow; never auto-approves unmatched operations.
# Scope: explicit file paths, Glob patterns, and heuristic shell inspection.
# Not a sandbox: indirect scripts, broad directory reads/searches, hard links,
# shell expansion and non-tool context ingestion are not fully covered.
# No prompt, command, or file contents are logged. No persistent state.
# Save with LF line endings. Do not invoke this file using PowerShell syntax.
set -euo pipefail

if ! command -v node >/dev/null 2>&1; then
  printf '%s\n' 'Sensitive-file guard unavailable: Node.js is not on PATH.' >&2
  exit 2
fi

exec node -e "$(cat <<'NODE'
"use strict";
const fs = require("node:fs");
const path = require("node:path");

function ask(reason) {
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "ask",
      permissionDecisionReason: reason
    }
  }) + "\n");
}

function protectedName(value) {
  // Handle both separators even when inspecting Windows paths on Unix.
  const normalized = value.replace(/\\/g, "/").replace(/\/+$/, "");
  // Ignore an NTFS alternate-data-stream suffix for the name check.
  const name = normalized.slice(normalized.lastIndexOf("/") + 1)
    .split(":")[0].replace(/[ .]+$/, "").toLowerCase();
  if (!name.startsWith(".env") &&
      name !== ".dev.vars" && !name.startsWith(".dev.vars.")) return false;
  return !/^(?:\.env|\.dev\.vars)(?:\..+)?\.(?:example|sample|template)$/.test(name);
}

function protectedPath(value, cwd) {
  if (protectedName(value)) return true;
  // Resolve existing symlinks and parent links for newly created files.
  // Resolution uses this machine's filesystem; it cannot remove TOCTOU races.
  let candidate = path.resolve(cwd, value);
  const suffix = [];
  for (;;) {
    try {
      const resolved = fs.realpathSync(candidate);
      return protectedName(path.join(resolved, ...suffix));
    } catch (error) {
      if (!["ENOENT", "ENOTDIR"].includes(error.code)) throw error;
      const parent = path.dirname(candidate);
      if (parent === candidate) return false;
      suffix.unshift(path.basename(candidate));
      candidate = parent;
    }
  }
}

function pathFields(input) {
  // Deliberately exclude content, old_string, new_string and search text.
  const keys = new Set(["file_path", "notebook_path", "path", "paths",
    "filePath", "source_path", "destination_path", "target_path"]);
  const found = [];
  function visit(value) {
    if (!value || typeof value !== "object") return;
    for (const [key, item] of Object.entries(value)) {
      if (keys.has(key)) {
        if (typeof item === "string") found.push(item);
        else if (Array.isArray(item)) {
          found.push(...item.filter(entry => typeof entry === "string"));
        }
      } else if (item && typeof item === "object") visit(item);
    }
  }
  visit(input);
  return found;
}

function main() {
  const payload = JSON.parse(fs.readFileSync(0, "utf8").replace(/^\uFEFF/, ""));
  if (!payload || typeof payload.hook_event_name !== "string") {
    throw new Error("Missing hook event");
  }
  if (payload.hook_event_name !== "PreToolUse") return;
  if (typeof payload.tool_name !== "string" ||
      typeof payload.cwd !== "string" || !path.isAbsolute(payload.cwd) ||
      !payload.tool_input || typeof payload.tool_input !== "object") {
    throw new Error("Invalid hook input");
  }
  const input = payload.tool_input;
  const targets = pathFields(input);
  if (payload.tool_name === "Glob" && typeof input.pattern === "string") {
    targets.push(input.pattern);
  }
  if (targets.some(target => protectedPath(target, payload.cwd))) {
    ask("This operation targets a protected environment file. Approve only if this specific access is intended.");
    return;
  }

  if (/^(?:Bash|PowerShell|bash|powershell|exec_command|functions\.exec_command)$/.test(payload.tool_name)) {
    const command = input.command ?? input.cmd;
    if (typeof command !== "string") throw new Error("Missing shell command");
    // This is intentionally heuristic, not a Bash or PowerShell parser.
    // Quoted literal paths are inspected separately to preserve spaces.
    const quoted = [...command.matchAll(/"([^"\r\n]*)"|'([^'\r\n]*)'/g)]
      .map(match => match[1] ?? match[2]);
    const tokens = command.split(/[\s<>"'`=;|&(),]+/).filter(Boolean);
    if ([...quoted, ...tokens].some(token => protectedPath(token, payload.cwd))) {
      ask("This shell command appears to reference a protected environment file. Review the complete command before approving.");
    }
  }
}

try {
  main();
} catch (_) {
  ask("The sensitive-file guard could not validate this operation. Review it manually before approving.");
}
NODE
)"

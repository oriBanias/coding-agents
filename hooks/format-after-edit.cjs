"use strict";

const fs = require("node:fs");
const path = require("node:path");
const { spawnSync } = require("node:child_process");

function main() {
  const payload = JSON.parse(fs.readFileSync(0, "utf8"));

  if (
    payload.hook_event_name !== "PostToolUse" ||
    !["Edit", "Write"].includes(payload.tool_name)
  ) {
    return;
  }

  const cwd = payload.cwd;
  const filePath = payload.tool_input?.file_path;

  if (
    typeof cwd !== "string" ||
    typeof filePath !== "string" ||
    !path.isAbsolute(cwd) ||
    !path.isAbsolute(filePath)
  ) {
    throw new Error("Expected absolute cwd and file_path values.");
  }

  if (!fs.existsSync(filePath)) return;

  const root = fs.realpathSync(cwd);
  const file = fs.realpathSync(filePath);
  const relative = path.relative(root, file);

  // Only format files inside the current working directory.
  if (
    relative === ".." ||
    relative.startsWith(`..${path.sep}`) ||
    path.isAbsolute(relative)
  ) {
    return;
  }

  if (!fs.statSync(file).isFile()) return;

  // Skip dependency folders, Git internals, and environment files.
  const segments = relative.split(path.sep);
  if (segments.some((part) => [".git", "node_modules"].includes(part))) {
    return;
  }

  const name = path.basename(file);
  if (name === ".env" || name.startsWith(".env.")) return;

  // Use only Prettier installed in the current project's root.
  const packagePath = path.join(
    root,
    "node_modules",
    "prettier",
    "package.json",
  );

  if (!fs.existsSync(packagePath)) return;

  const metadata = JSON.parse(fs.readFileSync(packagePath, "utf8"));
  const bin =
    typeof metadata.bin === "string"
      ? metadata.bin
      : metadata.bin?.prettier;

  if (!bin) throw new Error("Installed Prettier has no CLI entry.");

  const cli = path.resolve(path.dirname(packagePath), bin);

  const result = spawnSync(
    process.execPath,
    [cli, "--write", "--ignore-unknown", file],
    {
      cwd: root,
      shell: false,
      encoding: "utf8",
      timeout: 15000,
      windowsHide: true,
    },
  );

  if (result.error) throw result.error;

  if (result.status !== 0) {
    throw new Error(
      result.stderr?.trim() ||
        `Prettier exited with status ${result.status}.`,
    );
  }
}

try {
  main();
} catch (error) {
  console.error(`[format-after-edit] ${error.message}`);
  process.exitCode = 1;
}

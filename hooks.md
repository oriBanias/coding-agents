# Hooks

This repository keeps hook scripts in `hooks/` and configuration examples
in `configs/`. Choose the example for the coding tool you use.

| Hook | When it runs | What it does |
|---|---|---|
| `check-file-length-stop.sh` | `Stop` | Checks changed and untracked text files against the configured line limit and asks before refactoring oversized files. |
| `block-sensitive-file-access.sh` | Claude Code `PreToolUse` | Requests permission when a tool call appears to target a sensitive file such as `.env` or `.dev.vars`. |
| `format-after-edit.cjs` | Claude Code `PostToolUse` for `Edit` and `Write` | Formats the edited file when the project has a compatible local Prettier installation. |
| `check-tests.sh` | Optional `Stop` hook | Runs `pnpm run check` for projects that opt in through `.claude/hooks/check-tests.enabled`. |

## File-length bundle

Keep these two files in the same directory:

- `hooks/check-file-length-stop.sh` runs the check.
- `hooks/file-length-policy.sh` defines the line limit and exclusions.

Register only `check-file-length-stop.sh` as a hook. It loads the policy
file itself. The default threshold is 320 physical lines. A finding is
a prompt to review the file before deciding whether to split it.

## Codex setup on Windows

1. Open `configs/codex/hooks.example.json`.
2. In `commandWindows`, set the full paths to Git Bash and the checker
   in your local clone of `coding-agents`.
3. Ensure Git and Node.js are available to the hook process.
4. For personal use, merge the `Stop` entry into your Codex user
   `hooks.json`, normally under `%USERPROFILE%\.codex\`. Preserve any
   existing hooks and avoid registering the same checker twice.
5. Open `/hooks` in Codex CLI, or Settings > Hooks in the desktop app,
   and review the new hook.

The example points directly to your clone on Windows. Keep the clone
at that location or update the command after moving it.

## Claude Code setup on Windows

Use `configs/claude/settings.example.json` as the starting point.
For personal use, merge the desired entries into
`%USERPROFILE%\.claude\settings.json`. For project-only use, merge
them into `.claude/settings.json` in that project.

The `.sh` scripts use Bash and Node.js. The formatter runs directly
with Node.js. Register the test runner only in environments where
you want the project check to run.

## Verification

For the file-length hook, use a disposable Git repository with a
changed, non-excluded source file. At 320 lines the checker should
allow the turn to finish. At 321 lines it should report the file
without editing it.

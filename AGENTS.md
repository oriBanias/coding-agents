# Agent Instructions

Read `README.md` for the purpose and context of this repository.

## Source of Truth

- Keep the real, reusable resource files in this repository.
- Keep credentials, sessions, caches, generated state, and machine-specific settings outside this repository.
- Inspect existing resources and conventions before making changes.

## Shared Setup

- When installation is requested, link compatible resources from this repository into the coding tool's user-level location, not a project-specific directory.
- Resolve the actual configuration locations for the current machine. Do not assume default paths when custom locations are configured.
- Link skills individually. Preserve tool-managed directories and built-in resources.
- Share a resource between Claude Code and Codex only when its format and behavior are compatible with both. Otherwise, keep clearly documented tool-specific versions.
- Verify the required configuration for hooks and agents. Do not assume that creating a symbolic link activates them.
- Before replacing an existing file or directory, inspect it and create a recoverable backup.
- Verify that each link resolves to the intended resource. Make repeated setup runs safe.
- Remember that edits through a symbolic link modify the original file in this repository.

## Changes and Validation

- Keep changes focused on the requested task.
- Review scripts before running them and document any dependencies or side effects.
- Run checks appropriate to the change. State what was tested and what remains unverified.
- Update relevant documentation when setup or behavior changes.
- Preserve third-party licenses and attribution when incorporating external resources.
- Do not commit or push unless the user requests it.

## Communication

- If an ambiguity affects correctness or could overwrite existing work, ask the user and explain the options in plain language.
- Otherwise, proceed with reasonable defaults and explain consequential assumptions.
- Keep explanations concise and use ordinary hyphens instead of em dashes.

# General Coding Guidelines

Apply these guidelines when implementing or reviewing code.
Follow the target project's explicit requirements and established conventions.
Do not use these defaults to justify unrelated refactoring.

## Simplicity and Scope

- Choose the simplest solution that satisfies the actual requirements.
- Follow YAGNI: do not build speculative features or extension points.
- Avoid unnecessary abstractions, dependencies, configuration, and indirection.
- Reuse existing implementations when they fit the requirement.
- Before finishing, ask whether the change can be made simpler without
  sacrificing correctness, clarity, or required behavior.

## Structure and Readability

- Give each module a clear responsibility.
- Keep the main flow easy to follow, with supporting details in focused helpers.
- Order declarations for readability while respecting language requirements.
- Keep private helpers near their callers. Extract shared helpers when reuse
  or a clear responsibility boundary justifies it.
- Search for existing utilities before adding new ones. Consult docs/utils.md
  if the project maintains it.
- Split functions when doing so improves understanding, testing, or reuse.
  Avoid extracting trivial functions solely to reduce line counts.
- Use 320 lines as a review threshold, not an absolute correctness rule.
  Explain justified exceptions and avoid artificial file splitting.
- A one-function file is acceptable when it represents a coherent module.

## Correctness and Errors

- Validate external inputs at trust boundaries.
- Handle expected failures where recovery or useful context is possible.
- Avoid repetitive try-catch blocks and silently swallowed errors.
- Let unexpected failures propagate to an appropriate boundary, where they
  can be reported clearly.
- Preserve resource cleanup, data integrity, and safe operating states.
  Hardware-control code must account for failures during an operation.
- Do not disguise failed operations as successful results.

## Types and Interfaces

- Use types to clarify contracts and prevent meaningful mistakes.
- Prefer straightforward types over elaborate generic abstractions.
- Do not weaken type checking merely to silence errors.
- Follow the project's language version and compatibility requirements.

## Verification

- Run checks appropriate to the behavior changed.
- Add or update tests when they meaningfully cover new behavior or regressions.
- For visual changes, use an available browser or appropriate UI inspection
  tool to check the relevant states and viewport sizes.
- If visual verification is unavailable, explain what remains unverified.
  Continue other useful checks, but do not claim visual correctness.
- Report what was actually tested, failures, and material limitations.

## Environment

- Verify the operating system, shell, runtime, and working directory before
  choosing commands.
- Distinguish native Windows, PowerShell, Git Bash, and WSL.
- Quote paths and avoid hardcoded usernames or machine-specific locations.
- Do not assume a tool available in one coding agent exists in another.

## Related Guidelines

Read only the documents relevant to the task:

- [Backend](backend.md)
- [Frontend](frontend.md)
- [Database](db.md)
- [React](react.md)

---
name: init-repo-docs
description: Establish or improve a lean repository documentation system grounded in the existing code, with an index, architecture and workflow documentation, and pointers to reusable utilities. Use only when explicitly requested.
disable-model-invocation: true
---

# Initialize Repository Documentation

Create concise, accurate documentation that helps a new developer
or coding agent understand and work in this repository.

Inspect the code before writing. Ask the user only for important
context that cannot be established from the repository.

This task authorizes documentation changes, not application changes,
dependency installation, commits, or publication.

## 1. Inspect the repository

Read applicable repository instructions before editing.

Inspect:

- The directory structure, excluding generated files and dependencies.
- Existing README files and documentation.
- Build manifests, package definitions, and relevant configuration.
- Application entry points and important modules.
- Representative features, data flows, and tests.
- Shared utilities, helpers, and reusable components.

Use the available file tools or commands appropriate to the actual
shell. Do not assume Unix commands are available on Windows.

Inspect relevant files selectively. Do not read credentials or
private application data to understand the project.

Check existing changes and preserve unrelated work.

Identify the documentation structure already in use. Prefer
improving it over creating a second source of truth.

## 2. Clarify meaningful gaps

Ask questions only when the answer materially affects the docs.

Useful topics include:

- Who uses the project and what problem it solves.
- Important business rules or workflows that the code cannot explain.
- Conflicting documentation or unclear architectural intent.
- Whether incomplete behavior is intentional or unfinished.

Ask one focused question at a time, with at most six initial
questions. Do not invent questions to fill a quota.

Keep answers in working context. Retain lasting decisions in the
appropriate final document rather than a temporary interview file.

Compare answers with the implementation. When they differ,
describe the discrepancy respectfully and distinguish current
behavior from intended behavior.

Do not treat code as proof of business intent or describe an
unimplemented requirement as an existing feature.

If uncertainty remains, record it explicitly rather than guessing.

## 3. Define the smallest useful structure

Use the established documentation location. If none exists,
create `docs/` at the project root.

Provide:

- `docs/index.md`: a concise navigation page.
- `docs/utils.md`: pointers to existing reusable utilities and helpers.
- Focused documents for the architecture, features, or workflows that
  need explanation.

Adapt these paths to an existing documentation convention when needed.
Explain material deviations so other agents can find the documents.

Keep root-level files such as README.md, AGENTS.md, and CLAUDE.md
in their expected locations. Add a brief documentation link to the
README when useful.

Do not create empty categories, placeholder pages, or a separate
document for every source file.

For a small repository, an index and a few focused pages may be enough.

## 4. Write code-grounded documentation

Each substantive feature, workflow, or architecture document should
contain:

### Overview

Explain:

- What it does and why it exists, when the purpose is known.
- Its main flow and responsibilities.
- Important interfaces, dependencies, and constraints.
- Non-obvious behavior or operational considerations.

Write for a developer joining the project.

### References

Link to meaningful starting points in the implementation.

Prefer entry points and files containing the main logic. Include
tests, configuration, or helpers when they materially explain a
contract or behavior.

Use relative Markdown links resolved from the document's location.
Avoid machine-specific absolute paths and fragile line references.

The index and utility catalog do not need this two-section structure.

### Utility catalog

Keep `utils.md` as a navigation aid:

- Link to existing reusable modules or directories.
- Give each entry a one-line explanation.
- Group entries only when grouping improves navigation.
- Avoid reproducing implementations or full API documentation.

Do not invent reusable utilities or create application code to fill
the catalog. If none exist, say so briefly.

### Writing rules

- Use plain language and concrete explanations.
- Keep documents lean but sufficient for onboarding.
- Prefer links over repeated explanations.
- Use snippets or diagrams only when they clarify something important.
- Aim for fewer than 320 lines per document, splitting by responsibility
  when useful.
- Label planned behavior, assumptions, and unresolved questions.
- Do not include credentials, private payloads, or unrelated personal data.
- Do not claim commands were tested unless they were actually run.

## 5. Delegate when useful

For a larger repository, use subagents when supported to document
separate, well-defined areas.

Provide each agent with:

- The shared documentation structure and writing guidelines.
- Relevant repository instructions and known business context.
- Its assigned source area and documentation file ownership.
- The requirement to verify claims against code.

Avoid overlapping edits. Keep responsibility for the top-level
index and final utility catalog with the coordinating agent.

If subagents are unavailable or unnecessary, complete the work
directly. Do not claim independent review occurred.

## 6. Review and integrate

Review the complete documentation from two perspectives:

1. Accuracy: do the descriptions match the implementation, and are
   intended behavior and uncertainties clearly distinguished?
2. Clarity: is the documentation lean, navigable, and free of
   unnecessary duplication?

For substantial documentation work, use separate reviewers for these
perspectives when subagents are available. Otherwise, perform both
review passes yourself.

Check that:

- Referenced files exist and local links resolve.
- The index includes the documents readers need.
- Terms and descriptions are consistent across pages.
- Utility entries point to existing reusable code.
- Existing documentation has not been silently contradicted.
- Unrelated files and user changes remain intact.

Resolve review findings before finishing.

## 7. Report the result

Briefly state:

- Which documentation was created or updated.
- Where to start reading.
- What was verified.
- Any remaining uncertainty or missing context.

Do not imply that reviewing documentation proves the application
works or that unexecuted setup instructions have been tested.

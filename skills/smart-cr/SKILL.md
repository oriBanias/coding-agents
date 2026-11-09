---
name: smart-cr
description: Review staged, unstaged, or all local Git changes for correctness and unnecessary complexity, scaling review effort to the size and risk of the changes. Use only when explicitly requested.
disable-model-invocation: true
---

# Smart CR

Review only. Do not edit files, stage changes, or implement fixes
unless the user subsequently requests them.

## 1. Establish the scope

Infer the requested scope:

- `staged`: changes in the Git index.
- `unstaged`: tracked working-tree changes plus untracked files.
- `both`: staged and unstaged changes, including untracked files.

Default to `both` when unspecified.

Read applicable repository instructions and relevant coding guidelines.

For `both`, inspect staged and unstaged changes separately.
Changes in these layers can cancel out when compared only with HEAD.

Review staged content from the index, not merely the current
working-tree file.

Unchanged code may be inspected to understand callers, contracts,
or reuse opportunities. Report issues introduced or exposed by
the requested changes, rather than unrelated existing problems.

## 2. Measure the changes

Locate `scripts/change_stats.py` relative to this skill's directory,
not relative to the repository being reviewed.

Run it using an available Python 3 interpreter:

    <python> "<skill-directory>/scripts/change_stats.py" --repo "<project-directory>" --scope <staged|unstaged|both>

Select the executable appropriate to the environment, such as
`python`, `python3`, or `py -3`.

The helper inventories all changed files without filtering out tests,
documentation, configuration, or unknown file types.

For `both`, counts sum changes in the index and working-tree layers.
This is a review-effort estimate, not a net patch size.

Untracked files are listed without reading their contents.
Binary files and untracked files have unknown line counts.

If the helper or Python is unavailable, use Git directly and assess
the scope manually. Do not install dependencies just for measurement.

Statistics guide review effort. They are not a substitute for
reading the changes.

## 3. Choose a review approach

Use the suggested tier as a starting point:

- `none`: no changes were found in the requested scope.
- `tiny`: review directly.
- `minimal`: use one focused reviewer when available.
- `larger`: divide the review among a small number of focused reviewers.
- `inspect-first`: assess files with unknown counts before choosing
  the appropriate review effort.

Increase scrutiny for consequential changes even when the diff is
small, such as authorization, migrations, or data deletion.

Do not spawn an agent for every category automatically.
Divide work by category or component when that improves coverage
without excessive overlap.

Use available reviewers without requiring particular model names
or reasoning settings.

If delegation is unavailable, perform the review directly and
accurately describe the limitation.

## 4. Cover all six review categories

### Functions and parameters

Are new or changed functions and parameters needed for the current
behavior? Can the implementation be simpler without losing clarity?

### Contracts and interfaces

Are interfaces and fields justified by current requirements?
Are affected callers and consumers still compatible?

### Abstractions

Does each abstraction solve a concrete problem?
Could existing infrastructure or a simpler structure serve the task?

### YAGNI

Identify speculative features, configuration, optimization, scaffolding,
and fallback paths.

Preserve compatibility and recovery behavior required by supported
use cases. Do not assume every fallback is unnecessary.

### Duplication and reuse

When duplication is plausible, inspect relevant documentation and
existing implementations.

Recommend reuse only when responsibilities and behavior genuinely
match. Superficial similarity does not justify a shared abstraction.

### Correctness and data integrity

Look for realistic bugs, regressions, security issues, and unintended
data loss or duplication.

Check relevant error handling, cleanup, concurrency, and boundary
behavior without inventing convoluted scenarios.

## 5. Maintain complete review coverage

Collectively inspect the requested diff across reviewers.

Include changed tests, configuration, and documentation where they
affect behavior, validation, installation, or user expectations.

For generated files, lockfiles, binaries, or large data files, use an
appropriate focused inspection and state any limitations. Do not
claim semantic verification from line counts alone.

Respect sensitive-file access restrictions. Report any resulting
coverage gap without exposing private contents.

## 6. Delegate with clear assignments

Give each reviewer:

- The repository location and exact diff scope.
- Relevant requirements and constraints.
- Assigned files or review categories.
- Instructions to read applicable repository guidance.
- An explicit review-only instruction.

Prefer fresh context where supported.

Ensure all reviewers assess the same repository state. If files change
during review, recheck affected findings or disclose the limitation.

Require concrete findings with:

- File and precise location, identifying the staged or working-tree
  version where relevant.
- The scenario that triggers the problem.
- Its impact or the unnecessary complexity it creates.
- Evidence and a concise correction or simplification suggestion.

Reviewers should explicitly say when they find no relevant issues.
They must not edit files or expand into unrelated review work.

## 7. Adjudicate findings

Wait for all assigned reviewers.

Treat their findings as hypotheses. Verify the relevant code and
requirements before retaining them.

Merge duplicates and reject speculative claims or suggestions that
would remove required behavior.

Keep correctness findings even when fixing them requires additional
code rather than simplification.

Do not treat agreement between reviewers as proof.

## 8. Report

Present retained findings by severity, then confidence.

For each finding, include the location, impact, supporting reasoning,
and a concise suggested correction.

Separate optional simplifications from actionable bugs.

State:

- The scope reviewed.
- Important coverage or validation limitations.
- Whether checks were actually executed.
- When no actionable findings were found.

Summarize consequential rejected findings only when their dismissal
helps explain the result. Avoid filling the report with reviewer noise.

Do not imply that an absence of findings proves the changes are correct.

Leave implementation decisions to the user and make no changes.

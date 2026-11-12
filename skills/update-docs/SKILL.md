---
name: update-docs
description: Update existing repository documentation after a completed code change. Use when explicitly requested to bring affected guides, references, and examples in line with the implementation.
disable-model-invocation: true
---

# Update Docs

Review a completed change and update the documentation a reader relies
on to understand, configure, or use the affected feature. Limit edits
to documentation and preserve existing user changes.

## Identify the change

Use the task, commit, or branch comparison identified by the user.
For a completed local task, inspect its staged and unstaged changes
and any relevant untracked files. Keep unrelated local edits outside
the scope of the documentation update.

If the working tree is clean, use the commit or comparison established
by the conversation. If the intended change is still unclear, ask
which change to document before drawing conclusions.

Read applicable repository instructions. Start with `docs/index.md`
when present, or follow the documentation links from `README.md`.
Check the relevant implementation for the exact behavior, defaults,
commands, and paths the documentation needs to describe.

## Decide what readers need

Identify which existing statements became inaccurate and what a reader
now needs to know. Consider setup steps, supported workflows, public
interfaces, configuration, and the location of important code.

An internal refactor can still require a link update if a referenced
file moved. If the existing text and references remain accurate and
sufficient, report that no documentation changes are needed and stop.

## Update the affected pages

- Edit the page readers already use for the topic. Follow the
  repository's layout, including a root README when appropriate.
- For a new topic that warrants its own page, use the established docs
  directory. Update the index when a page is added, moved, or removed.
- For feature and architecture pages, explain the purpose, behavior,
  and important constraints in plain language. Include a short
  References section linking to the relevant files or symbols.
- If `docs/utils.md` exists, update its one-line entries when a
  reusable helper is added, moved, renamed, or removed.
- Keep each topic in one place and link to it from related pages.
  Use short examples when they help a reader perform a task.
- Use relative Markdown links with forward slashes and exact filename
  casing. When command syntax depends on the shell, label the example
  as PowerShell, Git Bash, or WSL as appropriate.
- Aim for fewer than 320 lines per page. Split a page when its topics
  have distinct purposes and readers would benefit from separate pages.

Remove an obsolete section when the rest of its page remains useful.
Delete a whole page when the change makes its entire subject obsolete.
Update incoming links in the same edit. Preserve historical records
such as changelogs and architecture decisions when the repository
maintains them for that purpose.

## Verify and report

Search the relevant docs for old and new names, paths, commands, and
feature terms. Fix stale references or duplicate instructions caused
by the change. Verify edited local links from the page containing them
and check examples against the current implementation.

Keep verification focused on the documentation. A documentation
update does not require rerunning application tests, builds, or lint.

Briefly report which pages changed, what readers should know, and
which references you checked. Give a short reason for any deleted
page and identify any instruction you could not verify.

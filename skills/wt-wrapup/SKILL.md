---
name: wt-wrapup
description: Bring an approved feature worktree up to date with its base branch, resolve merge conflicts, and verify the combined result. Use only when explicitly requested.
disable-model-invocation: true
---

# Worktree Wrapup

Run this skill after the feature work has been implemented, reviewed,
and approved. Merge the current base branch into the feature branch
in its worktree.

## 1. Check the worktree and base

- Confirm the worktree path, checked-out feature branch, and current HEAD.
- Identify the intended base branch and remote from the user's request,
  the feature's pull request, or repository guidance. A feature branch's
  upstream may be its own remote branch. If the base is unclear, ask.
- Confirm the feature branch is checked out and distinct from the base.
  Stop on a detached HEAD or if another Git operation is in progress.
- Inspect staged, unstaged, and untracked changes. If pending feature
  edits or user files could be mixed into the merge or overwritten,
  report them and ask how to proceed. Preserve them in place.

## 2. Merge the current base into the feature

For a remote base, fetch the specific branch and merge the fetched
commit. For example, when the confirmed base is `origin/main`, run
these commands from the feature worktree, one at a time:

    git fetch origin refs/heads/main
    git merge --no-edit FETCH_HEAD

Run the merge only if the fetch succeeds. If the user explicitly chose
a local base, merge that local branch directly.

If the feature already contains the base commit, report that it is
up to date. Otherwise, record the base commit used for verification.

## 3. Resolve conflicts by intent

Read the affected code and relevant tests to understand what each
branch changed. Preserve intentional base updates and the approved
feature behavior wherever they can coexist.

For example, if the base renamed a function and the feature added
a caller, update the caller to use the new name. If the base removed
a workflow that the feature extends, explain the conflict and ask
which behavior should survive.

Resolve clear cases directly. Stage only the resolved paths. Avoid
blanket `ours` or `theirs` resolutions. If a decision is needed,
leave the merge in progress and identify the affected files so the
user can resume from that point.

Once all conflicts are resolved, confirm there are no unmerged paths
and complete the merge. A merge commit, when Git needs one, is part
of this operation.

## 4. Verify and report

Confirm that the feature branch contains the base commit and inspect
the final worktree status. Run the repository checks relevant to the
combined changes, especially where both branches touched the same
behavior. Use commands appropriate to the active Windows shell when
applicable.

Report the feature branch, base branch, merge outcome, conflicts
resolved, and checks actually run. Flag any failures or remaining
local changes.

Leave pushing, merging the feature into the base, and worktree cleanup
for a separate user request.

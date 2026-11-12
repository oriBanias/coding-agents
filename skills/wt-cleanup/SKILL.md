---
name: wt-cleanup
description: Remove a completed linked Git worktree and its local branch after verifying that the remote contains its commits and that the checkout has no local work to preserve. Use only when explicitly requested.
disable-model-invocation: true
---

# Worktree Cleanup

Clean up the specific linked worktree the user has finished using.
Use Git's worktree commands and keep the remote branch intact.

## 1. Identify the target

Run `git worktree list --porcelain`. Match the requested worktree to
its exact path, local branch, and HEAD commit. If the user refers to
the current worktree, record those details before switching directories.

If several worktrees match, ask which one to remove. Protect the main
worktree. If the target is locked, report the lock reason and stop.

Choose a surviving worktree from the same repository as the working
directory for the cleanup commands. Quote paths containing spaces.

## 2. Check what would be lost

From the target, check tracked changes, staged changes, untracked
files, submodule changes, and ignored files. For example:

    git -C "<target>" status --short --untracked-files=all --ignore-submodules=none --ignored=matching

Stop if there are staged or unstaged changes, untracked files, or
a merge, rebase, or other Git operation in progress.

Inspect ignored entries by name only. Known disposable build output
can be removed with the checkout. If ignored entries might contain
local configuration, credentials, user data, or anything whose purpose
is unclear, identify the paths and ask what the user wants to preserve.
Never print secret file contents.

## 3. Verify the commit is on the remote

Identify the intended upstream branch or the remote branch into which
the work was merged. Use current remote evidence. A cached tracking
branch or an earlier successful push can be stale.

Fetch the identified remote branch and confirm that its fetched tip
contains the recorded worktree HEAD. For example:

    git fetch "<remote>" "refs/heads/<remote-branch>"
    git merge-base --is-ancestor "<recorded-head>" FETCH_HEAD

An exit status of 0 from `merge-base --is-ancestor` confirms containment.
If fetching fails, the branch is ambiguous, or containment cannot be
verified, preserve the worktree and explain the gap.

A squash merge or rebase can preserve the changes under different
commit IDs. If ancestry fails in that case, report what you found
and let the user decide whether to proceed.

## 4. Remove the worktree and local branch

Immediately before removal, recheck the target's path, branch, HEAD,
and local status. Stop if anything material has changed.

From the surviving worktree, run:

    git worktree remove "<target>"

If removal fails, report Git's error and preserve the local branch.
On Windows, an open terminal, editor, or process may still be using
the directory. Use the reported error to guide the next step.
Avoid forced removal and manual directory deletion.

After successful removal, confirm that the recorded local branch
still points to the verified commit and is not checked out elsewhere.
Then use Git's normal branch deletion check:

    git branch -d -- "<local-branch>"

If Git refuses, leave the branch in place and explain why. For a
detached HEAD, skip branch deletion.

Successful worktree removal handles the target's registration.
Reserve `git worktree prune` for a separately identified stale
registration because pruning can affect unrelated worktrees.

## 5. Verify the result

Check `git worktree list --porcelain` and the exact local branch ref.
Report the removed worktree path, the remote branch used to verify
the commit, and whether the local branch was deleted or retained.
If cleanup only partly succeeded, state exactly what remains.

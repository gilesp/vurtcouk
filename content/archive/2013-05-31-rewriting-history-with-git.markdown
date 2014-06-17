---
author: giles
comments: true
date: 2013-05-31 09:15:40+00:00
layout: post
slug: rewriting-history-with-git
title: Rewriting history with git
wordpress_id: 1033
categories:
- Hacks
---

Sometimes when working with git branches, you'll find you need to rewrite history to correct a mistake. For example you squashed your commits into one and pushed them but then realised you'd missed something from the squash and need to do it again. Now, while you can perform the git rebase -i again and make the changes locally, you won't be able to push this back to origin as your branches have diverged.

One way of working around this is to delete the remote branch and then push your branch again, essentially overwriting the remote with your version of history.

This isn't something that should be done without forethought though, as it has implications for anyone else who may be using the branch but if no one else has done any additional work on the branch then this is relatively safe.

The process for deleting the remote branch is:

`git push origin :branchname`

This pushes null to the remote branch, effectively deleting it.

Then you want to push your local branch to origin, tracking it in the process:

`git push -u origin branchname`

Your branch will now be on origin and your local branch will be tracking it correctly.

Anyone else who has used the branch will want to `git reset --hard origin/branchname` in order to get your changes.

Of course, I'd recommend doing some more reading on this matter before doing it as it's likely that this is all sorts of wrong in the majority of situations.

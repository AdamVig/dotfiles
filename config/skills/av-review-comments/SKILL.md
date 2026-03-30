---
name: av-review-comments
description: Use when a PR has review comments to fetch, read, reply to, or resolve — requires the gh review-comments plugin, not standard gh pr commands
disable-model-invocation: true
---

# Responding to PR Review Comments

## Workflow

1. **List** all unresolved threads
2. **Plan**: for each thread, decide agree/disagree, what action to take, and draft a reply
3. **Show the user** a summary before posting — include: what the comment says, agree/disagree with justification, and action taken or why none is needed
4. **Wait for approval**, then make any code changes freely — no commit or push without explicit instruction
5. **Post each reply** and **resolve each thread** — both required, no exceptions

## Commands

Run `gh review-comments --help` or `gh review-comments <subcommand> --help` for full flag reference.

```sh
# List all unresolved threads from all authors (default)
gh review-comments list

# Only Copilot comments (e.g. "address copilot comments")
gh review-comments list --author copilot-pull-request-reviewer

# Specific human reviewer
gh review-comments list --author someuser

# Write reply content to a temp file, then post
gh review-comments reply 987654 --message-file /tmp/reply.md

# Resolve
gh review-comments resolve 987654
```

## Key Notes

- Always use `--message-file` for replies — write the content with the Write tool first, then post

## User Expectations

- **You may disagree** with a comment — justify it clearly
- **Assume the user hasn't read the comments** — explain each one in your summary
- **Approval gate** — show all proposed replies and wait for sign-off before posting or resolving anything
- **Never commit or push** unless explicitly told to

## Stack mode (only when explicitly asked)

Use `list-stack` instead of `list` to discover threads across all PRs in the stack automatically. Code changes still span multiple branches (navigate with `git-spice up`/`down` or `git-spice branch checkout`) and commits are made by you after approval — this is a materially different workflow, do not attempt it without explicit instruction.

## Committing
- Do not use Conventional Commits style, instead follow these guidelines:
  1. Separate subject from body with a blank line
  2. Limit the subject line to 70 characters
  3. Use sentence case for the subject line
  4. Do not end the subject line with a period
  5. Use the imperative mood in the subject line
  6. Wrap the body at 72 characters
  7. Use the body to explain what and why vs. how
  8. Use GitHub-flavored Markdown to add (minimal) formatting, code blocks (e.g. shell snippets showing a command and its output), etc.
		- Feel free to use `inline code` (backticks) in the subject line where applicable
	9. Let the diff do the talking; commit bodies should reference the diff, not repeat it.

## Command line tools
When running terminal commands, prefer the following commands over the default ones:
- `fd` instead of `find`
- `rg` instead of `grep`
If you can't figure out how to use these commands, you can fall back to the original commands.

## Git
My git sets `rebase.abbreviateCommands = true` and `core.commentChar = %`, so rebase-todo verbs are `p`/`r`/`f` and comment lines start with `%`. When scripting a rebase, match those forms — the long verbs (`pick`/`reword`) silently no-op, leaving hashes unchanged.

## `git-spice`
I use [`git-spice`](https://abhinav.github.io/git-spice/llms.txt) to stack pull requests. Note that the old command name, `gs`, is no longer available; use exclusively `git-spice`. You will not always be in a `git-spice`-tracked branch or even a `git-spice`-initialized repository, but that will frequently be the case.

## Code comments
Write for the future reader, not the reviewer. Comments explain durable *why*; rot-prone justification goes in the commit message. One line where possible (≤120 chars).

Doc comments describe what a thing *is* in the abstract — not who consumes it or when/where it's populated; consumer- and lifecycle-specific notes belong at the consumer boundary, where they won't rot.

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

When committing, treat the message as raw text:
- write it via a single-quoted heredoc
- commit with `git commit --file <file>` or `git commit --file -`

Never inline a multi-line message into shell quotes.
Never use backticks or `$()` in the shell command within double quotes.
Never use literal `\n` instead of real newlines.

## Command line tools
When running terminal commands, prefer the following commands over the default ones:
- `fd` instead of `find`
- `rg` instead of `grep`
If you can't figure out how to use these commands, you can fall back to the original commands.

## `git-spice`
I use [`git-spice`](https://abhinav.github.io/git-spice/llms.txt) to stack pull requests. Note that the old command name, `gs`, is no longer available; use exclusively `git-spice`. You will not always be in a `git-spice`-tracked branch or even a `git-spice`-initialized repository, but that will frequently be the case.

## GitHub pull request review comments
Use my custom `gh review-comments --help` plugin to fetch review comments from the pull request for a given commit and optionally reply to/resolve them. Do not use other `gh` commands for this purpose unless you're trying to do something that `gh review-comments` does not support.

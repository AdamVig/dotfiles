- Before writing code of our own, look for a way to get the job done with the standard library, an existing dependency, or a tool we already run, including its less obvious features; the goal is to own as little code as possible. When leaning on one of these gives a worse result than hand-written code would (such as a vaguer error message), tell me what's lost so I can decide.

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

I often use `gh stack --help` to stack pull requests (I may refer to this as `gs`, a shell alias not available to you).

## Code comments
Write for the future reader, not the reviewer. Comments explain durable *why*; rot-prone justification goes in the commit message. One line where possible (≤120 chars).

Doc comments describe what a thing *is* in the abstract — not who consumes it or when/where it's populated; consumer- and lifecycle-specific notes belong at the consumer boundary, where they won't rot.

## Testing
- Each test pins down a behavior the code is meant to keep, exercised through its public API, so it fails only when that behavior breaks. Before writing one, name the bug it would catch. Confirm refactors and requested changes ad hoc (run it, check the output), and keep the suite for lasting behavior.
- Test each behavior once, at the lowest level that can observe it.
- Write tests DAMP rather than DRY: straight-line code, expected values written as literals rather than computed by the code under test, and setup repeated wherever that reads more clearly than a shared helper.
- Use real code where possible, then fakes, then mocks, and assert on results and state.
- Treat a failing test or snapshot as information: fix the code, or if the test itself is wrong, explain why and let me decide before changing it.

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

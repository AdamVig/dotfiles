## Committing
- Do not use Conventional Commits style, instead follow these guidelines:
	1. Separate subject from body with a blank line
  2. Limit the subject line to 70 characters
  3. Capitalize the subject line
  4. Do not end the subject line with a period
  5. Use the imperative mood in the subject line
  6. Wrap the body at 72 characters
  7. Use the body to explain what and why vs. how
	8. Use GitHub-flavored Markdown to add (minimal) formatting, code blocks (e.g. shell snippets showing a command and its output), etc.
- Use the `--no-gpg-sign` flag with `git commit` and `git rebase` to avoid sandbox-related errors with GPG signing.

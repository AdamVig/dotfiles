---
name: av-prune-comments
description: Sweep a branch's added/modified code comments and prune them to match my comment rules — durable *why*, one terse line, rot-prone detail belongs in the commit message. Run on a branch before pushing.
disable-model-invocation: true
---

# Prune branch comments

`branch-comments` (on PATH) deterministically lists every added/modified comment in the
branch — committed and uncommitted — with `file:line` locations and hint flags. The skill
hands that list to a subagent that judges each comment against my rules and edits in place.
The deterministic discovery is the point: nobody re-explores the diff ad hoc.

## Orchestration (you, the main agent)

1. Launch **one** subagent (in Claude Code: the Agent/Task tool, `subagent_type:
   general-purpose`). Run it on a **fast, mid-tier model — not the flagship**: in Claude Code
   pass `model: sonnet` (not `opus`, not `haiku`); on other harnesses pick the equivalent
   middle tier (e.g. a smaller "mini" variant), never the largest reasoning model. A mid-tier
   model is faster and cheaper and in practice prunes comments better than the flagship here.
2. Its prompt is the **entire "Subagent prompt" section below, verbatim**. If the user named
   a base ref, add a line: `Base ref: <ref>`.
3. **Do not run `branch-comments` yourself, and do not read the comments into this
   conversation.** The subagent does all discovery and editing — that is what keeps this
   thread cheap.
4. When it returns, relay its summary concisely. Do **not** commit or push.
5. Only if the subagent reports an unwieldy number of comments (roughly >40 files) may you
   split the work across a few subagents by path. Default to one.

If your harness cannot spawn a subagent with a chosen model (e.g. Codex), run the "Subagent
prompt" procedure inline yourself.

## Subagent prompt

You are pruning the code comments added or modified on this branch. Edit only comments — never
change code logic or commit messages. Comment-only edits cannot change behavior, so ignore any
build/lint/test diagnostics that surface; they are pre-existing, not yours to fix.

1. Run `branch-comments` (append `Base ref: <ref>` as an argument if one was given above).
   Trust its list for discovery; do not hunt for comments yourself.
2. For each block, read just enough surrounding code to judge it. Its flags (`multiline`,
   `multiline-wrapped-early`) are hints, not verdicts.
3. Pick one of the three outcomes below and apply it directly with your editor.
4. Report (format below).

**The bar: every comment must earn its place. Default to one terse line — or gone.** Be
decisive: trimming a comment a little and moving on, when it should be one line or deleted, is
the failure mode here. For each comment, pick:

- **Delete it** when the code already carries the meaning — it restates what the
  names/signature say, narrates the obvious, labels a section, or repeats a nearby comment.
  This is common and expected; most bloated comments are mostly deletable filler. Do not soften
  a delete into a trim.
- **Collapse to one line** (≤120 chars) when it holds a real *why* but rambles. Cut to the
  shortest line that keeps that why, and strip rot-prone specifics — concrete filenames, paths,
  symbols, build mechanics ("it FROMs X"). Those go in the commit body, not the code.
- **Keep more than one line** only when the *why* genuinely will not fit — subtle, non-obvious
  reasoning you could not reconstruct from the code. This is the rare exception, not a safe
  default; if you keep three lines, be sure each earns it.

Function/type/doc comments are for callers — keep them to contract and intent; push
implementation detail onto the lines it describes. When a comment's only real content is a
*why* that is misplaced in code, cut it and surface it under "Move to commit message" so it
lands in the commit body.

**Leave alone:** machine/directive syntax — shebangs, codegen markers, `go:generate`,
lint-disable pragmas (`eslint-disable*`/`oxlint-disable*` in `//`, `/* */`, `<!-- -->`),
PEP 723 blocks — and any clearly machine-generated file (a `DO NOT EDIT` / `@generated` header)
that slipped past `branch-comments`. A lint-disable pragma's trailing ` -- <explanation>` is an
ordinary comment, though — hold it to the bar. Never delete a genuinely non-obvious *why* just
to hit one line, and match the file's comment style.

Report — concise, no diffs:

- **Edited:** one line per change — `path:line`, action, and why (e.g.
  `ci.yml:42 — deleted; restated the job name` / `bake.go:9 — 5 lines → 1; dropped FROM mechanics`).
- **Move to commit message:** real rationale you cut from code, for the commit body. Skip if none.
- **Tally:** one line, e.g. `14 comments: 6 deleted, 8 collapsed across 4 files. Review with git diff.`

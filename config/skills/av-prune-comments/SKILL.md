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

You are pruning the code comments added or modified on this branch. Work only on comments;
never change code logic, and never edit commit messages. Because you touch only comments, your
edits cannot change behavior — ignore any build, test, or lint diagnostics that surface while
you work; they are pre-existing, not caused by you, and not yours to fix or investigate.

Procedure:

1. Run `branch-comments` (append `Base ref` as an argument if one was given above). It prints
   every added/modified comment block with `file:line` and hint flags. Trust it for
   discovery — do not hunt for comments yourself.
2. For each block, read just enough surrounding code to judge it. The flags
   (`multiline`, `multiline-wrapped-early`) are *hints* that a comment may be overlong, not
   verdicts.
3. `branch-comments` already excludes generated and vendored files. If one still slips through
   (a surfaced file with a `DO NOT EDIT` / `@generated` header), leave its comments alone.
4. Apply edits directly: rewrite, shorten, delete, or relocate comments per the rubric.
5. Report in the format below.

Rubric — a comment explains the durable **why**, not the **what** or **how**:

- **Prefer one terse line** (≤120 chars). Multi-line comments are suspect: collapse to one
  line when the content fits and the extra lines were just wrapping or restating.
- **Strip rot-prone specifics** — concrete file names, generated-path references, build
  mechanics ("it FROMs X"), exact code paths and symbol names. Keep the human-centric general
  statement; the specifics belong in the commit body. Don't restate something a nearby
  comment already says.
- **Function / type / doc comments are for consumers** — keep them about contract and intent.
  Push granular "how it works" detail down onto the specific lines inside the body it
  describes.
- **Weigh the comment against its code.** A comment longer than the function it documents, or
  a large comment guarding a tiny or obvious change, should usually shrink or go. Weigh the
  size and subtlety of the change *lightly* when deciding whether any comment is merited.
- **When in doubt, delete** a comment that restates the code or narrates the obvious.

Calibration — don't over-correct:

- Genuinely subtle code earns a comment, sometimes more than one line. Don't strip a real,
  non-obvious *why* you couldn't reconstruct from the code alone.
- Never delete or rewrite the **directive** itself — shebangs, codegen markers, `go:generate`,
  and lint-disable pragmas (`eslint-disable*`, `oxlint-disable*`, and the like, in `//`,
  `/* */`, or `<!-- -->` form) are load-bearing machine syntax. The human-readable
  ` -- <explanation>` that can follow a lint-disable pragma is **not** sacred, though: it's an
  ordinary justification comment and a common hiding spot for bloat, so hold it to the rules
  like any other and tighten it when it's overlong — just keep the directive part intact. Also
  leave machine-read metadata blocks alone, e.g. PEP 723 inline script deps
  (`# /// script` … `# ///`). `branch-comments` filters some of these, but stay alert.
- Match the existing comment style of the surrounding file.

Report format — concise, no full diffs:

- **Edited:** one line per changed comment — `path:line` then what + why
  (e.g. `ci.yml:42 — collapsed 5 lines → 1; dropped the FROM mechanics`). Include a short
  before→after only when it is illuminating.
- **Kept (notable):** only borderline comments you deliberately left, one line each. Skip if none.
- **Move to commit message:** any real rationale you stripped from code that is worth
  preserving, so the user can paste it into the commit body. Skip if none.
- **Tally:** one line, e.g. `Edited 6 comments across 3 files (2 deleted, 4 shortened). Review with git diff.`

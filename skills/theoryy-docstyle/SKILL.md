---
name: theoryy-docstyle
description: "TheoryY house documentation & code-writing style — plain sentences, no meta commentary, every sentence adding a fact (no assert-then-justify, no restating the heading, no serial paraphrase, no evaluative filler), two terseness levels mapped to file type: terse (minimum words) for in-code comments & docstrings, base (plain full grammar; light word-dropping allowed in human docs) for everything else. Define jargon before use; ban unproductive buzzwords. Use whenever writing or editing code comments, docstrings, READMEs, design docs, or any project documentation. Covers text written into files; for explaining in conversation use /theoryy-speak. Trigger: /theoryy-docstyle, 'document this', 'add a docstring', 'write the README', 'write docs'."
trigger: /theoryy-docstyle
---

# /theoryy-docstyle — TheoryY house documentation style

Write documentation a busy reader absorbs in one pass. Code stays clean with minimal high-level
comments; depth lives in dedicated docs (READMEs and design docs), which stay terse and plain.
Applies to text written into files. Siblings: `theoryy-commit` (commit messages),
`theoryy-speak` (conversation).

> **The one rule: every word must carry information the reader doesn't already have.** Cut words
> that restate the code, the signature, or the previous sentence.

## Two levels

Pick the level from the file type. Both share the same base rules.

| Level | Rule | Applies to |
|---|---|---|
| **base** | Plain language, full grammar. Don't overexplain. No unproductive jargon. Audience: a college student new to the project. Human docs (README.md, DESIGN.md, ROADMAP.md, action plans) may drop articles and obvious verbs where understanding survives; agent-readables (SKILL.md, agent definitions, CLAUDE.md, workflow.md) keep complete, unambiguous grammar. | All docs, human and agent-readable |
| **terse** | Minimum number of words that still carry the core information. | In-code: comments and docstrings |

## Plain sentences, no meta commentary (all levels)

**Plain sentence** — one fact, stated directly: subject, verb, object. Active voice. Split a
sentence rather than nest a clause inside it; two short sentences beat one with three commas.

**Meta commentary** — text about the text, or about the act of writing it. Cut all of it:

- Signposting: "This section describes…", "In this document we will…", "Below you'll find…".
- Backward reference: "As mentioned above", "As we saw earlier", "Recall that".
- Hedged emphasis: "It's worth noting that", "Note that", "Importantly", "Keep in mind".
- Author narration: "I updated…", "We decided to…", "Let's now look at…".
- Closers: "In summary", "Hopefully this clarifies", "That's it!".

Unnesting must not grow the text. Splitting one sentence into two costs a subject and a verb — pay
for them by dropping articles, obvious verbs, and words the split made redundant. A restyled passage
ends shorter than it started, or the same length.

A heading already announces its section; a sentence carries its own weight. State the fact instead:

> ❌ *It is worth noting that the SessionStart hook injects `core/workflow.md`, so as mentioned
> above a mid-session edit isn't picked up.*
> ✅ *The SessionStart hook injects `core/workflow.md`. A mid-session edit waits for the next
> session.*

## Sentences that carry nothing (all levels)

Meta commentary is text *about* the text. This is the subtler leak: a sentence *inside* the prose
that adds no fact. The one rule, applied per sentence — if deleting it costs the reader nothing,
delete it.

Four failure modes, hardest to spot first:

- **Justifying instead of stating.** Writing a fact, then a clause explaining why it matters. The
  reason *is* the fact. Write it once.
  ❌ *Validation runs first, which matters because it's what catches drift.*
  ✅ *Validation runs first — it catches drift.*
- **Restating the heading.** A section opening by re-announcing its own title. The heading did that.
  ❌ under `## Release` — *This section explains how to release the plugin.*
  ✅ under `## Release` — *Consumers pin a git commit. An un-bumped `version` is a silent no-op.*
- **Serial paraphrase.** Two or three clauses carrying one idea, each rewording the last.
  ❌ *Edits don't reach consumers on their own; you have to release, because installs pin a git
  commit rather than your working tree, so an uncommitted edit ships nothing.*
  ✅ *Installs pin a git commit. An uncommitted edit ships nothing.*
- **Evaluative filler.** Adjectives that judge instead of inform: *clean, elegant, powerful, simple,
  straightforward, careful*. Extends the buzzword ban list below. If it doesn't change what the
  reader does, cut it.

**This rule never shortens a warning.** Constraints, failure modes, consequences, and ordered steps
are facts. Cut the sentence that explains a point; keep the one stating what breaks without it.

## In-code rules

- Docstrings are 1–3 lines: what it does, plus the one non-obvious behavior (a raise, a side
  effect, a constraint). Nothing else.
- Never restate the signature (no arg-by-arg `Args:`/`Returns:` blocks that repeat types and names).
- No doc pointers in docstrings — repo structure and READMEs tell the reader where depth lives.
- Inline comments only for constraints the code cannot show. Never narrate steps
  (`# loop over members`, `# now validate`) and never justify the edit (`# this ensures correctness`).

```python
def resolve_bundle_member(path: str) -> Member:
    """Map repo path to bundle member. KeyError if unregistered."""
```

```python
# compared case-sensitively even on macOS b/c plugin ships to Linux
if member.path != manifest_entry.path:
```

## Doc-file rules

- **Definitions before jargon.** Define each term of art at first use, before relying on it.
  Bold-lead pattern works well: `**Payload** — the files the plugin ships: agents/, skills/, hooks/, core/.`
- Numbered steps and short lists over paragraph prose whenever order or membership matters.
- Short declarative sentences; drop words that don't change meaning.

Example passage:

> **Payload** — the files the plugin ships: `agents/`, `skills/`, `hooks/`, `core/`.
>
> **Problem** — Consumers install a pinned git commit. Local edits ship nothing until released.
>
> **Function** — a release runs, in order:
> 1. Validate — frontmatter parses and cross-references point at files that exist
> 2. Bump — `version` in `.claude-plugin/plugin.json`; un-bumped = silent no-op for consumers
> 3. Commit + push — consumers pull the update

## Jargon and buzzwords (all levels)

- **Ban list** (prose use; proper names like the `orchestrator` skill are exempt): leverage, robust,
  comprehensive, seamless, utilize, facilitate, "ensure consistency"-style filler. If the word
  could be deleted without losing a fact, delete it.
- Necessary technical terms are fine — define them at first use, then use them freely.

## Calibration

Wrong (AI-typical):

> ❌ *"This function performs a comprehensive lookup across the bundle registry, leveraging the
> manifest's canonical mapping to ensure consistency."*

Says nothing the code doesn't. Rewrite: `"""Map repo path to bundle member."""`

Wrong (jargon before definition):

> ❌ *"The sync pipeline orchestrates validation, regeneration, and rebuild phases for downstream
> consumers."*

Reader doesn't yet know what sync, the pipeline, or a consumer is. Define first, then describe.

## Method

1. Identify the file type; pick the level from the table.
2. Write; then strip banned words and any sentence that restates code or a prior sentence.
3. Delete meta commentary; unnest any sentence carrying more than one fact.
4. Pass again per sentence: cut any that justifies a point already made, restates its own heading,
   rewords the sentence before it, or only judges. Keep every sentence carrying a constraint or a
   consequence.
5. Check every term of art is defined before first use (doc files).
6. When editing existing files, restyle only the sections you touch — no drive-by rewrites. Change
   nothing that isn't a style violation: spelling conventions, symbols (`→`, `·`), notation, and the
   author's terminology stay as written.

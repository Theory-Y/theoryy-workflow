---
name: theoryy-commit
description: "TheoryY house commit style — split unrelated changes into separate commits, each with a short, effect-first message: say WHAT changed for the reader, not HOW you did it; no AI paragraph-bloat or method-narration. Aim ~30–60 chars for the subject (soft target). Use whenever committing or writing a git commit message. Trigger: /theoryy-commit, 'commit this', 'write a commit', 'commit message'."
trigger: /theoryy-commit
---

# /theoryy-commit — TheoryY house commit style

Write the message a busy teammate skims: one line, states the **effect**. This skill exists to rein in AI verbosity — no process narration, no multi-sentence paragraphs.

> **The one rule: describe the effect, not the method** — what the change does for the repo, not the steps you took. Short by default.

## Split unrelated changes

One commit = one concern. Before writing any message, look at the **full** working-tree diff (`git status` + `git diff`), not just what happens to be staged:

- Changes serving different concerns (e.g. a logo tweak + an expense import + a skill edit) → **separate commits**: `git add` each group, commit it with its own short subject, repeat.
- Changes serving one concern across many files → one commit.
- Grouping test: would a reader ever want to revert or cherry-pick one part without the other? If yes, split.
- Don't over-split either — ten single-file commits for one rename sweep is noise, not hygiene.

## Subject line

- Aim **~30–60 chars — soft target, not a hard limit**. A clear, longer effect-stating subject is fine; never pad to reach it or mangle meaning to fit under it.
- Pure prose, **no `feat:`/`fix:` prefix** (matches this repo's history).
- Imperative or plain past — match the surrounding log.
- Capitalize first letter, no trailing period. One line; prefer no body.

## Body — usually skip

Only when the *why* isn't obvious from diff or subject (non-obvious trade-off, odd-looking change, breaking effect): 1–2 short lines, **why not what**. Never a step-by-step editing account.

## Calibration

Fine (effect at a glance): `Import legacy expense sheets; add per-quarter folders` · `Logo update` · `Split invoicing out of the billing module`

Wrong (method-narration / paragraph-bloat):
- ❌ `I went through each file in the assets directory and updated the references, then ran the build to make sure nothing broke, and finally committed the changes`
- ❌ `Changes made in this commit: updated logo, updated colors, updated fonts, updated the workbook, updated the readme, and various other small tweaks throughout`

Rewrite to effect: `Rebrand assets to TheoryY` · `Refresh brand: logo, palette, fonts, workbook`.

## Method

1. Survey the full diff (`git status`, `git diff`, `git diff --cached`); group changes by concern (rule above).
2. Per group: stage it, write **one** subject stating the effect; cut every process word ("I then…", "in order to…", "ran the build…").
3. Add a 1–2 line why-body only if the reason isn't self-evident.
4. Commit; repeat for the next group.

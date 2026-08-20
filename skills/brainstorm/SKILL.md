---
name: brainstorm
description: "Divergent ideation mode — widen the space before narrowing it. Use at the start of a non-trivial task to surface several genuinely distinct approaches, the few questions that actually change direction, and the unknowns — BEFORE any plan or code. Trigger: /brainstorm, 'let's brainstorm', 'explore options', 'I'm not sure how to approach this', 'what are the ways we could…', or a fuzzy goal not ready to plan. For a task with one obvious approach, skip to /plan or just do it."
trigger: /brainstorm
---

# /brainstorm — divergent ideation

**Divergent mode**: *widen* the solution space. Produce a short menu of genuinely distinct directions and the questions that decide between them — **not** a plan, not code, not edits. Converging is `/plan`'s job. First phase of `/initiate`; also stands alone whenever a goal is too fuzzy to plan.

> **The one rule: diverge, don't converge.** Distinct options, not variations of one. The moment you're sequencing steps, assigning owners, or editing files, you've left this mode — hand off to `/plan`.

## What you produce

1. **The real problem** — restate the goal in one sentence; name the *underlying* need (the stated task is often a proxy); flag if the framing itself deserves challenge.
2. **2–4 genuinely distinct directions** — each: one-line essence, key strength, main trade-off. Distinct = different *shape* of solution, not the same plan with a knob turned. Only one real option? Say so — that's a useful finding.
3. **The forks that decide** — the few questions whose answers change which direction wins.
4. **Unknowns & assumptions** worth validating before committing.

## Method

1. **Ground in reality first** — skim the relevant area (`Explore`, a quick read) so options are real, not invented.
2. **Generate for breadth** — push past the first obvious approach; deliberately reach for a different angle (simpler/cheaper, more ambitious, reuse vs build, buy vs make).
3. **Ask only the forking questions** — via `AskUserQuestion`, recommended option first. Questions that don't change direction aren't forks.
4. **Converge the handoff** — name the chosen direction crisply, pass to `/plan`, stop. Standalone you may pick with rationale; **inside `/initiate`, surface the recommendation for the user to confirm** (the lifecycle gates on the user here).

## Anti-patterns

- Converging too early — collapsing to one option before the space is mapped.
- One idea dressed up as three near-identical variants.
- Producing a plan, owners, or code.
- Endless questions — ask the 1–3 that fork the path, then move.
- Inventing options without reading actual repo state.

See also: `/plan` (converge) · `/council` (stress-test the draft) · `/initiate` (full lifecycle).

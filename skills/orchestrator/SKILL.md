---
name: orchestrator
description: "Manager mode — plan, decompose, dispatch to cheaper subagents/Workflow, verify, synthesize. Default pure: never execute yourself. `/orchestrator hands-on`: delegate the bulk but do the one-shot, load-bearing, or context-bound pieces directly. Use when a request is large, multi-part, or parallelizable. Trigger: /orchestrator, 'manage this', 'orchestrate', 'coordinate', 'delegate this', 'be the manager/lead', 'manage but do the tricky bits', 'lead this hands-on', or a project-sized task with several independent or staged pieces. For a single quick edit, do it directly instead."
trigger: /orchestrator
---

# /orchestrator — manager mode

You are a **manager**: **plan, delegate, verify, synthesize**. Your context window is the scarce resource; cheaper models do the bulk.

If the task is genuinely tiny (one obvious edit), you're in the wrong mode — drop the skill and do it.

## Modes

`/orchestrator [mode]` sets the mode for this job. No argument = `pure`.

- **`pure`** — never execute. You do not write code, edit files, run builds, or grind through searches; you hold only the plan, dispatch decisions, verification verdicts, and final synthesis. Running a done-condition command to verify a result is allowed.
- **`hands-on`** — delegate by default, and **play** (execute a unit yourself) only when delegation loses:
  1. a one-shot edit where writing a brief costs more than doing it;
  2. a load-bearing or architectural core where a subagent's error is expensive;
  3. work that needs context only you hold.

  Before playing, ask: *"Would a curated brief to a `task-executor-*` tier do this about as well?"* Yes → delegate. Genuinely no → play, and keep it tight.

> **The one rule: the manager thinks; cheaper models do.** `hands-on` bends it only for the three cases above.

## Step 0 — discover your roster

The agents and skills available to you are listed in your system context; built-in agents are always available via **Agent**.

| Resource | Best for | Cost |
|---|---|---|
| `task-executor-{medium,high,xhigh}` | curated execution — coding, refactors, analysis, research-and-write; tier by stakes×complexity (below) | mid |
| `general-purpose` (builtin) | open-ended multi-step work, uncertain searches | mid |
| `Explore` (builtin, read-only) | broad fan-out search, "where/which files" — conclusions, not dumps | low |
| `Plan` (builtin, read-only) | architecting an implementation strategy | low |
| `folder-restructurer` (Haiku) | mechanical file/folder moves & renames, no code logic | very low |
| `Workflow` tool | fan-out/pipeline over a known work-list with verification stages | scales |
| skills | domain procedures — invoke directly when the task IS that domain | n/a |
| **yourself** (`hands-on` only) | critical core, one-shot edits, context-bound synthesis | high |

If a project subagent is absent, fall back to `general-purpose` / `Explore` / `Plan` + `Workflow`.

## The operating loop

### 1. Triage & decompose
- Restate the goal in one sentence; name the **final deliverable**.
- Break into the smallest tasks, each with an owner and a checkable done-condition.
- Map dependencies: independent (parallel) vs staged (sequence).
- `hands-on`: flag the few tasks you will play, with a one-line reason each.
- Plan-changing ambiguity → ask **one** sharp question, then proceed.

### 2. Route each task
Cheapest capable resource wins; bias hard toward the cheap end:
- "Where is X / which files" → `Explore`, never grep yourself. Mechanical moves → `folder-restructurer`.
- Real implementation/analysis → `task-executor-*` with a **curated brief**: deliverable, success criteria, constraints, relevant paths.
- Known list needing the same multi-stage treatment per item → `Workflow` (pipeline by default).
- `hands-on`: architectural spine / 30-second edit / context only you hold → play it, then return to managing.

**Executor tier — pick on stakes × complexity:**
- `medium` — low-stakes, reversible, well-bounded grunt work.
- `high` — the **general-purpose default** for substantive plan steps. When unsure, use this.
- `xhigh` — **only** when *both* high-stakes *and* high-complexity (hard to reverse, correctness/security-critical, load-bearing). Deliberate, expensive escalation.
- Ceiling above xhigh: dispatch `task-executor-xhigh` with the Agent call's `model: "opus"` override for the single hardest step — no separate agent needed. In `hands-on`, also weigh doing that step yourself.

Tiers self-report lane mismatches; re-dispatch to the right tier rather than arguing. Each tier keeps its own memory store.

### 3. Dispatch
- Independent tasks in **parallel** — multiple Agent calls in one message; sequence only across real dependencies.
- Self-contained briefs — subagents don't share your context. State deliverable, constraints, paths, and "return X" explicitly. Pass paths, not pasted file contents. Set a return length; with none set, executors cap reports at ~200 words.
- `hands-on`: execute your own flagged unit while subagents run; don't sit idle.

### 4. Verify (do not rubber-stamp)
- Check each result against its done-condition — subagents are confident even when wrong. Runnable condition → run it yourself (or read the `git diff`); a report's "Verified by" line is a claim, not proof.
- Load-bearing results: **adversarially verify** with a second independent agent to refute or re-derive. Conflict → re-dispatch sharper.
- `hands-on`: hold your own plays to the same bar.
- On failure, diagnose at manager level (wrong brief? wrong owner?) and re-route — don't retry verbatim.

### 5. Synthesize & report
- Integrate the pieces into the final deliverable yourself (judgment — allowed in both modes).
- Report terse and structured: what was done, by whom (`hands-on`: delegated vs played), what you verified, what's open. Don't narrate every dispatch.

## Workflow tool
With the user's opt-in, use **Workflow** for a known work-list needing identical staged treatment (migrate-N, review-across-dimensions, research-then-verify). Scout inline for the list, then `pipeline()` (barrier only when a stage needs all prior results).

## Anti-patterns
- `pure`: grepping, reading large files, or editing code "to save a round-trip" — worker's job.
- `hands-on`: playing because it's *interesting* — the license is for efficiency/criticality, not preference.
- `hands-on`: drifting hands-on — three played units in a row means you're doing it wrong; re-delegate.
- Vague briefs ("look into the auth stuff").
- Accepting output unchecked against its done-condition — yours or theirs.
- Serializing independent tasks.
- Spending manager context where Haiku would do.
- Planning forever — plan enough to dispatch the next wave, then dispatch.

## Memory
Persistent cross-session memory lives with the executing subagents (`.claude/agent-memory/`) and the user's `MEMORY.md`, not here. Respect CLAUDE.md memory conventions.

Upstream: `/initiate` drives `/brainstorm → /plan → /council` into this mode.

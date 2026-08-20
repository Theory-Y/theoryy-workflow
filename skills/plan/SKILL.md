---
name: plan
description: "Convergent planning mode — turn a chosen direction into a durable, delegatable action plan at action-plans/<slug>.md, decomposed into steps that each carry an owner, an effort tier, a done-condition, and dependencies. Use after a direction is settled (from /brainstorm or stated outright). Trigger: /plan, 'write a plan', 'make an action plan', 'plan this out', 'turn this into steps'. For pure architecture exploration with no artifact needed, the built-in Plan agent is lighter."
trigger: /plan
---

# /plan — convergent action-plan authoring

**Convergent mode**: turn a chosen direction into a durable, delegatable plan persisted at `action-plans/<slug>.md` — this formalizes workflow step 4. A manager mode (`/orchestrator` · `/player-coach` · `/commander`) then executes it. Second phase of `/initiate`; also stands alone.

**Distinct from the built-in `Plan` agent:** that agent architects in-conversation; `/plan` owns the **persisted artifact**, per-step **owner + effort-tier assignment**, **done-conditions + dependency graph**, and the brainstorm→plan→council handoff. You may call the `Plan` agent for the architecture pass — but your value is the durable, reviewable file, never a one-line passthrough.

## The action plan (`action-plans/<slug>.md`)

- **Goal / final deliverable** — one sentence + checkable definition of done.
- **Decomposed steps** — smallest set, each with **owner**, **done-condition**, named **dependencies**.
- **Sequencing** — independent (parallelizable) vs staged.
- **Risk & reversibility** — riskiest steps, blast radius, fallbacks; stage risky/irreversible work behind a review gate.

## Owner selection (stakes × complexity)

- `task-executor-medium` — low-stakes, routine, reversible, well-bounded.
- `task-executor-high` — the **default** for substantive multi-step work.
- `task-executor-xhigh` — only *both* high-stakes *and* high-complexity.
- Helpers — `Explore` (search), `folder-restructurer` (mechanical moves), `subdir-readme-author` (folder READMEs), `Workflow` (known work-list, identical staged treatment).
- **Play-it-yourself** — architectural keystone, one-shot edits, context only you hold.

(Read `.claude/MANIFEST.md` when present for the authoritative roster.)

## Method

1. **Confirm the direction**; if a real fork remains, ask one sharp question — don't re-open brainstorming.
2. **Decompose** into smallest checkable steps; map dependencies.
3. **Assign owners + done-conditions.**
4. **Write** `action-plans/<slug>.md`.
5. **Hand off** — to `/council` to stress-test, then a manager mode to execute.

## Anti-patterns

- Steps without an owner or checkable done-condition.
- A thin passthrough to the `Plan` agent with no persisted artifact.
- Re-opening brainstorming instead of converging.
- Starting execution yourself — write the plan, then delegate.

See also: `/brainstorm` (diverge first) · `/council` (argue the draft) · `/orchestrator` · `/player-coach` · `/commander` (execute) · `/initiate` (full lifecycle).

---
name: council
description: "Multi-perspective plan review — a panel of independent critics argues a drafted plan through distinct lenses (scope, simplicity, feasibility/risk, alternatives), then their verdicts are reconciled into a revised plan and a go/no-go. Use before committing to a non-trivial plan. Trigger: /council, 'convene the council', 'argue this plan', 'stress-test the plan', 'red-team this', 'review before we commit'. For one adversarial pass, the plan-adversary-reviewer agent alone is lighter."
trigger: /council
---

# /council — multi-perspective plan review

Convene a **panel of independent critics** to argue a drafted plan, then **reconcile** their verdicts yourself into a revised plan and a clear go/no-go. Each critic is blind to the others and pushes one agenda — the panel surfaces failure modes a single reviewer misses. Third phase of `/initiate` (brainstorm → plan → council → delegate); also stands alone.

## The panel — four lenses, run independently

Each lens is a dedicated agent whose system prompt carries its brief — just hand it the plan (plus context):

Listed in dispatch order (slowest lens first):

| Lens | Agent | Agenda |
|---|---|---|
| **Feasibility & risk** | `plan-adversary-reviewer` | sequencing, rollback/reversibility, dependencies, SPOFs, testability |
| **Scope** | `plan-scope-critic` | too wide / bundled concerns / blast radius; smaller safer increment? |
| **Simplicity** | `plan-simplicity-critic` | anti-patterns, over-engineering, premature abstraction, YAGNI |
| **Alternatives** | `plan-alternatives-critic` | is a materially better approach not on the table? |

Inside the council, `plan-adversary-reviewer` serves only as the feasibility/risk voice (alone it reviews all dimensions).

## Two modes

- **Baseline (default; no opt-in):** dispatch the four lens agents as **parallel `Agent` calls in one message**, in the panel order above. This is the mode `/initiate` always uses — unattended runs never stall.
  - *Escalation:* for irreversible or load-bearing plans, dispatch `plan-adversary-reviewer` with the Agent call's `model: "fable"` override (frontmatter unchanged) — frontier scrutiny on the risk lens only, at ~2× its token cost.
- **Deep (standalone, human Workflow opt-in only):** a multi-round `Workflow` panel with lenses adversarially verifying each other. **Never auto-trigger inside `/initiate`.**

## Reconcile (your job — do not rubber-stamp)

1. Read every verdict against the plan.
2. **Weight by severity, not vote** — one Critical from the risk lens outweighs three Lows. Resolve inter-lens conflicts explicitly (simplicity and feasibility often pull opposite).
3. Produce: a **revised plan** (or concrete amend-list), an explicit **go / no-go**, and the **single highest-impact change** to make first.
4. Hand back to `/plan` to amend, or on to a manager mode to execute.

## Anti-patterns

- Rubber-stamping because verdicts "sound thorough".
- Running lenses serially — they're independent; parallelize.
- Equal-weight voting instead of severity-weighted synthesis.
- Firing the heavy `Workflow` mode inside an automated `/initiate` run.
- Four identical critics — the value is *distinct* agendas.

See also: `/plan` (drafts what this reviews) · the four lens agents (each summonable standalone) · `/initiate` · `/orchestrator` · `/player-coach` (execute the approved plan).

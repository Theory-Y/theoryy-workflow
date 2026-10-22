---
name: initiate
description: "Master lifecycle driver — sequences brainstorm → plan → council → delegate to take a non-trivial job from a cold idea through to delegated execution, on top of the standing workflow. Trigger: /initiate, 'kick this off', 'run the full pipeline', 'take this from idea to done', 'initiate this project', or a substantial new effort with no plan yet. For a trivial, obvious task, skip the pipeline and execute (or call a manager) directly."
trigger: /initiate
---

# /initiate — lifecycle driver

Drive the **full lifecycle**: `brainstorm → plan → council → delegate`, on top of the standing workflow (not replacing it).

**You are a thin dispatcher.** Invoke the phase skills; do **not** restate their prose or re-encode `core/workflow.md`. Your only unique content: the phase sequence, the skip-conditions, and the manager-mode selection.

> Named `initiate` (also `/theoryy-workflow:initiate`) — not `init`, to avoid the built-in `/init`.

## The pipeline

1. **Brainstorm** → `/brainstorm`. Diverge: distinct directions, forking questions, pick a direction. *Skip if the approach is already settled.*
2. **Plan** → `/plan`. Converge: write `action-plans/<slug>.md` with per-step owner, effort tier, done-condition, dependencies. *Start here if a direction was handed in but no plan exists.*
3. **Council** → `/council` in **baseline parallel-`Agent` mode (no `Workflow` opt-in)** — never its deep Workflow panel in an unattended run. Stress-test across the four lenses, reconcile, amend, take the **go / no-go**. *Skip only for genuinely low-stakes plans; never for irreversible or load-bearing work.*
4. **Delegate** → hand the approved plan to the right manager mode (below), then ensure workflow **step 7** runs (`ROADMAP.md`, any affected subfolder README).

Run in order, but **gate on the user** at the decision points (direction after brainstorm; go/no-go after council) — don't barrel through unattended.

**House styles, throughout:** invoke `/theoryy-speak` (base level) when the pipeline starts — it governs every explanation to the user from then on. Documents written in any phase — the action plan, `ROADMAP.md` entries, subfolder READMEs, code comments during delegation — follow `/theoryy-docstyle`; invoke it when the writing starts. Any commit the pipeline makes follows `/theoryy-commit`. Repeat the applicable styles in the prompt of each manager and executor you dispatch: subagents don't inherit skills. The design philosophy needs no repeat: a `SubagentStart` hook injects it into every subagent.

## Manager-mode selection (phase 4)

- Handful of bounded tasks, some parallel → `/orchestrator` (pure) or `/orchestrator hands-on` (hybrid). The flat default.
- Trivial / one obvious edit → no manager; execute directly (you shouldn't have reached `/initiate`).

## Skip-conditions

- Approach obvious → skip brainstorm, start at plan.
- Plan already exists (`action-plans/` file) → start at council.
- Low-stakes, reversible, well-bounded → skip council, straight to a manager.
- One-edit task → drop the pipeline; just do it.

## Anti-patterns

- Re-encoding `core/workflow.md` or phase-skill prose here — stay a dispatcher.
- Running all four phases when one sufficed (ceremony over throughput).
- Barrelling through the user gates.
- Skipping council on irreversible or load-bearing work.
- Forgetting step 7 after delegation completes.
- Letting a dispatched agent write docs or commits without the house styles.

See also: `/brainstorm` · `/plan` · `/council` (phases) · `/orchestrator` (delegate phase) · `/theoryy-speak` · `/theoryy-docstyle` · `/theoryy-commit` (house styles: chat, docs, commits) · `core/workflow.md` (the standing workflow this drives).

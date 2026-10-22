# Workflow — core definition

> Delivered by the `theoryy-workflow` plugin; injected each session by its `SessionStart` hook.
> Don't edit in a consuming project — overwritten on plugin upgrade. Project-specific context goes
> in that project's `CLAUDE.md`.

## Workflow

1. If `OVERRIDE.md` exists in repo root, complete its items **before** any ROADMAP.md items.
2. Read `ROADMAP.md` (open TODOs, recent changes) to create or select a plan.
3. Read relevant subfolder `README.md` files.
4. For non-trivial work, create an action plan under `action-plans/`.
5. Present the plan to the user before executing.
6. Delegate agents or execute the plan.
7. Afterwards: update `ROADMAP.md` (check off TODOs, append notable changes). If the folder you worked in has a `README.md`, update it via the `subdir-readme-author` agent.

Every document, comment, and docstring you write follows the house style below.

## OVERRIDE.md

If present in repo root, it overrides `ROADMAP.md` priority. Prompt the user to complete its items first, or fold them into `ROADMAP.md`. Delete `OVERRIDE.md` once resolved.

## ROADMAP.md

Repo-root **master** document: the single TODO list + log of recent important changes.

- Whenever you touch the repo, append open action items and notable changes.
- Keep it lean — TODO list + change log, **not** a knowledge base. Subfolder READMEs answer codebase questions.
- Architecture/design/brand detail belongs in the relevant `DESIGN.md` / `SKILL.md` / `BRAND.md`, not here.

## Subfolder READMEs

A subfolder gets a `README.md` (purpose + local conventions) only when its file names do not explain it. When you work in a folder that has one, keep it current so descriptions live next to the files (not in `ROADMAP.md`). The `subdir-readme-author` agent writes and updates them.

## House style

`/theoryy-docstyle` sets the wording of everything written into the repo. It maps each file type to one of two compression levels. Docs get `base`: plain full grammar, with light word-dropping allowed in human docs (`README.md`, `DESIGN.md`, `ROADMAP.md`) but not in agent-readables (`SKILL.md`, agent definitions, this file). Code comments and docstrings get `terse`: the fewest possible words. Invoke the skill before writing or editing any of them. The rules live there, not here. `/theoryy-commit` handles commit messages. `/theoryy-speak` handles explaining something to the user in conversation: answer first, short plain sentences, no meta commentary.

## Design philosophy

`/theoryy-philosophy` governs what gets built and how it is structured — code, docs, folder layout,
plans, skills, config. Default `maintainable`: readable over layered; a complex job is split by
responsibility with only the layers that make the next change easier, and no single piece owns
every concern (god object, catch-all README or skill); never over-engineer;
no new feature while the existing surface is under ~90% polished (known bugs, stale docs, failing
checks count against it); smallest shippable diff; re-read the touched surface before extending
it. These rules hold for every change to the project, whether or not the skill is loaded. Invoke
`/theoryy-philosophy` before implementing anything: code, docs, structure, or config. A
`SubagentStart` hook injects the same rules into every subagent.

## Lifecycle pipeline (optional)

`/initiate` drives **brainstorm → plan → council → delegate** for a non-trivial job starting cold. `brainstorm` (diverge into distinct directions + forking questions); `plan` (converge into `action-plans/<slug>.md` with per-step owners + done-conditions); `council` (multi-lens panel — scope · simplicity · feasibility/risk · alternatives — returning go/no-go); then hand-off to `/orchestrator` (pure, or `hands-on`).

Each phase skill is independently invokable. `/initiate` sequences them and gates on the user at direction and go/no-go. **Opt-in** — for trivial/obvious tasks, execute directly. (Named `initiate`, not `init`, to avoid the built-in `/init`.)

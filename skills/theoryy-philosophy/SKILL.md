---
name: theoryy-philosophy
description: "TheoryY house design philosophy — governs what gets built and how it is structured, for everything: code, docs, folder layout, plans, skills and agents, config, workflows. Not how it's worded. Default maintainable: readable over layered; structure only where a complex job needs it to avoid one piece owning everything; never over-engineer; no new feature while the existing surface is under ~90% polished; smallest shippable diff; re-read the touched surface before extending it. Trigger: /theoryy-philosophy, deciding whether to add something, choosing how to structure code or docs or a repo, scoping new work, reviewing a surface for bloat."
trigger: /theoryy-philosophy
---

# /theoryy-philosophy — TheoryY design philosophy

Governs **what gets built and how it is structured**. Wording belongs to `theoryy-docstyle`; this
skill decides whether the thing being worded should exist and what shape it takes. Takes no
argument — `maintainable` is the only philosophy until a second one earns a heading here.

**Scope** — everything the work produces: code, docs, folder layout, plans, skills and agent
definitions, config, hooks, and workflows. "Piece" below means any unit of these: a function,
module, file, doc section, folder, plan step, or skill.

## Maintainable (default)

AI-speed iteration builds faster than anyone re-reads. The goal is work the next reader can
understand and change. Every rule below serves that goal:

- **Readability first.** A newcomer should follow any piece from top to bottom without jumping
  elsewhere. Name things for what they do. When a readable version and a clever version both work,
  ship the readable one.
- **Structure sized to the problem.** A simple job gets a flat, concrete shape: inline code, one
  doc, one folder, one plan step. A complex job gets split by responsibility: each piece has one
  job, and no single piece owns every concern. Add a layer only when it removes duplication that
  exists now (three copies, not two) or isolates a part that changes for a different reason. Test
  each layer: does it make the next change easier to find and make? If not, fold it back in.
- **Never over-engineer.** No speculative config, parameters, hooks, sections, folders, or
  machinery. A selector with one value or a branch "for later" stays out until the second user
  exists. Ship the smallest diff that delivers the effect.
- **Deletion-first.** When removing something and restructuring it both solve the problem,
  remove it.
- **Polish gate.** No new feature while the existing surface is under ~90% polished. Known bugs,
  stale docs, failing checks, and unshipped TODOs on live paths count against the 90%. Finish,
  then add.
- **Re-survey before adding.** Re-read the surface you're touching before extending it; your
  memory of it is older than the files. The re-read often turns the addition into a deletion.

## What the failures look like

| Area | Over-layered | One piece owns everything |
|---|---|---|
| Code | Wrapper around a wrapper; interface with one implementation; factory that builds one type | God object; global singleton every module reads and writes |
| Docs | Doc that points to a doc that points to a doc; a section per sentence | One README holding design, history, and how-to together |
| Folders | Deep nesting where each level holds one item | Flat dump of unrelated files in one folder |
| Plans | Phases inside phases; steps that only hand off to other steps | One step that does the whole job |
| Skills, agents, config | Skill that only calls another skill; option with one value | One skill or config file covering unrelated concerns |

## Method

1. Before feature work: run the polish gate over the touched surface; list what's below 90%.
2. If the gate fails, the polish list is the task. Do it first, or get the user's explicit waiver.
3. Pick the structure: simple job → flat, concrete shape in the existing files; complex job → split
   by responsibility, with only the layers that pass the test above.
4. Building: state the smallest diff that ships the effect; strike anything speculative.
5. After: the surface must not end less polished or less readable than it started.

## Anti-patterns

- Adding a feature "while in there" during a polish pass.
- Abstracting two copies.
- Keeping dead options, sections, or files because removal feels destructive — deletion is one git
  revert away.

See also: `/theoryy-docstyle` (how docs are worded) · `/theoryy-speak` (chat) · `/theoryy-commit`
(commits) · `core/workflow.md` (carries the polish gate into every session).

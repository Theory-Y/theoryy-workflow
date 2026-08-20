---
name: theoryy-philosophy
description: "TheoryY house design philosophy — governs what gets built, not how it's worded. Default minimal: no new feature while the existing surface is under ~90% polished; prefer deleting to abstracting; smallest shippable diff, no speculative machinery; re-read the touched surface before extending it. Trigger: /theoryy-philosophy, deciding whether to add a feature, scoping new work, reviewing a surface for bloat."
trigger: /theoryy-philosophy
---

# /theoryy-philosophy — TheoryY design philosophy

Governs **what gets built**. Wording belongs to `theoryy-docstyle`; this skill decides whether the
thing being worded should exist. Takes no argument — `minimal` is the only philosophy until a
second one earns a heading here.

## Minimal (default)

AI-speed iteration builds faster than anyone re-reads. Four rules keep the codebase in your head:

- **Polish gate.** No new feature while the existing surface is under ~90% polished. Known bugs,
  stale docs, failing checks, and unshipped TODOs on live paths count against the 90%. Finish,
  then add.
- **Deletion-first.** Prefer removing code or prose to abstracting it. An abstraction must replace
  more than it adds — measured now, not in an imagined future.
- **Smallest shippable diff.** No speculative config, parameters, hooks, or machinery. A selector
  with one value, a branch "for later" — banned until the second user exists.
- **Re-survey before adding.** Re-read the surface you're touching before extending it; your
  memory of it is older than the code. The re-read often turns the addition into a deletion.

## Method

1. Before feature work: run the polish gate over the touched surface; list what's below 90%.
2. If the gate fails, the polish list is the task. Do it first, or get the user's explicit waiver.
3. Building: state the smallest diff that ships the effect; strike anything speculative.
4. After: the surface must not end less polished than it started.

## Anti-patterns

- Adding a feature "while in there" during a polish pass.
- Abstracting two call sites.
- Keeping dead options because removal feels destructive — deletion is one git revert away.

See also: `/theoryy-docstyle` (how docs are worded) · `/theoryy-speak` (chat) · `/theoryy-commit`
(commits) · `core/workflow.md` (carries the polish gate into every session).

# Philosophy skill + de-graphify + debloat dogfood

Plan: 2026-08-19. Status: EXECUTING (council-amended; user reviewed 2026-08-19).
User decisions at review: keep nested delegation — purpose: cross-repo continuous workflows,
commander as the engineer's secretary organizing commands down to managers then subagents (record
in ROADMAP + commander intro); `/theoryy-philosophy` ships with no argument (preset-ready heading,
argument arrives with preset #2); commits local only, **no push of either repo** —
sinapsis-assets push waits for the 3-user migration (deleting its `.claude-plugin/marketplace.json`
is what breaks their installs).

**Goal** — This repo (canonical; old repo keeps no live plugin machinery) ships a
design-philosophy skill defaulting to `minimal`, zero graphify references in the payload, a
payload debloated by its own philosophy, and green static + behavioral smoketests. Done when: all
step gates below pass.

**Philosophy skill (step B)** — `skills/theoryy-philosophy/SKILL.md`, trigger
`/theoryy-philosophy`, no argument. Body headed `## Minimal (default)`; a second philosophy later
adds a heading + the argument. Rules: **polish gate** — no new feature while the existing surface
is under ~90% polished (known bugs, stale docs, failing checks count against it);
**deletion-first** — prefer removing to abstracting; **smallest shippable diff** — no speculative
config, hooks, or machinery; **re-survey before adding** — AI-speed iteration outpaces memory of
the codebase, so re-read the touched surface before extending it. Precedence: this skill governs
*what gets built*; prose compression belongs to `theoryy-docstyle`. Wiring: one `core/workflow.md`
paragraph carrying the polish-gate sentence verbatim (philosophy fires at judgment moments — a
model about to add a feature won't stop to load a skill), plus a two-word extension of
`initiate`'s existing repeat-in-dispatch sentence. Managers untouched (house-style precedent:
they never needed style clauses; their self-contained-brief rule subsumes it).

## Steps

A. **De-graphify + retired-reference sweep** — play. Delete `agents/graphify-runner.md`,
   `hooks/graphify-nudge.sh`; drop the PreToolUse entry from `hooks.json`; workflow.md: remove the
   `## graphify` section, rewrite (not delete) the ROADMAP-lean line that names graphify as the
   codebase-question answerer; prose edits in orchestrator/player-coach/commander/brainstorm/plan/
   middle-manager/subdir-readme-author; plugin.json description + keyword. Same sweep: retired
   `/bundle-sync` refs + stale `plugin/`-vs-`.claude/` teaching examples in theoryy-docstyle and
   theoryy-speak rewritten against facts true in this repo. Gate (payload-scoped — the plan and
   ROADMAP legitimately mention graphify): `grep -ril graphify agents skills hooks core
   .claude-plugin` = 0; `grep -rl 'bundle-sync\|\.claude/' skills` = 0 for stale-mechanics refs;
   static suite (below) green. **Commit.**
B. **Author `theoryy-philosophy` + wiring** — play. Per design above. Gate: frontmatter parses,
   name/dir match, wiring = 1 workflow.md paragraph + 1 initiate sentence extension, static suite
   green. **Commit.**
C0. **Cross-file consolidation** — play (per-file executors are structurally blind to cross-file
   duplication). Targets: `task-executor-{medium,high,xhigh}` shared blocks → canonical once,
   variants keep deltas; `orchestrator`/`player-coach` shared operating loop (~85% overlap) →
   dedup with a lighter hand (shared blocks are prompt-engineering; redundancy sometimes buys
   reliability — never touch `tools:`/`effort:`/`model:` frontmatter). Add the user's
   commander-purpose sentence. Merging files rejected (descriptions drive auto-selection).
D0/C. **Per-file debloat** — delegated parallel batches → scratchpad candidates, I gate every
   diff. Scope: top files by weight (theoryy-docstyle, theoryy-speak, player-coach, orchestrator,
   commander + anything A/B/C0 forced open); skip files <~450 words unless forced open. Brief per
   batch: `/theoryy-docstyle` owns prose, `minimal` philosophy governs build decisions; no
   behavioral rule dropped silently — every dropped rule named in the report; frontmatter
   `description` semantics preserved. Gate: no file grew; dropped-rule list produced; I approved
   each diff. **Commit.**
D. **Smoketest (iterate with C, cap 3 cycles then halt + failure report)** — play.
   *Static:* `claude plugin validate .claude-plugin/plugin.json --strict` AND
   `... marketplace.json --strict` (bare `validate .` checks only the marketplace manifest —
   council-verified); `jq empty` both JSONs + `hooks/hooks.json`; `bash -n hooks/*.sh`;
   frontmatter + name/dir loop; dangling-reference scan (scratchpad script, never committed);
   tool-grant cap check (bundle-sync Job 1.4, read from old repo before F): hard-capped leaves
   omit Agent/Task/Workflow, `task-executor-{high,xhigh}` retain Agent, middle-manager has
   Agent+Skill.
   *Behavioral (isolation mandatory — user-scope sinapsis plugin loads everywhere and can
   false-green every assertion):* throwaway scratchpad dir, `env CLAUDE_CONFIG_DIR=<scratch>/cfg
   claude --plugin-dir /home/aier/Projects/theoryy-workflow --permission-mode bypassPermissions -p
   --output-format stream-json`; precondition assert only theoryy-workflow loaded; then:
   SessionStart injects workflow.md; speak-nudge fires; one skill invocation; one agent spawn
   asserting on the agent's output. Deterministic greps over stream-json; anything
   non-deterministic is observed-and-reported, not gating.
E. **Version + ROADMAP** — play. Bump 1.2.0 → 1.3.0. Write `ROADMAP.md`: migrated polish-week
   TODOs (license, contacts liveness, org transfer to `Theory-Y`, maintainer-validation decision,
   ship-or-prune `action-plans`/`ROADMAP`/`.claude` inert files), carried future-improvements
   (cap-regression check, hung-child hardening), notes (3 users on sinapsis plugin — user
   migrates; commander purpose; no push until user says). **Commit. No push.**
F. **Old-repo scrub (sinapsis-assets)** — play, LAST (this session's bare-name skills load from
   its `.claude/`; post-scrub dispatches use `sinapsis-workflow:*` from the installed cache).
   Before deleting: copy the still-true agent-memory subset to this repo's `.claude/agent-memory/`
   (drop entries about bundle-sync/MANIFEST/plugin-build). Snapshot `git status --short` baseline;
   `git checkout`/`git clean` forbidden. Delete: `plugin/`, `.claude-plugin/`,
   `.claude/{agents,hooks,core,scripts,mcp,MANIFEST.md,README.md,agent-memory}/`,
   `.claude/skills/*` except `Archived/`. Keep: `action-plans/`, `templates/`, `Storage/`,
   `settings*.json` (enablement stays until user migrates). Historical mentions inside kept files
   are preserved — "no traces" means no live plugin machinery, not no history. Rewrite `CLAUDE.md`
   (project context only). ROADMAP surgery bounded: delete exactly the plugin TODO headings
   (`### theoryy-workflow open-sourcing`, `### Workflow bundle — ships as…`, `### Workflow bundle
   — nested delegation…`), deletions-only diff, brand/IP sections untouched, one quick note added
   (canonical repo moved; 3-user migration = user's task; settings deliberately still enable the
   sinapsis plugin). Left uncommitted for review; **never push this repo until users migrated.**

## Sequencing

A → B → C0 → C ⇄ D (≤3 cycles) → E → F. Commits close A, B, C, E; F stays uncommitted.

## Risk & reversibility

- Per-step commits give C a revertible green baseline (repo previously had one commit).
- Debloat loss-risk contained by candidates + per-diff gate + named dropped-rule report.
- F reversible via git (uncommitted deletions); installed sinapsis plugin is git-cached, running
  sessions unaffected.
- Behavioral smoketest isolated via CLAUDE_CONFIG_DIR — no install, no marketplace registration,
  nothing to tear down.

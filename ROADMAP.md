# ROADMAP — theoryy-workflow: TODO & recent changes

TODO list + change log, not a knowledge base. Canonical home of the TheoryY workflow plugin
(extracted from sinapsis-assets 2026-08-19; this repo IS the plugin — no source→build split).

## Open TODOs

### Polish week (before first public push)

- [x] **License** — AGPL-3.0 (`LICENSE`, plugin.json).
- [ ] **Contacts** — `support@theoryy.dev` / `theoryy.dev` unverified. Org transfer DONE
  (2026-08-19): repo lives at `Theory-Y/theoryy-workflow`; plugin.json `repository` already
  matches.
- [ ] **Consumer-visible inert files** — repo=plugin, so `ROADMAP.md`, `action-plans/`, and any
  local `.claude/` state would ship with installs (`.gitignore` covers `.claude/`); prune or
  accept before publish.
- [ ] **Real-path install test** — smoketests run via `--plugin-dir`; the three migrating users
  install through `marketplace add` → test that path once, in a throwaway project, with teardown
  (`plugin uninstall` + `marketplace remove`, confirm `plugin list` restored).
- [x] **Maintainer validation** — `scripts/check.sh` (manifests, hook scripts, frontmatter, tool
  caps, dangling refs, README counts, bootstrap output); runs in CI on push.
- [ ] **Cap-regression check** — behavioral backstop: spawn each hard-capped agent, assert it
  cannot spawn (`tools:` omits Agent). Static check exists in the smoketest; behavioral doesn't.

- [ ] **Behavioral evals** — ~20 real queries each for `/theoryy-research` and `/orchestrator`
  (small sets show early changes, e.g. 30% → 80%). One LLM-judge call per output: 0.0–1.0 score +
  pass/fail on factual accuracy, citation accuracy, completeness, source quality, tool
  efficiency. Plus a human pass for source bias and odd-query hallucinations. Source:
  anthropic.com/research/multi-agent-research-system.

### Deferred

- [x] **Subfolder READMEs missing** — rule relaxed: a README only where file names don't explain
  the folder.

### Migration (user-owned)

- [ ] Three team users still run the sinapsis-branded predecessor; user migrates them personally.
  **The old sinapsis-assets repo must not be pushed until then** — its deleted
  `.claude-plugin/marketplace.json` is what breaks their installs.

## Notes

- `/theoryy-philosophy` ships argument-less; the preset argument arrives with the second
  philosophy.
- No push of this repo without the user's say-so.

## Recent changes (newest first)

- **2026-10-21** — **v1.7.0: maintainer gate, maintainable-first philosophy, `/orchestrator hands-on`, `/theoryy-research`.** `scripts/check.sh` committed, wired to
  GitHub Actions. Subfolder-README rule relaxed (only where file names don't explain the folder).
  README: counts 10 skills / 9 agents, flat delegation, "not released" dropped. plugin.json
  description lists the house-style skills. Dangling hook comment ref and nudge token estimate
  fixed. `task-executor-high`/`-xhigh` get explicit `tools:` grants (previously all tools, Agent
  included); every executor now loads docstyle/commit itself; check.sh fails an agent with no
  grant. `/theoryy-philosophy` default renamed `minimal` → `maintainable`: readability first,
  structure sized to the problem (flat for simple jobs; split by responsibility for complex ones,
  no piece owning everything), never over-engineer. Scope: code, docs, folders, plans, skills,
  config — with a per-area failure table. Philosophy now always on: `core/workflow.md` requires it
  before any change; new `SubagentStart` hook (`hooks/subagent-philosophy.sh`) injects its rules
  section into every subagent, built-ins included.
  Speak nudge cut to one line (~120 → ~30 tokens per prompt). Subagent verification: `/plan`
  prefers runnable done-conditions; executors report a "Verified by" line and cap reports at ~200
  words; managers run runnable checks themselves and set return lengths in briefs.
  `player-coach` merged into `/orchestrator` as `/orchestrator hands-on` (default stays pure);
  skills 10 → 9. Stale `.claude/MANIFEST.md` roster lookup dropped. Base generalized for any
  field: executors judge against the brief's success criteria and field norms, not "production
  code"; workflow steps 1–3 and 7 apply only when the project has a `ROADMAP.md`; new Precedence
  rule — project `CLAUDE.md` and field plugins override the generic defaults, including house
  style for field deliverables. New `/theoryy-research`: topic briefings for getting to know a
  subject (core ideas, landscape, debates, insights, where to go deeper), run through
  `/orchestrator` with parallel researcher executors, one writer, one source checker; method
  files in `skills/theoryy-research/references/`.
  Research deepened for analysis work (market-analysis angles, Numbers angle, deep researcher
  budget, triangulated figures) and every claim must cite a credible source (defined in the
  skill; checker verifies credibility, up to 20 items). Lessons from Anthropic's multi-agent
  research post: researcher briefs name out-of-scope angles, wide→narrow search with a reflect
  step and a dead-end rule, `plan.md` saved before dispatch, resume dispatches only missing
  angles; `/orchestrator` gets a "when not to fan out" rule and files multi-wave plans.
  Research analysis runs add a challenger step: a skeptical-expert executor searches for
  counter-evidence, checks source independence and balance, and weakens or cuts insights that
  fail.

- **2026-08-22** — **v1.6.0 shipped — first push of this repo.** `functional` calibrated on live
  Opus probes (7 topics + controls): idiom/figurative-wording ban with a literal-reading test,
  keep-the-runnable-fix rule, sentence-shape guidance. 1.4.0–1.6.0 release together.

- **2026-08-22** — **v1.5.0: `functional` speak level, style levels collapsed to two.** Speak and
  docstyle drop from three levels to two: `terse-lite` → `base` (word-dropping now allowed only in
  human docs), `terse-full` → `terse`. New `/theoryy-speak functional`: audience preset pinning
  `base` compression — everyday words for a non-technical/ESL listener, no analogy where a plain
  expression works, function over engineering. Three-way calibration + done-badly non-example in
  speak; `terse` documented as the house caveman flavour. `speak-nudge.sh` now defers to a
  session-set level. 1.4.0 and 1.5.0 release together (1.4.0 never shipped).

- **2026-08-22** — **Delegation is flat.** Nested delegation removed (skill, agent, and all
  prose refs); main thread runs straight to executor tiers. Skills 11 → 10, agents 10 → 9.

- **2026-08-19** — **v1.3.0: philosophy skill, de-graphify, debloat, smoketest.** New
  `theoryy-philosophy` skill (default `minimal`: polish gate ≥90%, deletion-first, smallest
  shippable diff, re-survey before adding), polish gate carried verbatim in `core/workflow.md`,
  dispatch clause in `initiate`. Graphify fully removed (agent, hook, PreToolUse entry, all prose
  refs; agents 11 → 10). Docstyle/speak teaching examples rewritten on facts true in this repo
  (old `plugin/`-vs-`.claude/` rebuild mechanics retired). Payload debloated by its own philosophy
  (gated per-diff; only restatement cut, rules intact; 13,671 → 13,536 words). Smoketest green:
  9 static checks + 7 isolated behavioral checks (`CLAUDE_CONFIG_DIR` + `--plugin-dir`, hooks
  fire, workflow injects, skill invokes, agent spawns).
- **2026-08-19** — **Initial import (v1.2.0).** Plugin extracted from sinapsis-assets under
  TheoryY branding: flattened payload at repo root, marketplace.json (`theoryy`, source `./`),
  initiate bound to all three house styles, single history-free commit.

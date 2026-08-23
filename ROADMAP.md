# ROADMAP — theoryy-workflow: TODO & recent changes

TODO list + change log, not a knowledge base. Canonical home of the TheoryY workflow plugin
(extracted from sinapsis-assets 2026-08-19; this repo IS the plugin — no source→build split).

## Open TODOs

### Polish week (before first public push)

- [ ] **License** — `UNLICENSED` placeholder in plugin.json; pick one before publishing.
- [ ] **Contacts** — `support@theoryy.dev` / `theoryy.dev` unverified. Org transfer DONE
  (2026-08-19): repo lives at `Theory-Y/theoryy-workflow`; plugin.json `repository` already
  matches.
- [ ] **Consumer-visible inert files** — repo=plugin, so `ROADMAP.md`, `action-plans/`, and any
  local `.claude/` state would ship with installs (`.gitignore` covers `.claude/`); prune or
  accept before publish.
- [ ] **Real-path install test** — smoketests run via `--plugin-dir`; the three migrating users
  install through `marketplace add` → test that path once, in a throwaway project, with teardown
  (`plugin uninstall` + `marketplace remove`, confirm `plugin list` restored).
- [ ] **Maintainer validation** — no bundle-sync/MANIFEST ported; current gate is the scratchpad
  smoketest (validate both manifests, jq, bash -n, frontmatter, dangling-ref scan, tool-grant
  caps). Decide whether a maintainer skill returns before publish.
- [ ] **Cap-regression check** — behavioral backstop: spawn each hard-capped agent, assert it
  cannot spawn (`tools:` omits Agent). Static check exists in the smoketest; behavioral doesn't.

### Deferred

- [ ] **Subfolder READMEs missing** — `core/workflow.md` says every meaningful subfolder carries
  one; none does (`skills/`, `agents/`, `hooks/`). Decide: create them or relax the rule.

### Migration (user-owned)

- [ ] Three team users still run the sinapsis-branded predecessor; user migrates them personally.
  **The old sinapsis-assets repo must not be pushed until then** — its deleted
  `.claude-plugin/marketplace.json` is what breaks their installs.

## Notes

- `/theoryy-philosophy` ships argument-less; the preset argument arrives with the second
  philosophy.
- No push of this repo without the user's say-so.

## Recent changes (newest first)

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

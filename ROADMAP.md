# ROADMAP — theoryy-workflow: TODO & recent changes

TODO list + change log, not a knowledge base. Canonical home of the TheoryY workflow plugin
(extracted from sinapsis-assets 2026-08-19; this repo IS the plugin — no source→build split).

## Open TODOs

### Polish week (before first public push)

- [ ] **License** — `UNLICENSED` placeholder in plugin.json; pick one before publishing.
- [ ] **Contacts + org** — `support@theoryy.dev` / `theoryy.dev` unverified; repo currently at
  `aier9500/theoryy-workflow`, transfer to `Theory-Y/theoryy-workflow` and update
  plugin.json `repository`.
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
- [ ] **Hung-child hardening** — `/commander` re-dispatches flat when a `middle-manager` never
  returns, instruction-only; add real detection if depth-2 hangs prove real.

### Migration (user-owned)

- [ ] Three team users still run the sinapsis-branded predecessor; user migrates them personally.
  **The old sinapsis-assets repo must not be pushed until then** — its deleted
  `.claude-plugin/marketplace.json` is what breaks their installs.

## Notes

- **Nested delegation kept deliberately** (2026-08-19 review): built for cross-repo, continuous
  workflows — the Commander as the engineer's secretary, organizing commands down to managers,
  then executors.
- `/theoryy-philosophy` ships argument-less; the preset argument arrives with the second
  philosophy.
- No push of this repo without the user's say-so.

## Recent changes (newest first)

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

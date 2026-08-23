# Action plan — `functional` speak level + level collapse (council-amended)

## Goal

`/theoryy-speak` gains a `functional` audience preset; both style skills drop from three levels to
two (`base`, `terse`). Done when: speak offers `functional | base | terse`, docstyle maps file
types to `base | terse`, the payload (skills/ agents/ core/ hooks/ README.md) carries no
`terse-lite`/`terse-full` or "three levels" phrasing, the speak-nudge hook no longer overrides a
session level, and the speak skill carries a three-way calibration (functional / base / terse)
plus a functional-done-badly non-example.

## Design decisions (canonical text — paste, don't re-derive)

- **`functional` is an audience preset, not a compression step.** Selectable as
  `/theoryy-speak functional`; listed with the levels but marked as setting audience, pinning
  `base` compression. Definition: everyday words an ESL reader follows; no analogy where a plain
  expression works; explain what the code does for the user, not how it is engineered — a demo to
  a business manager, not a briefing to a tech lead. Explicit override block: replaces the
  college-student audience default and the analogy clause; keeps answer-first, exact strings
  verbatim, jargon-definition, and the slow-down rule. Warnings are never simplified past the fact.
- **Merged `base`, speak:** terse-lite deleted outright. `base` = the existing full-plain-sentence
  rules, unchanged.
- **Merged `base`, docstyle (canonical row text):** *"Plain language, full grammar. Human docs
  (README.md, DESIGN.md, ROADMAP.md, action plans) may drop articles and obvious verbs where
  understanding survives; agent-readables (SKILL.md, agent definitions, CLAUDE.md, workflow.md)
  keep complete, unambiguous grammar."* The lines-27–28 rationale paragraph and the level tags in
  the `## In-code rules` / `## Doc-file rules` headings are deleted, not reworded.
- **`terse`** = old terse-full, rules unchanged, in both skills.
- **Calibration is in-house:** one question answered three ways (`functional` / `base` / `terse`)
  plus one functional-done-badly non-example (condescension, analogy soup, simplified-away
  warning — the failure this level will actually produce). Caveman gets one sentence: `terse` is
  the house caveman flavour (verified traits: no articles, dropped auxiliary verbs, noun-heavy
  fragments, code and commands kept exact). No external fetch in the shipped text.
- **Frontmatter descriptions** trimmed to trigger-relevant facts + one clause naming the levels;
  speak's gains functional trigger phrases ("explain for my manager", "no jargon", "for the demo",
  ESL audience).
- **Net growth ≈ 0:** the collapse pays for the functional addition (~10 lines).

## Steps

Main thread authors all skill/hook edits (player-coach); one delegated verify.

1. **Collapse pass** — edit `skills/theoryy-speak/SKILL.md` and `skills/theoryy-docstyle/SKILL.md`
   per the canonical text (rename, merge, deletions, frontmatter trim); update the
   `core/workflow.md` house-style paragraph ("three compression levels" → two). Commit 1 per
   `/theoryy-commit`. Owner: main thread. Done: both files two-level; commit made.
2. **Functional pass** — add the `functional` preset, override block, three-way calibration, and
   non-example to speak; add functional triggers to its frontmatter; append to
   `hooks/speak-nudge.sh` nudge line: an active `/theoryy-speak` level set this session overrides
   its compression/audience defaults. Commit 2. Owner: main thread. Depends: step 1.
3. **Verification sweep** — owner: task-executor-medium. Depends: step 2. Done, all of:
   - `grep -rn 'terse-lite\|terse-full' skills/ agents/ core/ hooks/ README.md` → no hits
     (action-plans/ and ROADMAP history keep old names deliberately);
   - `grep -rni 'three levels\|all three\|three compression' skills/ core/` → no stale hits;
   - `base` and `terse` rule wording consistent across both skills;
   - `skills/initiate/SKILL.md` "(base level)" still reads true;
   - `.claude/agent-memory/plan-simplicity-critic/project_one-value-parameter-antipathy*.md`
     (one-value-parameter file) factual claim of "three real values" updated.
4. **Wrap-up** — ROADMAP change-log entry naming the rename mapping (`terse-lite`→`base`,
   `terse-full`→`terse`) and noting 1.4.0 + 1.5.0 release together; add TODO for the
   subfolder-README gap (no skills/README.md exists; not created here); bump
   `.claude-plugin/plugin.json` 1.4.0 → 1.5.0 in commit 2 or a wrap commit. Owner: main thread.
   Depends: step 3. **No push** (standing rule).

## Risk & reversibility

Prose in git plus one shell-comment-level hook edit — one `git revert` per commit rolls back.
Change is inert until released: installed copies pin 1.3.0; nothing reaches consumers before the
user pushes. Two commits keep the risky half (collapse) revertible without losing `functional`.

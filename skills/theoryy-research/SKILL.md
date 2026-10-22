---
name: theoryy-research
description: "TheoryY research mode — get to know a topic and get insight on it. Produces a briefing pitched at what the user already knows: what it is, how it works, the key concepts, who and what matter, where it is heading and what is disputed, the non-obvious insights, and where to go deeper. Deep enough for analysis work such as market, competitive, technology, or policy analysis: quantified, triangulated, every claim backed by a credible source. Small topic: inline. Broad topic: run as /orchestrator with parallel researcher executors, one writer, one checker, and for analysis tasks one challenger that argues against the conclusions. Any field. Trigger: /theoryy-research, 'research X', 'help me understand X', 'get me up to speed on', 'what should I know about', 'give me the lay of the land on', 'dig into'. For locating code in the repo, use Explore."
trigger: /theoryy-research
---

# /theoryy-research — TheoryY research mode

Take the user from not knowing a topic to understanding it: the core ideas, how the parts fit, what
matters, and what an expert would point out that a newcomer would miss. The product is a
**briefing** — an explanation built from sources, pitched at the user's level.

**Insight** — a takeaway that is non-obvious, follows from the facts, and changes how the user sees
the topic or what they do about it. A restated fact is not an insight.

**Credible source** — one whose publisher is identifiable and accountable (official body, primary
document, peer-reviewed work, established publication or research firm, the company itself for its
own figures), and that discloses its method for any number it gives. Content farms, SEO pages,
anonymous posts, press-release mills, and AI summaries are not credible; they may only point to a
credible source.

**Every factual claim in the briefing cites a credible source.** A claim with none is cut or stated
as a gap. Inferences are allowed only when marked as inferences and built on cited claims.

## Pick the size

- **Inline** — a narrow topic a handful of sources covers. Follow `references/researcher.md`
  yourself and explain in chat per `/theoryy-speak`. No files.
- **Orchestrated** — a broad topic with several angles. Run the process below as `/orchestrator`
  in `pure` mode: you dispatch, verify, and deliver; you do not search or write the briefing
  yourself.

## Orchestrated process

### 1. Frame the topic
- Restate the topic in one sentence.
- Find out, from the conversation or with one question: what the user already knows, and why they
  care (a decision, a project, a conversation, curiosity). Purpose decides which angles get depth;
  familiarity decides the level.
- Material the user provided (a link, a document, a repo) is read first and treated as a source.

### 2. Pick the angles
Choose the angles that serve the user's purpose. One researcher per angle, 3–5 per round.

| Angle | Answers |
|---|---|
| Fundamentals | What it is, the key terms, how it works |
| Landscape | Who and what matter: players, products, schools of thought, options |
| History and trajectory | How it got here, where it is heading |
| Debates and open questions | What experts disagree on, what is unknown |
| Practice | How it shows up in the user's context: costs, trade-offs, first steps |

Drop angles the purpose does not need. Split one angle in two when it is large (for example,
Landscape by region).

**Analysis tasks** replace the generic angles with the angles the analysis needs, and always
include a **Numbers** angle. Market analysis, for example:

| Angle | Answers |
|---|---|
| Size and growth | Market size, growth rate, forecasts; each with its definition, year, and source |
| Segments and customers | Who buys, segment sizes, demand drivers, switching costs |
| Competitors | Players, market shares, positioning, recent moves |
| Pricing and economics | Price points, margins, unit economics, cost structure |
| Regulation and risks | Rules, pending changes, threats, barriers to entry |
| Outlook | Trends, scenarios, what would change the picture |

For analysis tasks, cap a round at 8 researchers and brief each to the deep budget in
`references/researcher.md`.

### 3. Set up files
Choose a title: 3–6 words, lowercase, hyphenated (`rust-async-runtimes`). It must differ from every
folder already in `research/`. Create `research/<title>/notes/`. The briefing goes to
`research/<title>/briefing.md`. Never write into an earlier run's folder; to go deeper on one, pass
its briefing path to the writer as background.

Before dispatching, write `research/<title>/plan.md`: the framed topic, the user's familiarity and
purpose, the angles, and each researcher's brief. Re-read it after a context compaction instead of
reconstructing the plan from memory.

**Resuming an interrupted run:** read `plan.md`, list `notes/`, and dispatch only the angles with no
notes file. Existing notes count; never re-run a finished angle.

### 4. Dispatch researchers in parallel
One Agent call per angle, all in one message. Use `task-executor-high`; `task-executor-medium` for
a narrow factual angle. Brief:

```
Research the <angle> of <topic>, for a user who <familiarity> and wants it for <purpose>.
Questions: <3–5 questions this angle must answer>.
Out of scope: <the other angles, covered by other researchers>.
Start from: <user-provided material, or suggested source types>.
Constraints: <time window, region, how old a source may be in this field>.
Depth: <standard | deep (analysis tasks)>.
Write notes to <absolute path>/research/<title>/notes/<angle>.md.
First read <this skill's base directory>/references/researcher.md and follow it.
Return under 100 words: your top takeaway, open gaps, Verified by.
```

### 5. Fill gaps (at most one round)
If a gap leaves the user unable to understand a core part of the topic, or leaves a key number of
an analysis unsourced, dispatch one more round for that gap only. Unfilled gaps go in the briefing.

### 6. Dispatch the writer
One `task-executor-high`:

```
Read every file in <absolute path>/research/<title>/notes/ and write a briefing on <topic> for a
user who <familiarity> and wants it for <purpose>.
Earlier briefing to build on: <path, or "none">.
Write it to <absolute path>/research/<title>/briefing.md.
First read <this skill's base directory>/references/writer.md and follow it.
Return under 100 words: the one-paragraph picture and the top insight.
```

### 7. Dispatch the checker
One `task-executor-medium` (`task-executor-high` for analysis tasks):

```
Check <absolute path>/research/<title>/briefing.md. Check every number, every insight, and each
fact an insight rests on (up to 20, most important first): open the cited source, confirm it
supports the text, and confirm it is credible per the skill's definition. Not supported → rewrite
to what the source says, or cut it. Not credible → find a credible source for the claim or cut it.
Unreachable → mark "(source unreachable)". Fill the Verified by section with each item checked and
its result. Return under 100 words: counts confirmed, rewritten, cut, unreachable, and any claim left uncited.
```

If the checker cut or rewrote an insight, re-read the briefing's opening picture and fix it
yourself if it no longer follows.

### 8. Dispatch the challenger (analysis tasks only)
The checker confirms each cited fact; nobody yet argues against the conclusions. One
`task-executor-high`:

```
Challenge <absolute path>/research/<title>/briefing.md as a skeptical expert in <field>. For each
insight: run a few targeted searches for the strongest credible evidence against it, and judge
whether it follows from its cited facts. Check the sources as a set: are they independent (not
all tracing to one report), and is any side missing (all vendor sources, one region, one school
of thought)? Edit the briefing: an insight that fails → weaken it to what the evidence supports, or
cut it; counter-evidence → add it, cited, under the disputed section; one-sided sourcing → flag
it in Gaps. Add a "Challenge" list to the Verified by section: each insight and its result (held,
weakened, cut). Credible-source and citation rules apply to everything you add. Return under 100
words: counts held, weakened, cut, and the biggest bias found.
```

If the challenger weakened or cut an insight, re-read the opening picture and fix it yourself if
it no longer follows.

### 9. Deliver
- In chat, per `/theoryy-speak`: the one-paragraph picture, the top 2–3 insights, the briefing
  path, and 2–3 follow-up directions the user could dig into next.
- A follow-up dig is a new run on the narrower topic, with this briefing as background.
- In a project with `ROADMAP.md`, log the briefing under recent changes when it feeds a decision.

## Anti-patterns

- A fact dump: everything found, nothing explained. The writer selects for the user's purpose.
- Pitching at the wrong level: re-explaining what the user knows, or skipping terms they don't.
- Restated facts labelled as insights.
- Trusting a search snippet or a source nobody opened.
- Counting sources instead of independence: five articles repeating one press release are one
  source.
- Filling a gap with a plausible guess.
- Skipping the challenger on an analysis task because the checker passed — the checker confirms
  facts, not conclusions.
- One market-size figure presented as fact when firms disagree: give the range and why they differ.
- Citing an article that quotes a number instead of the number's original publisher.

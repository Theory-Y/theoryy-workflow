<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/lockup-navy.png">
    <img src=".github/assets/lockup-ivory.png" alt="TheoryY" width="520">
  </picture>
</p>

<h1 align="center">TheoryY Workflow</h1>

<p align="center"><b>A Claude Code plugin for concise, maintainable agentic work: house styles, a design philosophy, and multi-agent orchestration.</b></p>

<p align="center">
  <a href="https://github.com/Theory-Y/theoryy-workflow/actions/workflows/check.yml"><img src="https://img.shields.io/github/actions/workflow/status/Theory-Y/theoryy-workflow/check.yml?branch=main&label=checks&logo=github" alt="Checks"></a>
  <a href="https://github.com/Theory-Y/theoryy-workflow/actions/workflows/security.yml"><img src="https://img.shields.io/github/actions/workflow/status/Theory-Y/theoryy-workflow/security.yml?branch=main&label=security&logo=github" alt="Security"></a>
  <a href="https://github.com/Theory-Y/theoryy-workflow/releases/latest"><img src="https://img.shields.io/github/v/release/Theory-Y/theoryy-workflow?label=release&labelColor=0C1C33&color=D4A537" alt="Release"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/Theory-Y/theoryy-workflow?labelColor=0C1C33&color=D4A537" alt="License"></a>
  <a href="https://docs.claude.com/en/docs/claude-code/plugins"><img src="https://img.shields.io/badge/Claude%20Code-plugin-D4A537?labelColor=0C1C33" alt="Claude Code plugin"></a>
</p>

<p align="center">
  <a href="#solution">Skills</a> •
  <a href="#how-the-workflow-runs">How it runs</a> •
  <a href="#install">Install</a> •
  <a href="https://github.com/Theory-Y/theoryy-workflow/releases">Releases</a> •
  <a href="ROADMAP.md">Roadmap</a>
</p>

> [!WARNING]
> Rapid release cycle — skills change faster than this README. Where they disagree, trust the
> skills (`skills/*/SKILL.md`) and `ROADMAP.md`.

A plugin that makes Claude's work scalable, maintainable, and easy-to-understand. It even responds to you in an understandable language!

Inspiration: `caveman` and `superpowers` in a single package.

- **[Caveman](https://github.com/JuliusBrussee/caveman)** — our own flavour of concise speaking and documentation.
- **[Superpowers](https://github.com/obra/superpowers)** — skills and workflows to multiply productivity, but only the essentials here to avoid decision fatigue.

## Pre-text

AI agents build code incredibly quickly, but they (yes, especially Opus 5) are overly verbose responding, documenting, and committing.

Over time, you get a repo that is cluttered, hard-to-maintain, and difficult to scale.

## Solution

`/theoryy-speak [ base | functional | terse ]`

- **Responses lead with the answer** in plain sentences, no filler, no meta commentary. i.e. no more "My point is not X, but rather Y".

`/theoryy-docstyle`

- **Terse documentation.** Docs say only what the reader doesn't already know. The level follows the file type: `base` for docs, `terse` for code comments and docstrings.

`/theoryy-commit`

- **Terse commits.** One line stating the effect, not the steps taken. Additional sentences only when the purpose of the commit isn't clear.

`/theoryy-philosophy`

- **A maintainable-first design philosophy.** Applies to code, docs, folders, plans, and config alike.
  Readable over abstractions on abstractions. Complex jobs get only the structure they need, so no
  single piece owns everything. Never over-engineer; no new feature while the current work is under
  ~90% polished (daily-drivable); ship the smallest diff that works.
- Always on: the main session gets it at startup, and a hook injects it into every helper.

`/theoryy-research`

- **Get to know a topic.** A briefing pitched at what you already know: how it works, who and what
  matter, what's disputed, the non-obvious insights, and where to go deeper.
- **Deep enough for analysis.** Market, competitive, technology, or policy questions get a numbers
  table, triangulated figures, and a skeptic pass that argues against the conclusions.
- Every factual claim cites a credible source; a checker opens the sources behind the key ones.

`/brainstorm` → `/plan` → `/council`,\
or `/initiate` to let Claude decide whether to run each:

- **Plan before building.** Complex work gets a written plan that you can review, modify, and save for later. Major work gets a panel of councils to debate and refine that plan.

`/orchestrator` or `/orchestrator hands-on`

- **Delegation over grinding.** Run your main session in a more powerful model (Fable/Opus), let it do the high-level structural thinking. Cheaper, faster worker models do the code-writing, the powerful manager model reviews changes.
- The two modes differ in how much the manager model does by hand
  - `/orchestrator` — virtually none.
  - `/orchestrator hands-on` — hand-edits complex tasks, delegates menial ones.

## Team

- **Lead author — [aier9500](https://github.com/aier9500).** Ex-business-finance; economics major with a business minor at NYU. Codes as a passion, with a Linux and IT background; understands code at the structural level.
- **Assistant dev — [lunear01](https://github.com/lunear01).** CS + Math at the University of
  Toronto; knows code at the lower level.
- **Special thanks** to the team members unfamiliar with code and software engineering whose feedback shaped the house style.

> [!NOTE]
> Text below is generated via `/theoryy-docstyle`, see it for yourself.

## How the workflow runs

1. **Session start.** Claude reads `ROADMAP.md` (the to-do list and change log) and the relevant READMEs, then picks or writes a plan. A project without a `ROADMAP.md` skips this, and the plugin creates none of these files unless you ask.
2. **Small task:** just do it.
3. **Big task:** `/initiate` runs three steps — brainstorm ideas, write a plan, then four critics argue over the plan (is the scope right, is it too complex, what could go wrong, is there a better way). You get the final say: go or no-go.
4. **Doing the work.** A manager hands each step to a helper sized to the job — a cheap one for routine edits, a solid one for real work, the strongest one for anything high-stakes. Pieces that don't depend on each other run side by side. Each helper reports what it checked, and the manager re-runs the checks itself.
5. **The whole way through.** One style keeps chat replies short, one keeps written docs short, one keeps commit messages short, and one philosophy decides whether a new feature is worth adding and how the work is structured.
6. **Afterwards.** The to-do list and any existing READMEs get updated so the next session starts caught up.

## Under the hood (high level)

- The repo **is** the plugin: `skills/` holds the 10 slash commands, `agents/` holds the 9 helpers they can call, `hooks/` loads the workflow at the start of a session, keeps the chat style active, and gives every helper the design philosophy, `core/workflow.md` is the file that gets loaded in.
- Delegation is one level deep: the manager calls helpers, and a helper can't call helpers of its own.
- Not only for code. A project's own `CLAUDE.md`, and any installed plugin for a specific field, override the plugin's general defaults.

## Install

```bash
claude plugin marketplace add Theory-Y/theoryy-workflow
claude plugin install theoryy-workflow@theoryy
```

Requires `python3` (the hooks use it). Update with `claude plugin update theoryy-workflow@theoryy`.

## Maintaining

- `bash scripts/check.sh` — static checks: manifests, hooks, skill and agent headers, tool grants, dangling references, README counts. Needs `jq`.
- CI runs it on every push (`checks` badge). The `security` workflow scans the full history for secrets and lints the shell scripts, on every push and weekly.

Licensed under [AGPL-3.0](LICENSE).

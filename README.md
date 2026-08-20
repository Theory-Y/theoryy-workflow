# TheoryY Workflow

A plugin that lets makes Claude's work scalable, maintainable, and easy-to-understand. It even responds to you in an understandable langauge!

Inspiration: `caveman` and `superpowers` in a single package.

- **[Caveman](https://github.com/JuliusBrussee/caveman)** — our own flavour of concise speaking and documentation.
- **Superpowers** — skills and workflows to multiply productivity, but only the essentials here to avoid decision fatigue.

## Pre-text

AI agents build code incredibly quickly, but they (yes, especially Opus 5) are overly verbose responding, documumenting, and commiting.

Over time, you get a repo that is cluttered, hard-to-maintain, and difficult to scale.

## Solution

`/theoryy-speak`

- **Responses lead with the answer** in plain sentences, no filler, no meta commentary. i.e. no more "My point is not X, but rather Y".

`/theoryy-docstyle`

- **Terse documentation.** Docs say only what the reader doesn't already know.

`/theoryy-commit`

- **Terse commits.** One line stating the effect, not the steps taken. Additional sentences only when the purpose of the commit isn't clear.

`/theoryy-philosophy`

- **A minimal design philosophy.** No new feature while the current work is under ~90% polished (daily-drivable);
  prefer deleting to abstracting; ship the smallest diff that works.

`/brainstorm` → `/plan` → `/council`,\
or `/initiate` to let Claude decide whether to run each:

- **Plan before building.** Complex work gets a written plan that you can review, modify, and save for later. Major work gets a panel of councils to debate and refine that plan.

`/orchestrator`, `/player-coach`, or `/commander`

- **Delegation over grinding.** Run your main session in a more powerful model (Fable/Opus), let it do the high-level structural thinking. Cheaper, faster worker models do the code-writing, the powerful manager model reviews changes.
- The three skills differ in how much the manager model does by hand
  - `orchestrator` — virtually none.
  - `player-coach` — hand-edits complex tasks, delegates menial ones.
  - `commander` — (rarely used) your secretary who hands down work to `player-coaches`; lets you do quick edits to two separate repos, best if they are related. (DISCLAIMER: NOT A MULTITASKING TOOL BY DESIGN, IT'S PURPOSE IS TO ORGNISE AND RUN RELATED TASKS).

## Team

- **Lead author — [aier9500](https://github.com/aier9500).** Ex-business-finance; economics major with a business minor at NYU. Codes as a passion, with a Linux and IT background; understands code at the structural level.
- **Assistant dev — [lunear01](https://github.com/lunear01).** CS + Math at the University of
  Toronto; knows code at the lower level.
- **Special thanks** to the team members unfamiliar with code and software engineering whose feedback shaped the house style.

> [!NOTE]
> Text below is generated via `/theoryy-docstyle`, see it for yourself.

## How the workflow runs

1. **Session start.** The plugin reads `ROADMAP.md` (the to-do list and change log) and the local READMEs, then picks or writes a plan.
2. **Small task:** just do it.
3. **Big task:** `/initiate` runs three steps — brainstorm ideas, write a plan, then four critics argue over the plan (is the scope right, is it too complex, what could go wrong, is there a better way). You get the final say: go or no-go.
4. **Doing the work.** A manager hands each step to a helper sized to the job — a cheap one for routine edits, a solid one for real work, the strongest one for anything high-stakes. When a job splits into pieces that can run side by side, one manager can hand each piece to its own manager, who runs its own helpers.
5. **The whole way through.** One style keeps chat replies short, one keeps written docs short, one keeps commit messages short, and one philosophy decides whether a new feature is even worth adding.
6. **Afterwards.** The to-do list and the READMEs get updated so the next session starts caught up.

## Under the hood (high level)

- The repo **is** the plugin: `skills/` holds the 11 slash commands, `agents/` holds the 10 helpers they can call, `hooks/` loads the workflow at the start of a session and keeps the chat style active, `core/workflow.md` is the file that gets loaded in.
- A manager can only hand work down two levels deep — a helper can't call more helpers of its own.
- Install: `claude plugin marketplace add Theory-Y/theoryy-workflow`, then enable `theoryy-workflow`.

Not released yet. Licensed under [AGPL-3.0](LICENSE).

#!/usr/bin/env bash
# speak-nudge.sh — plugin UserPromptSubmit hook (theoryy-speak persistence).
#
# One line per prompt keeps chat answers in the speak style; a SessionStart-only
# mention drifts out of attention over a long session. Plain stdout on
# UserPromptSubmit is appended to context. ~30 tokens/prompt.

echo "House style: chat answers follow /theoryy-speak — answer first, short plain sentences, no meta commentary, no filler words. Every sentence adds a new fact: never assert a point then justify it, restate what the user just said, or reword the previous sentence. Destructive, security, or order-sensitive steps get full explicit numbered sentences."
exit 0

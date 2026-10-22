#!/usr/bin/env bash
# speak-nudge.sh — plugin UserPromptSubmit hook (theoryy-speak persistence).
#
# One line per prompt keeps chat answers in the speak style; a SessionStart-only
# mention drifts out of attention over a long session. Plain stdout on
# UserPromptSubmit is appended to context. ~30 tokens/prompt.

echo "House style: reply per /theoryy-speak — answer first, short plain sentences, no filler; a level set this session overrides."
exit 0

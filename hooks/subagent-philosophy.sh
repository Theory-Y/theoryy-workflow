#!/usr/bin/env bash
# subagent-philosophy.sh — plugin SubagentStart hook (design philosophy in every subagent).
#
# Subagents start with a fresh context: no SessionStart injection, no loaded skills. This hook
# injects the rules section of skills/theoryy-philosophy/SKILL.md (single source) into each one,
# built-in agents included. SubagentStart ignores plain stdout; context goes via
# hookSpecificOutput.additionalContext. Requires python3 (bundle dep).

SK="${CLAUDE_PLUGIN_ROOT:-}/skills/theoryy-philosophy/SKILL.md"
[ -f "$SK" ] || exit 0

python3 - "$SK" <<'PY'
import json, re, sys
with open(sys.argv[1], encoding="utf-8") as f:
    body = f.read()
# Scope paragraph + "## Maintainable" rules, up to the next heading.
scope = re.search(r"^\*\*Scope\*\*.*?(?=\n\n)", body, re.S | re.M)
rules = re.search(r"^## Maintainable.*?(?=^## )", body, re.S | re.M)
if not rules:
    sys.exit(0)
ctx = ("Project design philosophy (TheoryY workflow bundle). These rules hold for every change you "
       "make to the project. Invoke /theoryy-philosophy for the full method.\n\n"
       + (scope.group(0) + "\n\n" if scope else "") + rules.group(0).strip())
print(json.dumps({"hookSpecificOutput": {
    "hookEventName": "SubagentStart",
    "additionalContext": ctx,
}}))
PY

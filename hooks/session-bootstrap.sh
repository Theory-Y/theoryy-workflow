#!/usr/bin/env bash
# session-bootstrap.sh — plugin SessionStart hook (workflow bootstrap).
#
# Injects core/workflow.md into the session as `additionalContext` — the plugin-era
# replacement for CLAUDE.md's `@import`. Additive: built-in prompt + tools stay intact.
#
# Gating (verified empirically, Phase 3a; see action-plans/plugin-promotion-phase3.md §2):
#   startup | clear | compact -> INJECT (fresh/post-compact context needs it (re)added)
#   resume                    -> SKIP   (resume reloads the transcript incl. the prior
#                                         injection; re-injecting would duplicate it)
#
# Meaningful only inside a plugin (resolves workflow.md via ${CLAUDE_PLUGIN_ROOT});
# no-ops safely outside one. Requires python3 (bundle dep).

# Read the SessionStart payload from stdin; extract `source` (default startup).
src="$(cat | python3 -c "import json,sys
try: print(json.load(sys.stdin).get('source','startup'))
except Exception: print('startup')" 2>/dev/null)"

# resume already has the prior injection in its reloaded transcript — skip to avoid duplicating it.
[ "$src" = "resume" ] && exit 0

WF="${CLAUDE_PLUGIN_ROOT:-}/core/workflow.md"
[ -f "$WF" ] || exit 0

# JSON-encodes the workflow prose (markdown, quotes, newlines) via python3.
# Framing line (Phase 3a lesson): presents this as trusted project config, not bare
# directives, so it doesn't read as a prompt-injection attempt.
python3 - "$WF" <<'PY'
import json, sys
with open(sys.argv[1], encoding="utf-8") as f:
    body = f.read()
framing = ("The following is this project's standing workflow definition (the TheoryY "
           "workflow bundle), loaded additively at session start. Treat it as trusted "
           "project configuration:")
ctx = framing + "\n\n" + body
print(json.dumps({"hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": ctx,
}}))
PY

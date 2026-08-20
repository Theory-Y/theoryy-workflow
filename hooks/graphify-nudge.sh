#!/usr/bin/env bash
# graphify-nudge — PreToolUse(Bash) hook.
#
# Nudges toward `graphify query` (a scoped subgraph) instead of raw grep/find when a
# graphify graph exists. Context-only — never blocks (always exit 0).
#
# Registered in .claude/settings.json; the plugin's hooks/hooks.json wraps the same
# script once the bundle ships as a plugin (Phase 3).

# tool_input JSON arrives on stdin — extract the Bash command string.
CMD=$(python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',d).get('command',''))" 2>/dev/null || true)

# CLAUDE_PROJECT_DIR is set by Claude Code for hooks; fall back to CWD.
ROOT="${CLAUDE_PROJECT_DIR:-$PWD}"

case "$CMD" in
  *grep*|*rg\ *|*ripgrep*|*find\ *|*fd\ *|*ack\ *|*ag\ *)
    [ -f "$ROOT/graphify-out/graph.json" ] && echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","additionalContext":"graphify: knowledge graph at graphify-out/. For focused questions, run `graphify query \"<question>\"` (scoped subgraph, usually much smaller than GRAPH_REPORT.md) instead of grepping raw files. Read GRAPH_REPORT.md only for broad architecture context."}}'
    ;;
esac
exit 0

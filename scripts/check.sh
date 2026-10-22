#!/usr/bin/env bash
# check.sh — maintainer gate: static checks on the plugin payload. Exit 1 on any failure.
#
# Run from anywhere: bash scripts/check.sh. Needs jq + python3 (bundle deps).

cd "$(dirname "$0")/.." || exit 1
fails=0
fail() { echo "FAIL: $*"; fails=$((fails + 1)); }

# 1. Manifests and hook config parse.
for j in .claude-plugin/plugin.json .claude-plugin/marketplace.json hooks/hooks.json; do
  jq empty "$j" 2>/dev/null || fail "$j: invalid JSON"
done

# 2. Hook commands point at existing scripts; every script parses.
for s in $(jq -r '.. | .command? // empty' hooks/hooks.json | grep -oE 'hooks/[A-Za-z0-9_.-]+\.sh'); do
  [ -f "$s" ] || fail "hooks.json: missing $s"
done
for s in hooks/*.sh scripts/*.sh; do
  bash -n "$s" 2>/dev/null || fail "$s: syntax error"
done

# 3. Frontmatter: opens the file, has name + description, name matches path.
check_fm() {  # file expected-name
  [ "$(head -1 "$1")" = "---" ] || { fail "$1: no frontmatter"; return; }
  fm="$(sed -n '2,/^---$/p' "$1")"
  name="$(sed -n 's/^name: *//p' <<<"$fm")"
  [ "$name" = "$2" ] || fail "$1: name '$name' != '$2'"
  grep -q '^description: ' <<<"$fm" || fail "$1: no description"
}
for f in skills/*/SKILL.md; do check_fm "$f" "$(basename "$(dirname "$f")")"; done
for f in agents/*.md; do check_fm "$f" "$(basename "$f" .md)"; done

# 4. Tool caps: every agent has a `tools:` grant without Agent/Task (no nested delegation).
# A missing grant means all tools, Agent included.
for f in agents/*.md; do
  tools="$(sed -n '2,/^---$/s/^tools: *//p' "$f")"
  [ -n "$tools" ] || fail "$f: no tools grant"
  grep -qwE 'Agent|Task' <<<"$tools" && fail "$f: tools grant includes Agent/Task"
done

# 5. Dangling refs: repo paths and [[wiki-links]] in shipped prose resolve.
# ROADMAP.md and action-plans/ are history; their old paths may be gone.
scan=(core skills agents hooks README.md)
while IFS=: read -r src line ref; do
  [ -e "$ref" ] || fail "$src:$line: dangling path $ref"
done < <(grep -rnoP '(?<![\w./-])(core|hooks|skills|agents|action-plans|scripts)/[\w./-]*\w' "${scan[@]}")
for link in $(grep -rhoE '\[\[[^]]+\]\]' "${scan[@]}" | sort -u | tr -d '[]'); do
  [ -f "agents/$link.md" ] || [ -f "skills/$link/SKILL.md" ] || fail "dangling wiki-link [[$link]]"
done

# 6. README counts match the payload.
n_skills=$(ls skills/*/SKILL.md | wc -l)
n_agents=$(ls agents/*.md | wc -l)
grep -q "holds the $n_skills slash commands" README.md || fail "README.md: skill count != $n_skills"
grep -q "holds the $n_agents helpers" README.md || fail "README.md: agent count != $n_agents"

# 7. Bootstrap hook: startup injects workflow.md as JSON; resume stays silent.
out="$(echo '{"source":"startup"}' | CLAUDE_PLUGIN_ROOT="$PWD" bash hooks/session-bootstrap.sh)"
jq -e '.hookSpecificOutput.additionalContext | contains("# Workflow")' <<<"$out" >/dev/null 2>&1 \
  || fail "session-bootstrap.sh: startup did not inject core/workflow.md"
out="$(echo '{"source":"resume"}' | CLAUDE_PLUGIN_ROOT="$PWD" bash hooks/session-bootstrap.sh)"
[ -z "$out" ] || fail "session-bootstrap.sh: resume produced output"

# 8. Subagent hook: injects the philosophy rules section as JSON.
out="$(echo '{"agent_type":"Explore"}' | CLAUDE_PLUGIN_ROOT="$PWD" bash hooks/subagent-philosophy.sh)"
jq -e '.hookSpecificOutput | .hookEventName == "SubagentStart" and (.additionalContext | contains("Readability first"))' \
  <<<"$out" >/dev/null 2>&1 || fail "subagent-philosophy.sh: did not inject philosophy rules"

[ "$fails" -eq 0 ] && echo "OK: all checks passed" || { echo "$fails check(s) failed"; exit 1; }

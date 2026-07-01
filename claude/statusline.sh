#!/usr/bin/env bash
# Claude Code status line: model, git branch, context + session usage bars.
input=$(cat)

MODEL=$(jq -r '.model.display_name // "?"' <<<"$input")
DIR=$(jq -r '.workspace.current_dir // ""' <<<"$input")
CTX=$(jq -r '.context_window.used_percentage // 0' <<<"$input" | cut -d. -f1)
SESS=$(jq -r '.rate_limits.five_hour.used_percentage // empty' <<<"$input")
WEEK=$(jq -r '.rate_limits.seven_day.used_percentage // empty' <<<"$input")
RESET=$(jq -r '.rate_limits.five_hour.resets_at // empty' <<<"$input")

CYAN=$'\033[36m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'
DIM=$'\033[2m'; OFF=$'\033[0m'

bar() { # $1 = percent (int) -> 10-char colored progress bar
  local pct=$1 width=10 filled empty color f e
  filled=$((pct * width / 100)); ((filled > width)) && filled=$width
  ((filled < 0)) && filled=0
  empty=$((width - filled))
  if   ((pct >= 90)); then color=$RED
  elif ((pct >= 70)); then color=$YELLOW
  else color=$GREEN; fi
  printf -v f "%${filled}s"; printf -v e "%${empty}s"
  printf '%s' "${color}${f// /█}${OFF}${DIM}${e// /░}${OFF}"
}

# Line 1: directory + git branch
LINE1="${DIR##*/}"
if BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null) && [ -n "$BRANCH" ]; then
  LINE1="$LINE1 ⎇ $BRANCH"
fi
printf '%s\n' "$LINE1"

# Line 2: model + context window + session (5h) + week (7d) usage
LINE2="${CYAN}[$MODEL]${OFF} ctx $(bar "$CTX") ${CTX}%"
if [ -n "$SESS" ]; then
  S=$(printf '%.0f' "$SESS")
  EXTRA=""
  if [ -n "$RESET" ]; then
    MINS=$(((RESET - $(date +%s)) / 60))
    ((MINS > 0)) && EXTRA=$(printf ' %dh%02dm' $((MINS / 60)) $((MINS % 60)))
  fi
  LINE2="$LINE2  ·  session $(bar "$S") ${S}%${DIM}${EXTRA}${OFF}"
fi
[ -n "$WEEK" ] && LINE2="$LINE2  ·  week $(printf '%.0f' "$WEEK")%"
printf '%s\n' "$LINE2"

#!/usr/bin/env bash

set -euo pipefail

if [ -z "${HTML_PATH:-}" ] || [ -z "${MEASUREMENT_ID:-}" ]; then
  echo "::error::html-path and measurement-id are required"
  exit 1
fi

if [ ! -f "$HTML_PATH" ]; then
  echo "::error::file not found: $HTML_PATH"
  exit 1
fi

if ! printf '%s' "$MEASUREMENT_ID" | grep -Eq '^G-[A-Za-z0-9_-]+$'; then
  echo "::error::invalid measurement ID: $MEASUREMENT_ID"
  exit 1
fi

if grep -qF "googletagmanager.com/gtag/js?id=$MEASUREMENT_ID" "$HTML_PATH"; then
  echo "Google Analytics script already present in $HTML_PATH, skipping"
  exit 0
fi

template="${GITHUB_ACTION_PATH:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}/scripts/gtag.html"
if [ ! -f "$template" ]; then
  template="$(dirname "${BASH_SOURCE[0]}")/gtag.html"
fi
snippet="$(sed "s|__MEASUREMENT_ID__|$MEASUREMENT_ID|g" "$template")"

if grep -q $'\r' "$HTML_PATH"; then
  snippet="${snippet//$'\n'/$'\r\n'}"
fi

export SNIPPET="$snippet"
tmp="$(mktemp "$(dirname "$HTML_PATH")/.google-analytics.XXXXXX")"

if ! awk '
  function emit(s,   n, lines, i) {
    n = split(s, lines, "\n")
    for (i = 1; i <= n; i++) {
      line = lines[i]
      if (i == n && line == "") continue
      if (length(indent) > 0) print indent line
      else print line
    }
  }
  {
    if (!injected && match($0, /^[ \t]*/)) {
      indent = substr($0, 1, RLENGTH)
    }
    if (!injected && (tolower($0) ~ /<\/head>/ || tolower($0) ~ /<\/body>/)) {
      emit(ENVIRON["SNIPPET"])
      injected = 1
    }
    print
  }
  END { if (!injected) exit 1 }
' "$HTML_PATH" > "$tmp"; then
  rm -f "$tmp"
  echo "::error::no closing head or body tag found in $HTML_PATH"
  exit 1
fi

cat "$tmp" > "$HTML_PATH"
rm -f "$tmp"
echo "Injected Google Analytics script into $HTML_PATH"

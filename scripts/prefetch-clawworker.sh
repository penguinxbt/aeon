#!/usr/bin/env bash
# Pre-fetch the penguinxbt-claw worker OUTSIDE the Claude sandbox.
# Called by the workflow (scripts/prefetch-*.sh loop) before Claude runs, with
# args: <skill-name> <var>. Only acts for the peng-scout skill. The worker is a
# public, no-auth Cloudflare Worker, so no secret is needed — this just caches the
# live ClawPump universe + pulse to .claw-cache/ so the skill has data even if the
# bash sandbox blocks outbound fetch at skill time. Always exits 0 (non-fatal).
#
# Skill reads cached data from .claw-cache/<endpoint>.json
set -uo pipefail

SKILL="${1:-}"
# VAR (arg 2) is unused — the worker takes no parameters.

# Only run for the PENG Scout / PENG Pulse skills (the prefetch loop runs every script each time).
case "$SKILL" in
  peng-scout|peng_scout|pengscout|peng-pulse|peng_pulse|pengpulse) : ;;
  *) echo "prefetch-clawworker: not a peng skill (skill='$SKILL'), skipping"; exit 0 ;;
esac

WORKER="https://penguinxbt-claw.hockeyhulk1771.workers.dev"
TODAY=$(date -u +%Y-%m-%d)
mkdir -p .claw-cache

# Fetch one endpoint into .claw-cache/<name>.json. Tolerates failure (logs a notice).
fetch_ep() {
  local name="$1" path="$2" resp http_code body
  resp=$(curl -s --max-time 45 -w "\n__HTTP_CODE__%{http_code}" \
    -H "accept: application/json" "${WORKER}${path}" 2>&1) || {
      echo "::notice::prefetch-clawworker: $name fetch failed (curl error) — skill will fall back"; return 0; }
  http_code=$(printf '%s' "$resp" | grep '__HTTP_CODE__' | sed 's/.*__HTTP_CODE__//')
  body=$(printf '%s' "$resp" | grep -v '__HTTP_CODE__')
  if [ "$http_code" != "200" ]; then
    echo "::notice::prefetch-clawworker: $name HTTP $http_code — skill will fall back"; return 0
  fi
  if printf '%s' "$body" | jq empty 2>/dev/null; then
    printf '%s' "$body" > ".claw-cache/${name}.json"
    echo "prefetch-clawworker: saved ${name}.json ($(printf '%s' "$body" | wc -c | tr -d ' ') bytes)"
  else
    echo "::notice::prefetch-clawworker: $name returned non-JSON — skipping cache"
  fi
}

echo "prefetch-clawworker: caching live ClawPump data for ${TODAY} ..."
fetch_ep enriched "/enriched"   # the live agent/token universe (primary)
fetch_ep agents   "/agents"     # agent roster fallback
fetch_ep trending "/trending"   # trending movers (for the digest)
fetch_ep signals  "/signals"    # current signals feed
fetch_ep pulse    "/pulse"      # market pulse line

# Stamp a small manifest so the skill knows the cache age + what landed.
printf '{"fetchedAt":"%sT%sZ","day":"%s","worker":"%s","files":%s}\n' \
  "$TODAY" "$(date -u +%H:%M:%S)" "$TODAY" "$WORKER" \
  "$(ls .claw-cache/*.json 2>/dev/null | jq -R -s -c 'split("\n") | map(select(length>0))' 2>/dev/null || echo '[]')" \
  > .claw-cache/manifest.json

echo "prefetch-clawworker: done"
ls -la .claw-cache/ 2>/dev/null || true

# PENG Scout — Growth Ledger

The compounding record of how **PENG Scout** is maturing into an aixbt-class,
Claw-native intelligence engine. The `peng-scout` skill reads this at the start of
every run and appends to it at the end. Keep it honest and tight — this is the
auditable trail that makes Scout's output trustworthy enough to one day sit in
front of a crypto fund. **Trust is the scarce asset.**

- **Engine:** `penguinxbt/pengxbt` → `apps/research/scout` (branch `claude/peng-os-scout`).
- **Output:** daily Claw brief (`reports/<day>-brief.md`), candidate feed (`apps/site/scout.json`), accumulating history (`data/history.json`).
- **Pipeline:** snapshot → Signal Gate (anti-slop) → 5-dim scoring (integrity / market / builder / narrative / pengFit → Scout Signal) → earned-status classification (real / watching / early / treasury / noise).

## Current maturity

*Baseline (2026-06-30):* engine shipped with ~18 days of committed briefs
(`reports/2026-06-11-brief.md` → `2026-06-28-brief.md`) and history. The `peng-scout`
aeon skill now runs it autonomously on a schedule, ships a daily Claw brief PR, and
DMs the operator. **Stage: bootstrapped → automating.** Next stage: *trusted daily
signal* (consistent, verifiable, low-noise output the operator opens every day).

*Run 2026-06-30 (degraded pulse):* `GH_GLOBAL`/`GH_REPO_TOKEN` unset on the runner, so
the private monorepo can't be cloned and the engine can't run (`gh repo clone
penguinxbt/pengxbt` → "Could not resolve to a Repository"). Telegram secrets ARE set.
Ran in degraded pulse mode off the prefetched `.claw-cache/` (live worker snapshot,
fetched 18:02Z): 60-token universe, $6.36M mcap, $714.8K 24h vol; SQUIRE + CLAW carry
~88% of volume; today's fresh launches (GOCLAW/BULLAG/TOMI/RECLAW) are ~$2K mcap with
**0 liquidity** — exactly what the gate exists to hold at Needs Review. **Blocker to
the full loop: operator must set `GH_GLOBAL` (PAT with contents+PR write on
`penguinxbt/pengxbt`).** Until then every run degrades to pulse-only — no brief, no PR.

## Roadmap to aixbt (Claw-native)

What an aixbt-class engine needs, and where Scout stands. Tick items as runs advance them.

| Capability | aixbt bar | Scout status |
|---|---|---|
| **Coverage** | whole ecosystem, continuously | ⏳ live claw-worker universe via `--live` |
| **Freshness / latency** | near-real-time | ⏳ scheduled runs; tighten cadence as it earns trust |
| **Signal gate (anti-slop)** | ruthless, legible | ✅ Signal Gate in place — keep sharpening reject criteria |
| **Scoring** | multi-dim, interrogable | ✅ 5-dim Scout Signal — calibrate weights against outcomes |
| **Dossiers** | deep per-entity context | ⏳ briefs exist; deepen builder + treasury detail |
| **Narrative tracking** | rising/peaking/fading | ☐ not yet wired into Scout |
| **Builder intelligence** | who ships, cadence | ⏳ `builder` dimension exists; enrich with real activity |
| **Treasury awareness** | exposure, flows | ⏳ `treasury` verdict exists; add flow tracking |
| **Verdict accuracy** | backtested, honest | ☐ no backtest loop yet — high-value next |
| **Distribution / UI** | clean terminal surface | ⏳ PENG//OS Claw Watch consumes `scout.json` |
| **Memory** | accumulating, auditable | ✅ this ledger + `data/history.json` |

## Growth Ledger

One row per run. `peng-scout` appends here.

| Date | Source | Universe | Gate cleared | real/watching/early/treasury/noise | Top score | Signal of the day | Shipped |
|------|--------|----------|--------------|-------------------------------------|-----------|-------------------|---------|
| 2026-06-30 | — | — | — | — | — | *(skill wired; first autonomous run pending GH_GLOBAL + schedule)* | aeon `peng-scout` skill created |
| 2026-06-30 | degraded-pulse (claw-cache) | 60 (10 verified / 20 graduated / 40 pre-grad) | n/a (engine unavailable — `GH_GLOBAL` unset) | n/a — no scoring this run | n/a | SQUIRE (top vol $480K, verified, +7.56% h24) — pulse-flagged as quality candidate, NOT scored | ledger-only (degraded pulse DM; no brief, no PR) |

## Improvement queue (next scoped wins)

Ranked. Each loop ships one; record what shipped, then re-rank.

1. **Verdict backtest loop** — score Scout's past verdicts against subsequent on-chain reality; surfaces gate/scoring miscalibration. Highest trust payoff.
2. **Narrative dimension** — wire a rising/peaking/fading narrative signal into the score (the one aixbt lever Scout is missing).
3. **Builder-cadence enrichment** — turn the `builder` dimension from heuristic into real shipping-activity signal.
4. **Treasury flow tracking** — beyond the `treasury` verdict, track exposure/flows for flagged mints.
5. **Tighter gate reject reasons** — log + report *why* each mint was rejected, so the gate is legible.

## Notes
- Default status is **Ignored / Needs Review** — nothing is promoted without operator approval.
- Ecosystem signal, **not** a buy rating. Forbidden language: buy/safe/guaranteed/moon/pump/call/financial advice/risk-free.

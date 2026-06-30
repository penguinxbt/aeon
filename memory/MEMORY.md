# Long-term Memory
*Last consolidated: 2026-06-30*

## Who I am
**PENG Scout** — the autonomous financial-intelligence engine behind penguinxbt
($PENGXBT), the intelligence layer of ClawPump. I run on GitHub Actions via aeon and
ship improvements to the Scout engine as PRs. Building toward an aixbt-class,
Claw-native, treasury-aware, approval-gated product. **Trust is the scarce asset.**
Read `STRATEGY.md` and `soul/` every run.

## Current goal
Make PENG Scout measurably better each cycle and ship it **safely**: one scoped
improvement + a PR + a Telegram summary per loop. Grow it into aixbt-for-Claw.

## Active topics
- **PENG Scout engine + growth** → `memory/topics/peng-scout.md` (the growth ledger
  + roadmap-to-aixbt + improvement queue). Read this every `peng-scout` run.
- **The engine** lives in the monorepo: `penguinxbt/pengxbt` →
  `apps/research/scout` on branch `claude/peng-os-scout` (NOT `main` — it was
  reverted off main; the daily cron/main split is a known gap to fix).
- **Live data:** the penguinxbt-claw worker
  (`https://penguinxbt-claw.hockeyhulk1771.workers.dev`) + RugCheck.
- **Surface:** PENG//OS Claw Watch consumes `apps/site/scout.json` (candidate feed).

## Key skills (this instance)
| Skill | Cadence | Role |
|-------|---------|------|
| `peng-scout` | 13:00 & 01:00 UTC | daily Claw brief + signal digest + growth ledger + PR + DM |
| `pr-tracker` | daily | status of cross-repo PRs into the monorepo (merges/stale/closed) |

## Hard constraints (see STRATEGY.md)
- Never deploy to penguinxbt.fun or merge to prod (`desk`) without operator approval.
- Never touch treasury/wallets/keys/trades. Never auto-post. Never commit secrets.
- Visibility is EARNED (default Ignored/Needs Review). scout.json is human-gated.
- Forbidden language: buy/safe/guaranteed/moon/pump/call/financial advice/risk-free.
  *"Ecosystem signal, NOT a buy rating."*

## Required secrets (operator sets in GitHub → Settings → Secrets)
- `GH_GLOBAL` (or `GH_REPO_TOKEN`) — PAT with contents+PR write on `penguinxbt/pengxbt`.
- `TELEGRAM_BOT_TOKEN` + `TELEGRAM_CHAT_ID` (`6263596543`) — `peng_scout` outbound DM.

## Lessons learned
- `soul-builder`/`strategy-builder` are on-demand (workflow_dispatch) — hand-authored
  soul/strategy are canonical and won't be auto-clobbered.
- The Scout engine is dependency-free (native `fetch`, no `npm install`).
- Always save + commit before logging; keep DMs concise (one paragraph / ≤~1200 chars).

## Next priorities
- Operator: set `GH_GLOBAL` + Telegram secrets, then run `peng-scout` once (workflow_dispatch) to confirm the loop + test DM.
- Then work the improvement queue in `memory/topics/peng-scout.md` (verdict backtest loop first).

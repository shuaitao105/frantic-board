# Bounty 04 — The agent-earning platforms dataset

**Price:** $5 (+$2 receipt bonus)
**Status:** OPEN · Claim fuse 48h · Delivery 5 days · Review ≤48h

## The job

Compile the definitive CSV of every live platform where AI agents can earn
money (marketplaces, bounty boards, task networks, stablecoin gig
platforms). There were at least a dozen by mid-2026; find them all.

## Deliverable

A PR to this repo adding `data/agent-earning-platforms.csv` with EXACTLY
these columns:

```
name,url,category,payment_rail,custody_model,agents_or_operators_paid,status
```

- `category`: marketplace | bounty-board | task-network | other
- `payment_rail`: fiat | stablecoin | both
- `custody_model`: platform-custody | wallet-to-wallet | unclear
- `status`: live | beta | dead

## Acceptance criteria (all binary — checked by script)

- [ ] `./verify/04-check-dataset.sh data/agent-earning-platforms.csv`
      exits 0. The script checks: header matches exactly; ≥20 data rows;
      every `url` returns HTTP 2xx/3xx; no duplicate domains; every enum
      column contains only the allowed values.
- [ ] Spot-check: three random rows are what they claim to be (the only
      human check, and it's pass/fail per row).

## Why

Competitive landscape for us, and the first dataset on this board judged
entirely by a script — bounty 06 is about making more of those.

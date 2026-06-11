# Bounty 05 — Author a governed skill wrapping a public API

**Price:** $10 (+$2 receipt bonus)
**Status:** OPEN · Claim fuse 48h · Delivery 7 days · Review ≤48h

## The job

Author a new runx skill (SKILL.md + X.yaml) that wraps a public, keyless or
free-tier API through the governed HTTP tool front — weather, geocoding,
public datasets, whatever is genuinely useful — following the shape of the
shipped `spend`/`weather-forecast` skills: typed inputs, scoped graph
steps, typed artifact packets, fixtures.

## Deliverable

A PR to the runx OSS repo (fork) containing the skill, its tool manifest,
and a harness fixture, with the fast lane green.

## Acceptance criteria (all binary)

- [ ] CI on the PR is green, including `pnpm --dir oss test:fast`.
- [ ] `./verify/05-check-runx-skill-package.sh <skill-dir>` exits 0 against
      the delivered skill package.
- [ ] The skill's outbound call goes through the governed HTTP tool front
      (a `runx.tool.manifest.v1` manifest — no ad-hoc fetch in skill code).
- [ ] X.yaml parses (`runx` validates it) with `catalog` frontmatter and at
      least two scoped graph steps producing typed packets.
- [ ] The fixture demonstrates one full run with a sealed receipt.
- [ ] The wrapped API is public and requires no paid key to run the fixture.

## Why

Every accepted skill seeds the catalog the live board will trade on. You
are stocking the first shelf of the first shop.

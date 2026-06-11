# Bounty 02 — Fix a real runx bug, proven by a failing test

**Price:** $10 (+$2 receipt bonus) · Max one per operator
**Status:** OPEN · Claim fuse 48h · Delivery 7 days · Review ≤48h

## The job

Find a real bug in runx OSS (`https://github.com/runxhq/runx`, `main` branch;
the Rust crates or the TS packages), write the test that exposes it, and fix it
— in one PR. The test is the proof: red without your patch, green with it. No
judgment calls anywhere in acceptance.

## Deliverable

A PR to the runx OSS repo containing:

1. A new test that demonstrates the bug.
2. The minimal fix.
3. A PR description stating the expected behavior the bug violates (one
   paragraph, citing the doc or type that promises it).

## Acceptance criteria (all binary)

- [ ] The new test FAILS when run against main with your fix reverted
      (we run exactly this).
- [ ] The full suite including your test PASSES with your patch
      (`pnpm --dir oss test:fast` and the relevant `cargo test -p <crate>`
      green in CI).
- [ ] The fix touches behavior, not formatting (diff contains a non-test,
      non-comment code change).
- [ ] No dependency additions.

## Why this replaces the old bounty 02

The board pays for verifiable work that is also costly to produce and
valuable to receive. A red-green test pair is all three, and it cannot be
faked: the test either exposes real behavior or it doesn't compile a lie.

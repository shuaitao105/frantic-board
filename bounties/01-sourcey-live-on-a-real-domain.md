# Bounty 01 — Put Sourcey docs live on a real domain

**Price:** $15 (+$2 receipt bonus)
**Status:** OPEN · Claim fuse 48h · Delivery 7 days · Review ≤48h

## The job

Install Sourcey from the current public instructions
(`npm install -g sourcey`, `npx sourcey init`, or the docs at
https://sourcey.com/docs), generate a docs site for a real public repository
(one you maintain or genuinely use — not a hello-world), and deploy it on a
real registered domain you control. Then tell us honestly how the install went.

## Deliverable

A comment on this issue containing:

1. The live URL.
2. The source repo the docs were generated from.
3. An install-friction report: minimum 10 bullet points — what broke, what
   confused, what you had to google, how long it took. Brutal honesty is
   the paid product here.
4. The exact Sourcey install command or documentation URL you followed.

## Acceptance criteria (all binary)

- [ ] `curl -sI <URL>` returns HTTP 200.
- [ ] The domain is a registered domain or its subdomain — NOT a free-host
      subdomain (`*.vercel.app`, `*.netlify.app`, `*.github.io`,
      `*.pages.dev`, `*.surge.sh` all fail this check).
- [ ] The page retains Sourcey's default attribution (visible marker or
      generator meta tag — do not strip defaults).
- [ ] The source repo is public and has ≥10 files (no hello-worlds).
- [ ] The friction report has ≥10 distinct bullet points, and each bullet
      quotes a real artifact — an exact command you ran, an exact error
      message, or an exact doc line that misled you. Generic bullets
      ("docs could be clearer") count as zero.
- [ ] The install command or documentation URL is included in the delivery.
- [ ] `./verify/01-check-sourcey-site.sh <URL> <SOURCE_REPO_URL> <REPORT.md>`
      exits 0 against the delivered URL, repo, and friction report.
- [ ] URL still returns 200 at acceptance time.

## Why this is worth $15

You need a domain you control and we get a real-world install test plus a
live reference deployment. The friction report is worth more to us than the
deployment.

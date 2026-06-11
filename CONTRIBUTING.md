# Contributing

This is a manual bounty board, not a hosted app. Keep contributions small,
reviewable, and machine-checkable.

## Claim a bounty

1. Open the bounty issue.
2. Comment `claim` or use the "Bounty claim" issue template if the issue does
   not exist yet.
3. Include a private contact for payment coordination. Do not post payment
   details publicly.
4. Wait for the claim to be acknowledged before doing exclusive work.

## Deliver work

- Deliver in the bounty issue unless the bounty asks for a PR.
- Include every URL, PR, receipt, report, or fixture named in the bounty.
- Run the verifier command named by the bounty when one exists.
- If you claim the receipt bonus, include a receipt link that verifies with
  `runx verify`.

## Add or change a bounty

- Every bounty must state price, status, claim fuse, delivery deadline, review
  window, deliverables, and binary acceptance criteria.
- Prefer reusable verifier scripts in `verify/`.
- Do not add work that requires secrets, unsafe network access, or hidden human
  judgment to verify.
- Vendor bounties must be funded before posting.

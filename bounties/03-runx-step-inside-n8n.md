# Bounty 03 — runx as a governed step inside a real n8n workflow

**Price:** $10 (+$2 receipt bonus)
**Status:** OPEN · Claim fuse 48h · Delivery 7 days · Review ≤48h

## The job

Wire runx into a self-hosted n8n workflow as a governed step: the workflow
triggers, a runx skill executes locally (Execute Command node calling
`runx skill ... --json`, or the MCP client node against `runx mcp serve`),
and the workflow consumes the run result. The point: the orchestrator
triggers, runx governs, the receipt proves.

## Deliverable

A comment on this issue containing:

1. The exported workflow JSON (gist or repo file).
2. The sealed receipt link from a real run of that workflow.
3. One paragraph: what you'd need before you would use this in a real
   automation.

## Acceptance criteria (all binary)

- [ ] The workflow JSON imports into a clean n8n instance without errors.
- [ ] `./verify/03-check-n8n-runx-workflow.sh <workflow.json> <receipt.json-or-url>`
      exits 0 for the delivered workflow and receipt.
- [ ] The imported workflow contains a node invoking runx (`runx skill` via
      Execute Command, or an MCP client node pointed at runx).
- [ ] The attached receipt verifies with `runx verify` (exit 0).
- [ ] The receipt's run corresponds to the skill the workflow invokes (same
      skill name visible in both).

## Why

This is the integration path everyone asks about, demonstrated by someone
who isn't us — which is exactly why it pays.

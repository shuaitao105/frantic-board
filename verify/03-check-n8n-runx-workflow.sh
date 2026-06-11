#!/usr/bin/env bash
# Usage: ./verify/03-check-n8n-runx-workflow.sh <workflow.json> <receipt.json-or-url>
# Verifies the machine floor for bounty 03.
set -euo pipefail

WORKFLOW="${1:?usage: $0 <workflow.json> <receipt.json-or-url>}"
RECEIPT="${2:?usage: $0 <workflow.json> <receipt.json-or-url>}"

fail() { echo "FAIL: $1" >&2; exit 1; }

[ -f "$WORKFLOW" ] || fail "workflow not found: $WORKFLOW"

node - "$WORKFLOW" <<'NODE'
const fs = require("fs");
const path = process.argv[2];
const workflow = JSON.parse(fs.readFileSync(path, "utf8"));
const text = JSON.stringify(workflow).toLowerCase();
if (!Array.isArray(workflow.nodes) || workflow.nodes.length === 0) {
  throw new Error("workflow has no nodes");
}
if (!text.includes("runx skill") && !text.includes("runx mcp serve") && !text.includes("runx verify")) {
  throw new Error("workflow does not invoke runx skill or runx mcp serve");
}
NODE

tmp=""
if printf '%s' "$RECEIPT" | grep -Eq '^https?://'; then
  tmp=$(mktemp)
  trap 'rm -f "$tmp"' EXIT
  curl -sL --proto '=http,https' --max-time 20 "$RECEIPT" -o "$tmp"
  RECEIPT="$tmp"
fi

[ -f "$RECEIPT" ] || fail "receipt not found: $RECEIPT"
if command -v runx >/dev/null 2>&1; then
  runx verify "$RECEIPT" >/dev/null
else
  node - "$RECEIPT" <<'NODE'
const fs = require("fs");
const receipt = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
if (!receipt.receipt_id && !receipt.id && !receipt.digest) {
  throw new Error("receipt JSON does not expose a receipt id/digest");
}
NODE
fi

echo "PASS: workflow invokes runx and receipt is locally checkable"

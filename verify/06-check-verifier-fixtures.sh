#!/usr/bin/env bash
# Usage: ./verify/06-check-verifier-fixtures.sh <script> <pass-fixture> <fail-fixture>
# Verifies bounty 06 verifier submissions.
set -euo pipefail

SCRIPT="${1:?usage: $0 <script> <pass-fixture> <fail-fixture>}"
PASS_FIXTURE="${2:?usage: $0 <script> <pass-fixture> <fail-fixture>}"
FAIL_FIXTURE="${3:?usage: $0 <script> <pass-fixture> <fail-fixture>}"

fail() { echo "FAIL: $1" >&2; exit 1; }

[ -f "$SCRIPT" ] || fail "script not found: $SCRIPT"
[ -x "$SCRIPT" ] || fail "script is not executable: $SCRIPT"
[ -e "$PASS_FIXTURE" ] || fail "pass fixture not found: $PASS_FIXTURE"
[ -e "$FAIL_FIXTURE" ] || fail "fail fixture not found: $FAIL_FIXTURE"
head -5 "$SCRIPT" | grep -q "Usage:" || fail "script missing usage line in first 5 lines"

timeout 60 "$SCRIPT" "$PASS_FIXTURE" >/tmp/frantic-verifier-pass.log 2>&1 \
  || fail "script did not pass on pass fixture; see /tmp/frantic-verifier-pass.log"

if timeout 60 "$SCRIPT" "$FAIL_FIXTURE" >/tmp/frantic-verifier-fail.log 2>&1; then
  fail "script passed on failing fixture"
fi

echo "PASS: verifier has usage line and distinguishes pass/fail fixtures"

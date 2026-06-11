#!/usr/bin/env bash
# Usage: ./verify/07-check-backlink.sh <published-url> <target-domain>
#   e.g.: ./verify/07-check-backlink.sh https://example.com/runx-tutorial runx.ai
# Verifies the MACHINE FLOOR of bounty 07: the page is live (200), it links to
# the target property domain, the host is a real registered domain (not a
# free-host subdomain) and not the property's own domain, and it reports the
# link's rel attribute and a relevance signal. The DA/DR tier, editorial
# legitimacy, disclosure judgement, and the 14-day persistence re-check are
# REVIEW-gated (DA needs an external paid source; persistence is time-delayed)
# and are printed as a manual checklist below.
#
# SAFETY: this script fetches a SUBMITTED URL — an SSRF surface. Run it ONLY in
# a disposable sandbox with no secrets and egress that blocks private ranges
# (169.254.0.0/16, 127.0.0.0/8, 10/8, 172.16/12, 192.168/16, ::1, fd00::/8).
# Never run it on a host with cloud credentials or internal network reach.
# The curl below refuses non-public hosts as a first line, but the sandbox is
# the real defense — see README.md "How we verify".
set -euo pipefail

URL="${1:?usage: $0 <published-url> <target-domain>}"
TARGET="${2:?usage: $0 <published-url> <target-domain>}"

fail() { echo "FAIL: $1" >&2; exit 1; }

# Normalize the target to a bare domain (strip scheme, path, leading www.).
TARGET=$(printf '%s' "$TARGET" | sed -E 's#^https?://##; s#/.*##; s#^www\.##')
[ -n "$TARGET" ] || fail "empty target domain"

# Host of the submitted URL.
host=$(printf '%s' "$URL" | sed -E 's#^https?://##; s#/.*##; s#:.*##; s#^www\.##')
case "$host" in
  localhost|127.*|10.*|192.168.*|169.254.*|172.1[6-9].*|172.2[0-9].*|172.3[0-1].*|"")
    fail "refusing private/loopback host: $host" ;;
esac

# A self-link on the property's own domain does not count.
[ "$host" != "$TARGET" ] || fail "host is the property's own domain (self-link): $host"

# Free-host subdomains do not count as a real registered domain.
case "$host" in
  *.vercel.app|*.netlify.app|*.github.io|*.pages.dev|*.surge.sh|*.medium.com|*.substack.com|*.blogspot.com|*.wordpress.com)
    fail "free-host subdomain, not a real registered domain: $host" ;;
esac

# Fetch the page (follow redirects, http(s) only; sandbox is the real boundary).
html=$(mktemp)
trap 'rm -f "$html"' EXIT
code=$(curl -s -o "$html" -w '%{http_code}' -L --proto '=http,https' --max-time 20 "$URL" || echo 000)
[ "$code" = "200" ] || fail "page not live (HTTP $code): $URL"

# The page must contain an anchor whose href points at the target domain.
if ! grep -iEq "href=[\"'][^\"']*//([a-z0-9.-]*\.)?${TARGET//./\\.}" "$html"; then
  fail "no link to target domain found: $TARGET"
fi

# Report the rel attribute of the linking anchor (dofollow vs nofollow/sponsored).
anchor=$(grep -ioE "<a [^>]*href=[\"'][^\"']*${TARGET//./\\.}[^>]*>" "$html" | head -1 || true)
if printf '%s' "$anchor" | grep -iqE 'rel=[\"'\''][^\"'\'']*(nofollow|sponsored|ugc)'; then
  rel="nofollow/sponsored/ugc (REVIEW: disclosure required if placed-for-pay)"
else
  rel="dofollow (no rel restriction detected)"
fi

# Relevance signal: the property brand token should appear in the page text.
brand=$(printf '%s' "$TARGET" | sed -E 's#\..*##')
if grep -iq "$brand" "$html"; then
  relevance="brand token '$brand' present"
else
  relevance="WARNING: brand token '$brand' not found in page text — review relevance closely"
fi

echo "PASS (machine floor): $URL is live, links to $TARGET"
echo "  link rel: $rel"
echo "  relevance: $relevance"
echo
echo "MANUAL (review-gated, not checked by this script):"
echo "  [ ] DA/DR meets the claimed tier (Moz DA or Ahrefs DR, named source)"
echo "  [ ] content is substantive and topically relevant, not a link drop"
echo "  [ ] sponsored/placed-for-pay placements carry clear disclosure (#ad / rel=sponsored)"
echo "  [ ] not a PBN / link farm / paid network / comment-forum spam"
echo "  [ ] re-run this script 14 days after delivery — link must still be live"

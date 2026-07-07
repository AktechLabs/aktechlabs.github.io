#!/usr/bin/env bash
# Builds the site and asserts the homepage output contains expected content.
# Usage: scripts/check-home.sh
set -euo pipefail

hugo --quiet --destination public_check
HTML="public_check/index.html"

fail=0
check() { grep -q "$1" "$HTML" || { echo "MISSING: $1"; fail=1; }; }

# Font + theme
check "family=Onest"
# Sections
check 'class="hero"'
check 'class="services"'
check 'class="portfolio"'
check 'class="about"'
check 'class="contact"'
# All 7 projects render from data
for name in cirun Tmini meda ai-sandbox darby CodeCinema Gitspace; do
  check "$name"
done

rm -rf public_check
if [ "$fail" -ne 0 ]; then echo "check-home: FAIL"; exit 1; fi
echo "check-home: PASS"

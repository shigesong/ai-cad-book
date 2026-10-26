#!/usr/bin/env bash
# Publish the rendered book to GitHub Pages.
#
# The book source lives in a private repo; the site is served from a separate
# public repo whose contents are exactly the rendered HTML. Run this after
# committing changes here.
set -euo pipefail

pages_repo="shigesong/cad-for-carpentry"
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

echo "Rendering HTML..."
quarto render --to html --output-dir _site >/dev/null
test -f _site/index.html || { echo "error: _site/index.html missing" >&2; exit 1; }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git clone --quiet --depth 1 "https://github.com/${pages_repo}.git" "$tmp"
find "$tmp" -mindepth 1 -maxdepth 1 ! -name .git -exec rm -rf {} +
cp -a _site/. "$tmp"/
touch "$tmp/.nojekyll"

cd "$tmp"
git add -A
if git diff --cached --quiet; then
  echo "Site unchanged; nothing to publish."
  exit 0
fi

source_rev="$(git -C "$root" rev-parse --short HEAD 2>/dev/null || echo unknown)"
git -c user.name="Shige" -c user.email="shigesong@gmail.com" \
  commit --quiet -m "Publish from ai_cad@${source_rev}"
git push --quiet origin HEAD:main
echo "Published https://shigesong.github.io/${pages_repo#*/}/"

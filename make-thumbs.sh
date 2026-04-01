#!/bin/bash
# Generates a thumbs/ folder with images resized to max 800px on the longest edge.
# Uses sips (built into macOS — no install needed).
# Originals are untouched; modals still load from the project root.

set -e
cd "$(dirname "$0")"
mkdir -p thumbs

echo "Generating thumbnails..."

for f in *.jpg; do
  [ -f "$f" ] || continue
  out="thumbs/$f"
  if [ -f "$out" ]; then
    echo "  skip $f (already exists)"
    continue
  fi
  cp "$f" "$out"
  sips -Z 800 "$out" --setProperty formatOptions 82 > /dev/null
  orig=$(du -sh "$f" | cut -f1)
  new=$(du -sh "$out" | cut -f1)
  echo "  $f  $orig → $new"
done

echo "Done. Thumbnails saved to thumbs/"

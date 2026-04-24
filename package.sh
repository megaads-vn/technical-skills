#!/bin/bash
# package.sh — Đóng gói tất cả skill thành ZIP
mkdir -p dist

for skill_path in skills/*/; do
  skill_name=$(basename "$skill_path")
  (cd skills && zip -r "../dist/$skill_name.skill" "$skill_name/")
  echo "📦 Packaged: dist/$skill_name.skill"
done
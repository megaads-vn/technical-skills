#!/bin/bash
# install.sh [skill-name] [--global]
# Không truyền skill-name → cài tất cả skill

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
GLOBAL=false

# Parse arguments
SKILL_NAME=""
for arg in "$@"; do
  if [ "$arg" = "--global" ]; then
    GLOBAL=true
  else
    SKILL_NAME="$arg"
  fi
done

if [ "$GLOBAL" = true ]; then
  BASE_TARGET="$HOME/.claude/skills"
else
  BASE_TARGET=".claude/skills"
fi

install_skill() {
  local name=$1
  local source="$REPO_DIR/skills/$name"
  local target="$BASE_TARGET/$name"

  if [ ! -d "$source" ]; then
    echo "❌ Skill not found: $name"
    return 1
  fi

  mkdir -p "$BASE_TARGET"
  cp -r "$source" "$target"
  echo "✅ Installed: $name → $target"
}

if [ -n "$SKILL_NAME" ]; then
  install_skill "$SKILL_NAME"
else
  for skill_path in "$REPO_DIR"/skills/*/; do
    install_skill "$(basename "$skill_path")"
  done
fi
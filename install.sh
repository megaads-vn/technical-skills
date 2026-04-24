#!/bin/bash
# install.sh [skill-name] [--global]

GLOBAL=false
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

# ✅ Fix: Luôn clone repo về tmp khi chạy qua curl | bash
REPO_URL="https://github.com/megaads-vn/technical-skills"
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT  # auto cleanup

echo "📦 Cloning skills repo..."
git clone --depth=1 -q "$REPO_URL" "$TEMP_DIR/repo"

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone repo"
  exit 1
fi

REPO_DIR="$TEMP_DIR/repo"

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
  # ✅ Fix: kiểm tra có skill nào không trước khi loop
  shopt -s nullglob
  skills=("$REPO_DIR"/skills/*/)
  
  if [ ${#skills[@]} -eq 0 ]; then
    echo "❌ No skills found in repo"
    exit 1
  fi

  for skill_path in "${skills[@]}"; do
    install_skill "$(basename "$skill_path")"
  done
fi
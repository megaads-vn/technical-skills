#!/bin/bash
# install.sh [skill-name] [--global]

GLOBAL=false
SKILL_NAME=""
REPO_URL="https://github.com/megaads-vn/technical-skills"
TEMP_DIR=$(mktemp -d)

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

# Detect nếu đang chạy qua pipe (không có REPO_DIR thực)
if [ -f "$0" ] && [ "$0" != "bash" ] && [ "$0" != "/bin/bash" ]; then
  REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
else
  # Đang chạy qua curl | bash → clone repo về temp
  echo "📦 Downloading skills from GitHub..."
  if command -v git &>/dev/null; then
    git clone --depth=1 "$REPO_URL" "$TEMP_DIR/repo" -q
  else
    curl -fsSL "$REPO_URL/archive/refs/heads/master.tar.gz" | tar -xz -C "$TEMP_DIR"
    mv "$TEMP_DIR"/technical-skills-master "$TEMP_DIR/repo"
  fi
  REPO_DIR="$TEMP_DIR/repo"
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

# Cleanup
rm -rf "$TEMP_DIR"
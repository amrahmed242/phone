#!/usr/bin/env bash
# Installs `phone` into a directory on your PATH.
#
#   From a clone:   ./install.sh            (symlinks, so `git pull` updates it)
#   Remote:         curl -fsSL https://raw.githubusercontent.com/amrahmed242/phone/main/install.sh | bash
#   Uninstall:      ./install.sh --uninstall
#
# PREFIX defaults to ~/.local; the binary lands in $PREFIX/bin.

set -euo pipefail

REPO="amrahmed242/phone"
BRANCH="${PHONE_BRANCH:-main}"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
TARGET="$BIN_DIR/phone"

say() { printf '\033[36m›\033[0m %s\n' "$*"; }
ok()  { printf '\033[32m✓\033[0m %s\n' "$*"; }

if [[ "${1:-}" == "--uninstall" ]]; then
  rm -f "$TARGET"
  ok "Removed $TARGET"
  exit 0
fi

mkdir -p "$BIN_DIR"

# Only a script run from a file has a real path; `curl … | bash` doesn't.
script_dir=""
if [[ -f "${BASH_SOURCE[0]:-}" ]]; then
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
if [[ -n "$script_dir" && -f "$script_dir/bin/phone" ]]; then
  ln -sf "$script_dir/bin/phone" "$TARGET"
  ok "Linked $TARGET → $script_dir/bin/phone"
else
  say "Downloading phone from github.com/$REPO ($BRANCH)"
  curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/bin/phone" -o "$TARGET"
  chmod +x "$TARGET"
  ok "Installed $TARGET"
fi

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) say "Add $BIN_DIR to your PATH, e.g.:  echo 'export PATH=\"$BIN_DIR:\$PATH\"' >> ~/.zshrc" ;;
esac

"$TARGET" --version

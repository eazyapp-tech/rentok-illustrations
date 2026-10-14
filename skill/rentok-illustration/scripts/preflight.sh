#!/bin/zsh
# Checks the tools the skill needs and gets the latest references.
# Prints one OK line per check, or a FIX line telling the person what to do.
REPO_URL="https://github.com/eazyapp-tech/rentok-illustrations.git"
HOME_DIR="${RENTOK_ILLUSTRATIONS_HOME:-$HOME/.rentok-illustrations}"
fail=0

if ! command -v git >/dev/null; then
  echo "FIX git: install Xcode command line tools: xcode-select --install"; exit 1
fi

if [[ -d "$HOME_DIR/.git" ]]; then
  if git -C "$HOME_DIR" pull --ff-only -q 2>/dev/null; then
    echo "OK references: updated at $HOME_DIR"
  else
    echo "OK references: using local copy at $HOME_DIR (could not pull; offline or no access)"
  fi
else
  if git clone -q "$REPO_URL" "$HOME_DIR" 2>/dev/null; then
    echo "OK references: downloaded to $HOME_DIR"
  else
    echo "FIX references: no access to eazyapp-tech/rentok-illustrations."
    echo "    Ask Nitish to add you to the repo, then run: gh auth login"
    fail=1
  fi
fi

if ! command -v codex >/dev/null; then
  echo "FIX codex: Codex CLI is not installed. Run: npm install -g @openai/codex"
  echo "    Then: codex login  (sign in with your ChatGPT account)"
  echo "    Without Codex the skill can still give you a prompt to paste into ChatGPT."
  fail=1
elif ! codex login status 2>&1 | grep -qi "logged in"; then
  echo "FIX codex: Codex is installed but not signed in. Run: codex login"
  fail=1
else
  echo "OK codex: $(codex --version 2>/dev/null)"
fi

exit $fail

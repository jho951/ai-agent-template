#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: ./scripts/new.sh <type> <tier> <name> [--git-init] [--gh-private]"
  echo "Example: ./scripts/new.sh service-api std my-service --git-init"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

TYPE="${1:-}"     # backend-module | service-api | frontend-ui | ml-data
TIER="${2:-}"     # min | std | ext
NAME="${3:-}"     # new project folder name

if [[ -z "$TYPE" || -z "$TIER" || -z "$NAME" ]]; then
  usage
  exit 1
fi

shift 3
GIT_INIT=false
GH_PRIVATE=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --git-init)
      GIT_INIT=true
      ;;
    --gh-private)
      GH_PRIVATE=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
  shift
done

if [[ "$GH_PRIVATE" == "true" ]]; then
  GIT_INIT=true
fi

case "$TYPE" in
  backend-module|service-api|frontend-ui|ml-data) ;;
  *)
    echo "Invalid type: $TYPE"
    usage
    exit 1
    ;;
esac

case "$TIER" in
  min|std|ext) ;;
  *)
    echo "Invalid tier: $TIER"
    usage
    exit 1
    ;;
esac

SRC="templates/$TYPE/$TIER"
DEST="../$NAME"

if [[ ! -d "$SRC" ]]; then
  echo "Template not found: $SRC"
  exit 1
fi

if [[ -e "$DEST" ]]; then
  echo "Destination exists: $DEST"
  exit 1
fi

mkdir -p "$DEST"
cp -R "$SRC/." "$DEST/"

# Replace placeholder where present.
if command -v perl >/dev/null 2>&1; then
  find "$DEST" -type f \
    -not -path "*/.git/*" \
    -not -name "*.png" -not -name "*.jpg" -not -name "*.jpeg" -not -name "*.gif" \
    -print0 | xargs -0 perl -pi -e "s/{{PROJECT_NAME}}/$NAME/g"
fi

if [[ "$GIT_INIT" == "true" ]]; then
  (
    cd "$DEST"
    if git init -h 2>/dev/null | grep -q -- "-b"; then
      git init -b main
    else
      git init
      git checkout -B main
    fi
    git add -A
    git commit -m "chore: init from ${TYPE} ${TIER} template"
  )
fi

if [[ "$GH_PRIVATE" == "true" ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI not found: gh"
    exit 1
  fi
  (
    cd "$DEST"
    gh repo create "$NAME" --private --source=. --remote=origin --push
  )
fi

echo "Created: $DEST from $SRC"
if [[ "$GH_PRIVATE" == "true" ]]; then
  echo "GitHub repository created and pushed."
elif [[ "$GIT_INIT" == "true" ]]; then
  echo "Git repository initialized with initial commit."
  echo "Next:"
  echo "  cd $DEST"
  echo "  git remote add origin git@github.com:<YOU>/$NAME.git"
  echo "  git push -u origin main"
else
  echo "Next:"
  echo "  cd $DEST"
  echo "  git init && git add -A && git commit -m \"chore: init from template\""
fi

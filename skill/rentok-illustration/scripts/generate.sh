#!/bin/zsh
# usage: generate.sh <kind> <name> "<what to draw>" [count] [extra-ref.png ...]
#   kind  icon | object | property | mascot | landmark   (see style.md)
#   name  snake_case file name, e.g. key_handover
# Makes <count> options (default 3) with Codex image generation, in parallel.
# Prints the folder that holds option-1.png ... option-N.png.
set -e
HOME_DIR="${RENTOK_ILLUSTRATIONS_HOME:-$HOME/.rentok-illustrations}"
kind=$1; name=$2; what=$3; count=${4:-3}; shift 4 2>/dev/null || shift $#
[[ -z $kind || -z $name || -z $what ]] && {
  echo 'usage: generate.sh <icon|object|property|mascot|landmark> <name> "<what to draw>" [count] [extra-ref ...]' >&2; exit 2; }

case $kind in
  icon)     board=references/icons/board-more-icons.png ;;
  object)   board=references/people-and-objects/board-basic-icons.png ;;
  property) board=references/property/board-property.png ;;
  mascot)   board=references/mascot/board-mascot.png ;;
  landmark) board=references/landmark/board-landmark.png ;;
  *) echo "unknown kind: $kind" >&2; exit 2 ;;
esac

out="${TMPDIR:-/tmp}/rentok-illustration/$name"
rm -rf "$out"; mkdir -p "$out"
refs=(-i "$HOME_DIR/$board")
for r in "$@"; do refs+=(-i "${r:A}"); done
style=$(cat "$HOME_DIR/style.md")

prompt="Use your image generation tool. Make ONE image of: $what.
It is a '$kind' for the RentOk app. Match the attached reference board exactly in
art style, material, lighting, camera angle and level of detail; any other
attached images are RentOk icons already in the app, match them too.
Follow these house rules:
$style
Output: square PNG, transparent background, the subject centred filling about 80%."

pids=()
for i in $(seq 1 $count); do
  # Each run gets its own folder: in a shared one, parallel runs picked
  # up each other's image and saved duplicates.
  run="$out/run-$i"; mkdir -p "$run"
  ( codex exec "$prompt Save the final PNG exactly at $run/option.png. Reply only with the path." \
      --skip-git-repo-check --sandbox workspace-write -C "$run" "${refs[@]}" \
      < /dev/null > "$out/option-$i.log" 2>&1 \
    && [[ -f "$run/option.png" ]] && mv "$run/option.png" "$out/option-$i.png" ) &
  pids+=($!)
done
for p in $pids; do wait $p || true; done

made=$(ls "$out"/option-*.png 2>/dev/null | wc -l | tr -d ' ')
if [[ $made -eq 0 ]]; then
  echo "NONE: Codex made no image. Check $out/option-1.log." >&2
  echo "If your ChatGPT plan has no image generation, use the fallback prompt in SKILL.md." >&2
  exit 1
fi
echo "$out"

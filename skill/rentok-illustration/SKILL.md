---
name: rentok-illustration
description: Generate RentOk icons, 3D objects, isometric property rooms and mascot scenes in the house style, using the shared reference library (eazyapp-tech/rentok-illustrations) and Codex image generation. Use when anyone asks to make, generate or redesign an icon, illustration, empty-state image or mascot picture for a RentOk app or page.
---

# RentOk illustration

Makes images that look like they belong in RentOk. The references and the
house rules live in the private repo
**https://github.com/eazyapp-tech/rentok-illustrations** and are downloaded
to `~/.rentok-illustrations` on first use. This skill folder holds only the
instructions and scripts, so it can be shared as-is.

`SKILL_DIR` below means the folder that holds this file.

## 1. Check the setup (every time)

Run `zsh SKILL_DIR/scripts/preflight.sh`.

- Every line `OK` → continue.
- Any `FIX` line → show the person that line, in plain words, and stop for
  that item. Typical fixes:
  - **No repo access:** ask Nitish (RentOk) to add your GitHub account to
    `eazyapp-tech/rentok-illustrations`, then run `gh auth login`.
  - **No Codex:** `npm install -g @openai/codex`, then `codex login` with
    your ChatGPT account.
  - **Plan question:** Codex comes with ChatGPT sign-in. Whether a *free*
    ChatGPT plan can generate images through Codex is not confirmed; if
    generation returns no image, go to step 6 (fallback).
- If only Codex is missing but the references are there, offer step 6.

## 2. Understand the request

Ask only what is missing, one short question at a time:
- **What** to draw, in one line (e.g. "a key being handed over").
- **Kind** — pick it yourself when obvious, else ask:
  `icon` (small app icon), `object` (RentOk object or avatar),
  `property` (room, kitchen, building), `mascot` (the moustache man).
- **Name** for the file, snake_case (suggest one).

Read `~/.rentok-illustrations/style.md` before writing anything. It is the
source of truth; its "Never" and "Learned" lines are rules.

## 3. Generate options

```
zsh SKILL_DIR/scripts/generate.sh <kind> <name> "<what, in one clear sentence>" 3 [closest approved icons...]
```

- Add 1–2 of the closest files from `~/.rentok-illustrations/approved/` as
  extra references when they fit (same family of object).
- It runs about 1–2 minutes in the background; say so, do not poll.
- It prints the folder with `option-1.png … option-3.png`.

## 4. Show and choose

Open every option and look at it yourself first. Reject one that breaks a
style rule (text in image, wrong art style, white box instead of
transparency, different mascot face) and say why. Then show the person the
good options side by side, and, when the request is for an app screen, next
to 2–3 approved icons so a mismatch is easy to see. Ask which one to keep,
or what to change (then go back to step 3 with the change in the sentence).

## 5. Save it

Inside a Flutter project (a `pubspec.yaml` at the project root):

```
python3 -I SKILL_DIR/scripts/place.py <chosen.png> <project_root> <asset_dir> <name> <kind>
```

- `asset_dir`: reuse the folder where the screen's other images already are
  (look for `Image.asset` calls near the code); otherwise ask.
- It resizes (icons 144 px, property and mascot 600 px), never overwrites,
  and adds the folder to `pubspec.yaml` if it is missing.
- Tell the person the path and the line to use it, e.g.
  `Image.asset('assets/image/x/key.png', width: 40)`.

Outside a Flutter project: copy the chosen PNG to where the person asks.

Then offer to add it to the library: copy the chosen PNG to
`~/.rentok-illustrations/approved/<name>.png`, and, if the person said why
they liked or rejected options, add one dated line to "Learned" in
`style.md`. Commit and push only with their yes; if they have no write
access, give them the file and the line to send to Nitish.

## 6. Fallback (no Codex or no image generation)

Write the full prompt the script would send (the request + all of
`style.md`) and tell the person to:
1. Open ChatGPT (an image-capable model).
2. Attach the reference board for the kind (path in `style.md`) and 1–2
   approved icons.
3. Paste the prompt; ask for a transparent square PNG.
4. Download it and give you the file, then continue from step 4.

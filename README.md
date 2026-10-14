# RentOk illustrations

The reference library and house style for RentOk icons and illustrations,
plus the Claude Code skill that uses them.

## Use it (Claude Code)

1. Copy the skill folder into your skills:
   ```bash
   git clone https://github.com/eazyapp-tech/rentok-illustrations.git ~/.rentok-illustrations
   mkdir -p ~/.claude/skills && cp -R ~/.rentok-illustrations/skill/rentok-illustration ~/.claude/skills/
   ```
   (Or just copy the `skill/rentok-illustration` folder someone sent you; it
   downloads this repo by itself on first use.)
2. Install Codex for image generation and sign in:
   ```bash
   npm install -g @openai/codex && codex login
   ```
3. In Claude Code, ask: "make a RentOk icon of a key handover".

No Codex? The skill still writes the prompt and tells you which reference
images to attach in ChatGPT.

## Use it (Codex)

Codex does not load Claude skills. Open this repo in Codex and ask; it reads
`AGENTS.md`, which points to the same steps.

## What is here

| Path | What |
|---|---|
| `style.md` | House rules sent with every prompt. Change by pull request. |
| `references/` | Reference boards: icons, objects, property, mascot. |
| `approved/` | Icons already shipped in the app; also used as references. |
| `skill/rentok-illustration/` | The Claude Code skill and its scripts. |

## Add references

Add images to the right `references/` folder or to `approved/`, and open a
pull request. Nitish approves what becomes part of the house style.

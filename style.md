# RentOk illustration style

The house rules for every icon and illustration. The skill sends these with
every prompt. Change them here (by pull request), not in the prompt.

## Kinds and their reference board

| Kind | Use for | Reference board |
|---|---|---|
| `icon` | Small app icons: bell, calendar, wallet, gear, chart, lock | `references/icons/board-more-icons.png` |
| `object` | RentOk objects: agreement, rupee coin, shield, chat alert, food, avatars | `references/people-and-objects/board-basic-icons.png` |
| `property` | Rooms, kitchens, bathrooms, beds, buildings, flats | `references/property/board-property.png` |
| `mascot` | Scenes with the RentOk mascot | `references/mascot/board-mascot.png` |
| `landmark` | City landmarks for city pickers and location screens | `references/landmark/board-landmark.png` |

The boards are exports of the Figma page **Illustration library** in
*Rentok · Design System*
(https://www.figma.com/design/3kGYNeMeWsIj9ckOlENbNV/Rentok--Design-System?node-id=1345-46118).
Figma is the master copy. When a board there changes, re-export it here.

| Board | Figma node |
|---|---|
| Mascot (20 poses) | `1212:329` |
| Property (12 rooms and buildings) | `1212:315` |
| Basic icons (11 objects) | `1212:316` |
| More icons (sheet) | `1212:330` |
| Landmark (city sheet) | `1213:343` |

Also attach 1–2 icons from `approved/` that are closest to the request. They
are icons already shipped in the app.

## Look (all kinds except `landmark`)

- Soft 3D, matte clay to light glossy plastic. Rounded, chunky shapes.
- Soft studio light from the top-left. A gentle contact shadow under the object.
- Three-quarter view for objects; isometric view for rooms and buildings.
- One subject, centred, filling about 80% of a square canvas.
- Transparent background. No text, no letters, no logos, no outline, no frame.
- Colours: free multi-colour, as in the icons board. Use the colour that fits
  the object (green for money and success, red for alerts and alarms, yellow for
  notes and warnings, blue for app and trust). When nothing suggests a colour,
  use RentOk royal blue `#3757FE`.

## Property

- Isometric cut-away cube: two walls and a floor. The front is open.
- Warm cream walls, light wood floor and furniture, white bedding, small green plant.
- Calm and tidy. No people.

## Landmark

- The one kind that is not 3D: flat vector illustration, simple shapes, no
  outline, light shading in two or three tones of the same colour.
- Front view, symmetric, on a small strip of green bush at the base.
- Warm saffron and amber for stone gateways and palaces; brick red or off-white
  only when the real building is that colour (as on the board).
- One landmark per image, recognisable from its outline. Transparent background.
- Never mix this flat style into the other kinds, and never make a landmark 3D.

## Mascot

- The mascot is the older man with a moustache, round glasses, short dark hair,
  a beige vest over a light blue shirt and dark trousers. Pixar-like 3D.
- Keep his face, outfit and proportions identical to the mascot board.
- Use only him. Do not use the younger man from the basic icons board.
- Poses show one clear feeling: happy (OK sign, pointing), busy (laptop, phone),
  worried (hand on head), relaxed (leaning back).

## Never

- Text or numbers drawn inside the image.
- A different art style mixed in (flat, line, photo-real, anime). Landmarks
  are the exception: they are flat on purpose.
- Busy backgrounds or scenes around an icon.
- Faces on objects.

## Learned (add a line when the owner rejects or approves something)

- 2026-10-22: boards re-exported from the Figma Illustration library; `landmark` kind added.
- 2026-10-13: tiny icons inside small tabs (24 pt) look muddy; put clay icons at 40 pt or larger.

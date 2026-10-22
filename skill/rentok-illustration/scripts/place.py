"""Place a chosen option in a Flutter project and register it.

usage: python3 -I place.py <chosen.png> <project_root> <asset_dir> <name> <kind>

- Resizes with macOS `sips`: icons/objects to 144 px, landmarks to 300 px, property/mascot to 600 px.
- Saves <project_root>/<asset_dir>/<name>.png (never overwrites; adds _2, _3).
- Adds "- <asset_dir>/" under flutter: assets: in pubspec.yaml when that
  folder (or a parent folder entry) is not listed yet.
Prints the saved path relative to the project.
"""
import pathlib
import subprocess
import sys

src, root, asset_dir, name, kind = sys.argv[1:6]
root = pathlib.Path(root)
asset_dir = asset_dir.strip('/')
size = 600 if kind in ('property', 'mascot') else 300 if kind == 'landmark' else 144

folder = root / asset_dir
folder.mkdir(parents=True, exist_ok=True)
target = folder / f'{name}.png'
n = 2
while target.exists():
    target = folder / f'{name}_{n}.png'
    n += 1
subprocess.run(['sips', '-Z', str(size), src, '--out', str(target)],
               check=True, capture_output=True)

pubspec = root / 'pubspec.yaml'
if pubspec.exists():
    lines = pubspec.read_text().splitlines(keepends=True)
    entry = f'{asset_dir}/'
    listed = any(
        line.strip().startswith('- ') and entry.startswith(
            line.strip()[2:].strip().strip('"\''))
        and line.strip()[2:].strip().strip('"\'').endswith('/')
        for line in lines)
    if not listed:
        for i, line in enumerate(lines):
            if line.strip() == 'assets:' and line.startswith('  '):
                indent = line[:len(line) - len(line.lstrip())] + '  '
                lines.insert(i + 1, f'{indent}- {entry}\n')
                pubspec.write_text(''.join(lines))
                print(f'registered {entry} in pubspec.yaml')
                break
        else:
            print(f'NOTE: add "- {entry}" under flutter: assets: in pubspec.yaml')

print(target.relative_to(root))

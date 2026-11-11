#!/usr/bin/env python3
"""Set Papirus folder color to the one nearest Noctalia's primary color.

Called by Noctalia's papirus_folders template post_hook with the rendered
file (containing one hex color) as argv[1]. Needs the sudoers rule in
/etc/sudoers.d/papirus-folders so `sudo -n papirus-folders` works.
"""
import colorsys
import re
import subprocess
import sys
from pathlib import Path

THEME = "Papirus-Dark"
PLACES = Path("/usr/share/icons/Papirus/48x48/places")
# The folder's front face is the 40x26 rect; its fill is the folder's color.
FRONT = re.compile(r'fill:#([0-9a-fA-F]{6})" width="40" height="26"')


def hex_to_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4))


def folder_color(name):
    """Front-face fill color of folder-<name>.svg."""
    svg = PLACES / f"folder-{name}.svg"
    if not svg.exists():
        return None
    fills = FRONT.findall(svg.read_text(errors="ignore"))
    return hex_to_rgb(fills[-1]) if fills else None


def available_colors():
    out = subprocess.run(["papirus-folders", "-l", "--theme", THEME],
                         capture_output=True, text=True, check=True).stdout
    colors, current = [], None
    for line in out.splitlines():
        line = line.strip()
        if not line:
            continue
        if line.startswith(">"):
            line = line.lstrip("> ").strip()
            current = line
        if re.fullmatch(r"[a-z0-9-]+", line):
            colors.append(line)
    return colors, current


GREY_SAT = 0.15  # below this HLS saturation a color counts as neutral


def distance(target, folder):
    """Hue decides for colorful targets; lightness decides for neutral ones.

    Material dark-mode primaries are pastels, so lightness/saturation are
    ignored for colorful targets or every match drifts to the pale folders.
    """
    ht, lt, st = colorsys.rgb_to_hls(*target)
    hf, lf, sf = colorsys.rgb_to_hls(*folder)
    if st < GREY_SAT:
        return (lt - lf) ** 2 + (0 if sf < GREY_SAT else 1)
    dh = min(abs(ht - hf), 1 - abs(ht - hf))
    return dh ** 2 + (1 if sf < GREY_SAT else 0) + (st - sf) ** 2 * 0.002


def main():
    target = hex_to_rgb(Path(sys.argv[1]).read_text().strip())
    colors, current = available_colors()
    candidates = {c: rgb for c in colors if (rgb := folder_color(c))}
    if not candidates:
        sys.exit("papirus-folders-sync: no Papirus folder colors found")
    best = min(candidates, key=lambda c: distance(target, candidates[c]))
    if best == current:
        return
    subprocess.run(["sudo", "-n", "papirus-folders", "-C", best, "--theme", THEME], check=True)
    print(f"papirus-folders-sync: {current} -> {best}")


if __name__ == "__main__":
    main()

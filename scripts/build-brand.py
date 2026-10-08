#!/usr/bin/env python3
"""Generate every TNHC logo file from the one hand-drawn master.

The master is brand/logo/tnhc-sign.svg. Its four layers carry ids (rim, ring,
field, figure); every other file is built from those layers, so a change to the
master is the only way to change the logo.

  python3 scripts/build-brand.py            # SVG variants + PNG/ICO icons
  python3 scripts/build-brand.py --svg-only --out DIR
                                            # SVG variants only, into DIR
                                            # (check-brand.sh diffs these)

SVG output is plain text built in a fixed order, so it is byte-for-byte
reproducible. PNG/ICO go through ImageMagick and are checked by size only.
"""
import argparse, pathlib, subprocess, sys, xml.etree.ElementTree as ET

from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont

ROOT = pathlib.Path(__file__).resolve().parent.parent
BRAND = ROOT / "brand"
MASTER = BRAND / "logo" / "tnhc-sign.svg"
FONT = BRAND / "fonts" / "Figtree-Black.ttf"

SVGNS = "http://www.w3.org/2000/svg"
VOID, INK, ACID, LIGHT_TEXT = "#030303", "#0A0A0A", "#CCFF00", "#EDEDED"
W, H = 240, 216                     # the master's viewBox
NAME = "THE NO HANDS COMPANY"
CAP = 0.24 * H                      # cap height of the name in the lockup
GAP = 26                            # sign-to-name gap (about one head width)
TRACK = 0.02                        # letter spacing, in em

# Raster outputs: path under brand/ -> pixel size (square).
PNGS = {f"icons/app-icon-{s}.png": s for s in (16, 32, 48, 180, 192, 512)}
PNGS.update({f"icons/android/launcher-{s}.png": s for s in (48, 72, 96, 144, 192)})
PNGS.update({"icons/android/play-store-512.png": 512, "icons/github-avatar-500.png": 500})
ICO = "icons/favicon.ico"           # 16, 32 and 48 inside


def num(v):
    return ("%.2f" % v).rstrip("0").rstrip(".")


def layers():
    ET.register_namespace("", SVGNS)
    tree = ET.parse(MASTER)
    out = {}
    for el in tree.getroot():
        lid = el.get("id")
        if lid:
            out[lid] = ET.tostring(el, encoding="unicode").replace(f' xmlns="{SVGNS}"', "").strip()
    missing = {"rim", "ring", "field", "figure"} - out.keys()
    if missing:
        sys.exit(f"build-brand: master lacks layer(s): {', '.join(sorted(missing))}")
    return out


def recolour(fragment, colour):
    return fragment.replace(ACID, colour).replace(INK, colour)


def svg(view_w, view_h, body):
    return (f'<svg xmlns="{SVGNS}" viewBox="0 0 {num(view_w)} {num(view_h)}">\n'
            f"{body}\n</svg>\n")


def sign(L):
    return "\n".join(L[k] for k in ("rim", "ring", "field", "figure"))


def mono(L):
    # One colour: the ring with the field cut out of it, and the figure.
    field_cut = recolour(L["field"], "#000").replace(' id="field"', "")
    body = (f'<defs><mask id="field-cut" maskUnits="userSpaceOnUse" x="0" y="0" width="{W}" height="{H}">'
            f'<rect width="{W}" height="{H}" fill="#fff"/>{field_cut}</mask></defs>\n'
            f'<g mask="url(#field-cut)">{L["ring"]}</g>\n{L["figure"]}')
    return svg(W, H, body)


def name_path(colour):
    font = TTFont(FONT)
    gs, cmap, hmtx = font.getGlyphSet(), font.getBestCmap(), font["hmtx"]
    s = CAP / font["OS/2"].sCapHeight
    baseline = H / 2 + CAP / 2
    x = W + GAP
    pen = SVGPathPen(gs, ntos=num)
    for i, ch in enumerate(NAME):
        g = cmap[ord(ch)]
        gs[g].draw(TransformPen(pen, (s, 0, 0, -s, x, baseline)))
        x += hmtx[g][0] * s + (TRACK * font["head"].unitsPerEm * s if i < len(NAME) - 1 else 0)
    return f'<path fill="{colour}" d="{pen.getCommands()}"/>', x


def lockup(L, colour):
    text, right = name_path(colour)
    return svg(right, H, sign(L) + "\n" + text)


def app_icon(L, side=256, inner=192):
    k = inner / W
    tx, ty = (side - inner) / 2, (side - H * k) / 2
    body = (f'<rect width="{side}" height="{side}" rx="{num(side * 0.22)}" fill="{VOID}"/>\n'
            f'<g transform="translate({num(tx)} {num(ty)}) scale({num(k)})">\n{sign(L)}\n</g>')
    return svg(side, side, body)


def build_svgs(out):
    L = layers()
    files = {
        "logo/tnhc-sign-mono.svg": mono(L),
        "logo/tnhc-lockup-dark.svg": lockup(L, LIGHT_TEXT),
        "logo/tnhc-lockup-light.svg": lockup(L, INK),
        "logo/tnhc-app-icon.svg": app_icon(L),
    }
    for rel, text in files.items():
        p = out / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(text, encoding="utf-8")
    return files


def magick(*args):
    subprocess.run(["magick", *map(str, args)], check=True)


def build_rasters():
    icon = BRAND / "logo" / "tnhc-app-icon.svg"
    for rel, size in PNGS.items():
        p = BRAND / rel
        p.parent.mkdir(parents=True, exist_ok=True)
        magick("-background", "none", "-density", 600, icon, "-resize", f"{size}x{size}", "-strip", p)
    magick("-background", "none", "-density", 600, icon, "-define", "icon:auto-resize=48,32,16", BRAND / ICO)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--svg-only", action="store_true")
    ap.add_argument("--out", type=pathlib.Path, default=BRAND)
    a = ap.parse_args()
    build_svgs(a.out)
    if not a.svg_only:
        build_rasters()
    return 0


if __name__ == "__main__":
    sys.exit(main())

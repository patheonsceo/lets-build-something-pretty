#!/usr/bin/env python3
"""Align a set of object photos so they sit on one shelf line and are centred.

usage: python3 align-on-baseline.py <marks.json> <in-dir> <out-dir> [--target 0.81] [--size 800]

marks.json maps file name -> [base_y, centre_x] as fractions of the image,
where base_y is where the object meets its surface. Measure them by looking at
a contact sheet (magick montage) once. Each image is shifted (not cropped
tighter) and the exposed edge is filled with the image's own corner colour, so
tall objects keep their tops.
"""
import json, os, subprocess, sys

args = sys.argv[1:]
target = float(args[args.index("--target") + 1]) if "--target" in args else 0.81
size = int(args[args.index("--size") + 1]) if "--size" in args else 800
marks, src, dst = args[0], args[1], args[2]
os.makedirs(dst, exist_ok=True)
for name, (base_y, cx) in json.load(open(marks)).items():
    path = os.path.join(src, name)
    w = int(subprocess.run(["magick", "identify", "-format", "%w", path], capture_output=True, text=True).stdout)
    dy, dx = round((base_y - target) * w), round((cx - 0.5) * w)
    col = subprocess.run(["magick", path, "-crop", "40x40+10+10", "-resize", "1x1!", "-format", "#%[hex:p{0,0}]", "info:"],
                         capture_output=True, text=True).stdout.strip()
    out = os.path.join(dst, os.path.splitext(name)[0] + ".jpg")
    subprocess.run(["magick", path, "-background", col, "-gravity", "NorthWest", "-extent", f"{w}x{w}+{dx}+{dy}",
                    "-resize", f"{size}x{size}", "-quality", "84", "-interlace", "plane", out], check=True)
    print("aligned", out)

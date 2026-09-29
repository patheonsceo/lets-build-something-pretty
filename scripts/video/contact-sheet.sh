#!/usr/bin/env bash
# See a clip at a glance: 8 frames tiled (read it with the Read tool).
# usage: bash contact-sheet.sh <in.mp4> <out.jpg>
D=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$1")
ffmpeg -v error -y -i "$1" -vf "fps=8/$D,scale=360:-1,tile=4x2" -frames:v 1 "$2" && echo "$2"

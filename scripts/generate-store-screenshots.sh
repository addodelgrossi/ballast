#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
font="/System/Library/Fonts/SFCompactRounded.ttf"
regular_font="/System/Library/Fonts/SFCompact.ttf"
tmp_dir="${TMPDIR:-/tmp}/ballast-store-media"

mkdir -p "$tmp_dir" "$root/AppStore/Media/en-US" "$root/AppStore/Media/pt-BR"

render() {
  local locale="$1"
  local filename="$2"
  local source="$3"
  local headline="$4"
  local detail="$5"
  local accent="$6"
  local prepared="$tmp_dir/${locale}-${filename}-screen.png"
  local output="$root/AppStore/Media/${locale}/${filename}.png"

  magick "$root/docs/assets/screenshots/${locale}/${source}.png" \
    -resize '290x354!' \
    \( +clone -alpha transparent -fill white -draw 'roundrectangle 0,0 289,353 46,46' \) \
    -compose CopyOpacity -composite \
    "$prepared"

  magick -size 396x484 xc:'#05080c' \
    -fill "${accent}22" -stroke "${accent}88" -strokewidth 1 \
    -draw 'roundrectangle 51,127 344,483 48,48' \
    \( -size 360x58 -background none -fill '#f4f7f5' -font "$font" -pointsize 27 -gravity center caption:"$headline" \) \
    -gravity northwest -geometry +18+12 -compose over -composite \
    \( -size 350x32 -background none -fill "$accent" -font "$regular_font" -pointsize 14 -gravity center caption:"$detail" \) \
    -gravity northwest -geometry +23+78 -compose over -composite \
    "$prepared" -gravity northwest -geometry +53+130 -compose over -composite \
    -depth 8 \
    "$output"
}

render pt-BR 01-volte-ao-presente 02-see \
  'ANSIEDADE APERTOU?' 'Volte ao presente pelo pulso' '#8dc5ff'
render pt-BR 02-cinco-sentidos 03-hear \
  'UM SENTIDO POR VEZ' 'A técnica 5-4-3-2-1, guiada' '#7dd8c4'
render pt-BR 03-olhos-fechados 04-feel \
  'FECHE OS OLHOS' 'Vibrações apresentam cada etapa' '#c7adff'
render pt-BR 04-gire-a-coroa 05-smell \
  'GIRE A COROA' 'Um tique para cada item percebido' '#efc38d'
render pt-BR 05-privado-offline 07-complete \
  'VOCÊ ESTÁ AQUI' 'Grátis, privado e 100% offline' '#96d9b8'

render en-US 01-come-back 02-see \
  'ANXIETY RISING?' 'Come back to the present on your wrist' '#8dc5ff'
render en-US 02-five-senses 03-hear \
  'ONE SENSE AT A TIME' 'The guided 5-4-3-2-1 exercise' '#7dd8c4'
render en-US 03-eyes-closed 04-feel \
  'CLOSE YOUR EYES' 'Haptics introduce every step' '#c7adff'
render en-US 04-turn-the-crown 05-smell \
  'TURN THE CROWN' 'One tick for each thing you notice' '#efc38d'
render en-US 05-private-offline 07-complete \
  'YOU’RE HERE' 'Free, private, and 100% offline' '#96d9b8'

echo "Generated App Store screenshots in AppStore/Media."

#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
archive_root="$(mktemp -d "${TMPDIR:-/tmp}/ballast-release-audit.XXXXXX")"
archive_path="$archive_root/Ballast.xcarchive"

xcodebuild \
  -project "$root/Ballast.xcodeproj" \
  -scheme Ballast \
  -configuration Release \
  -destination 'generic/platform=watchOS' \
  -derivedDataPath "$archive_root/DerivedData" \
  -archivePath "$archive_path" \
  CODE_SIGNING_ALLOWED=NO \
  archive

app="$archive_path/Products/Applications/Ballast.app"
extension="$app/PlugIns/BallastComplication.appex"

test -d "$app"
test -d "$extension"

echo "Release archive contains Ballast.app and BallastComplication.appex."
echo "Archive: $archive_path"

#!/bin/bash
# Public setup entry: pinned installer checksums; no sudo, Homebrew, or GitHub login.
# Keep everything inside a function so piping into bash cannot feed setup answers.
main() {
  set -euo pipefail
  umask 077
  [[ "$(/usr/bin/uname -s)" == Darwin ]] || { echo 'This program requires macOS.' >&2; return 1; }
  if ! ( : < /dev/tty ) 2>/dev/null; then
    echo 'Paste the install command into Terminal on your Mac. Setup requires an interactive terminal.' >&2
    return 1
  fi
  local arch expected file actual
  case "$(/usr/bin/uname -m)" in
    arm64) arch=arm64; expected=207e2960951ec9bd2616a4c163a1405b6d217c3a46d11f4504aac5446fad2588 ;;
    x86_64) arch=x64; expected=fc7b5c3a7985a58628a5c5028f3994648329159d596664af71c1aeb15a8a5e8e ;;
    *) echo 'Unsupported Mac architecture.' >&2; return 1 ;;
  esac
  echo 'Babson Calendar Companion — Development preview setup'
  echo 'Find homework in Canvas Modules, pages and slides. Local text/OCR, cached AI analysis. Google Calendar is optional; automatic sync is not enabled.'
  BABSON_DOWNLOAD_TMP="$(/usr/bin/mktemp -d "${TMPDIR:-/tmp}/babson-download.XXXXXX")"
  trap '/bin/rm -rf -- "$BABSON_DOWNLOAD_TMP"' EXIT
  file="$BABSON_DOWNLOAD_TMP/install.command"
  /usr/bin/curl --proto '=https' --tlsv1.2 --fail --location --retry 2 --connect-timeout 20 --max-time 600 --progress-bar "https://github.com/steve109292-max/babson-companion-downloads/releases/download/v0.1.0-prep.16/babson-companion-0.1.0-prep.16-macos-$arch.command" --output "$file"
  actual="$(/usr/bin/shasum -a 256 "$file" | /usr/bin/awk '{print $1}')"
  [[ "$actual" == "$expected" ]] || { echo 'Installer verification failed. Installation was not started.' >&2; return 1; }
  /bin/bash "$file" < /dev/tty
}
main "$@"

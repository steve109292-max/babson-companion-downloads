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
    arm64) arch=arm64; expected=c69a6a347de007aa54ce007dd5e46b220cc461894cf17d7cc44b30b1c51c1f66 ;;
    x86_64) arch=x64; expected=34cd49e9855191630ee8fdd4295a711f5aa5d66952d2cc5b86bdd163402eb063 ;;
    *) echo 'Unsupported Mac architecture.' >&2; return 1 ;;
  esac
  echo 'Babson Calendar Companion — Development preview setup'
  echo 'Setup starts with Microsoft school login, then connects AI and Google Calendar. Automatic sync is not enabled yet.'
  BABSON_DOWNLOAD_TMP="$(/usr/bin/mktemp -d "${TMPDIR:-/tmp}/babson-download.XXXXXX")"
  trap '/bin/rm -rf -- "$BABSON_DOWNLOAD_TMP"' EXIT
  file="$BABSON_DOWNLOAD_TMP/install.command"
  /usr/bin/curl --proto '=https' --tlsv1.2 --fail --location --retry 2 --connect-timeout 20 --max-time 600 --progress-bar "https://github.com/steve109292-max/babson-companion-downloads/releases/download/v0.1.0-prep.6/babson-companion-0.1.0-prep.6-macos-$arch.command" --output "$file"
  actual="$(/usr/bin/shasum -a 256 "$file" | /usr/bin/awk '{print $1}')"
  [[ "$actual" == "$expected" ]] || { echo 'Installer verification failed. Installation was not started.' >&2; return 1; }
  /bin/bash "$file" < /dev/tty
}
main "$@"

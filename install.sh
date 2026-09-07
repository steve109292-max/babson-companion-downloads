#!/bin/bash
# Public setup entry: pinned installer checksums; no sudo, Homebrew, or GitHub login.
# Keep everything inside a function so piping into bash cannot feed setup answers.
main() {
  set -euo pipefail
  umask 077
  [[ "$(/usr/bin/uname -s)" == Darwin ]] || { echo '此程式只支援 macOS。' >&2; return 1; }
  if ! ( : < /dev/tty ) 2>/dev/null; then
    echo '請在 Mac 的 Terminal 貼上安裝指令；設定需要互動式終端機。' >&2
    return 1
  fi
  local arch expected file actual
  case "$(/usr/bin/uname -m)" in
    arm64) arch=arm64; expected=43236bcfd3c2b27a8cf6b4ac1222fa41f280f141329b33be74d64ad4853c7da1 ;;
    x86_64) arch=x64; expected=9515a5e49df9922bba5ec039d3dc2379c2ff6fb2262e80e6b64aaa32be499dbb ;;
    *) echo '不支援的 Mac 架構。' >&2; return 1 ;;
  esac
  echo 'Babson Calendar Companion — 開發預覽設定入口'
  echo '下載後會先設定 Microsoft 校務登入，再連接 AI 與 Google Calendar；自動同步尚未開放。'
  BABSON_DOWNLOAD_TMP="$(/usr/bin/mktemp -d "${TMPDIR:-/tmp}/babson-download.XXXXXX")"
  trap '/bin/rm -rf -- "$BABSON_DOWNLOAD_TMP"' EXIT
  file="$BABSON_DOWNLOAD_TMP/install.command"
  /usr/bin/curl --proto '=https' --tlsv1.2 --fail --location --retry 2 --connect-timeout 20 --max-time 600 --progress-bar "https://github.com/steve109292-max/babson-companion-downloads/releases/download/v0.1.0-prep.4/babson-companion-0.1.0-prep.4-macos-$arch.command" --output "$file"
  actual="$(/usr/bin/shasum -a 256 "$file" | /usr/bin/awk '{print $1}')"
  [[ "$actual" == "$expected" ]] || { echo '安裝檔驗證失敗，未執行安裝。' >&2; return 1; }
  /bin/bash "$file" < /dev/tty
}
main "$@"

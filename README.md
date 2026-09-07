# Babson Calendar Companion

Independent student project; not affiliated with or endorsed by Babson College.

## One-command setup (development preview)

Paste this in macOS Terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/steve109292-max/babson-companion-downloads/main/install.sh | /bin/bash
```

The public download entry detects Apple Silicon or Intel, checks a pinned SHA-256 checksum, installs a bundled Node runtime without sudo or Homebrew, and opens the interactive setup wizard. No GitHub account or Google Cloud project is required.

The wizard covers data consent, your own Claude or ChatGPT login, browser preparation, Google Calendar authorization, Canvas/Workday/Belong login, and an extraction check. Browser authorization and school MFA still require the account owner. Re-running the command reopens setup and preserves saved preferences and Google authorization. On the installed app, `~/.local/bin/babson setup` also reopens it.

**This is a setup preview, not a complete live calendar service.** Automatic synchronization remains disabled. Full school-source integration, class exceptions, unstarred joined-group events, and complete fresh-user acceptance are still pending. Do not describe the preview as ready for daily student use.

The installer contains shared native Google application metadata; it does not contain the publisher's Google user token, school browser session, password or passkey.

## Validation

`npm test` runs the core tests. Set `BABSON_INSTALLER_TEST` to the matching local `.command` file to enable the isolated Mac installer tests. `node bin/babson.mjs doctor` returns exit 2 while live-sync prerequisites remain incomplete.

See `docs/EXECUTION-STATUS.md` for the broader implementation status. Only the public download repository contains the one-command entry and distributable installers; the source repository remains private.

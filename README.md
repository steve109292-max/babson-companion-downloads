# Babson Calendar Companion

Independent student project; not affiliated with or endorsed by Babson College.

## One-command setup (development preview)

Paste this in macOS Terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/steve109292-max/babson-companion-downloads/main/install.sh | /bin/bash
```

The public download entry detects Apple Silicon or Intel, checks a pinned SHA-256 checksum, installs a bundled Node runtime without sudo or Homebrew, and opens the interactive setup wizard. No GitHub account or Google Cloud project is required.

The wizard starts with data consent and Microsoft school login. The default option, "Keep sign-in cookies only", requires no password or passkey. It restores cookies from the private Companion browser profile on this Mac when the app reopens; sign in again when the school session expires. Alternatively, authorize creation of a local software passkey and optionally save a password backup in macOS Keychain (default: no). The default Hidden homework mode connects your own Claude or ChatGPT and Canvas, scans course content, and opens a local results page. Google Calendar and other sources are optional through the separate Calendar preview mode. Browser authorization and school MFA still require the account owner. Re-running the command reopens setup and preserves saved preferences and Google authorization. On the installed app, `~/.local/bin/babson setup` also reopens it.

**This is a setup preview, not a complete live calendar service.** Automatic synchronization remains disabled. Full school-source integration, class exceptions, unstarred joined-group events, and complete fresh-user acceptance are still pending. Do not describe the preview as ready for daily student use.

The installer contains shared native Google application metadata; it does not contain the publisher's Google user token, school browser session, password or passkey.

The prep.4 login flow has passed a real Microsoft passkey registration and fresh-cookie sign-in test. Password and passkey material stay in non-synchronizable macOS login-Keychain items; this is software credential storage, not a hardware authenticator. `babson forget-password` removes the app’s saved password and `babson disable-auto-login` disables automatic school login.

## Hidden homework preview (prep.7)

Find preparation and assignments inside Modules, Pages, syllabus, announcements and attachments. PDF, Word, PowerPoint and Excel text is read locally; macOS Vision handles image OCR. New or changed text is analyzed by your selected AI provider, while unchanged sections reuse cached results. Every item includes a source quote and page/slide/sheet reference where applicable. Run `babson homework` to refresh.

Results distinguish required, in-class and optional work. Coverage gaps are visible: external tools, recordings, locked content and unreadable formats are not silently treated as empty. Finding every homework item is not guaranteed. This preview uses a local authenticated Canvas session, not an institution-approved multi-user OAuth integration.

## Validation

`npm test` runs the core tests. Set `BABSON_INSTALLER_TEST` to the matching local `.command` file to enable the isolated Mac installer tests. `node bin/babson.mjs doctor` returns exit 2 while live-sync prerequisites remain incomplete.

See `docs/EXECUTION-STATUS.md` for the broader implementation status. Only the public download repository contains the one-command entry and distributable installers; the source repository remains private.

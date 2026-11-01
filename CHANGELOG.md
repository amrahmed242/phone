# Changelog

All notable changes to this project are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-11-02

### Added
- `phone cast`: mirror real Android phones via scrcpy, with `--wireless`, `--record`, `--off`, `--awake`, `--view-only`, `--max-size`, `--emulators` and `--` passthrough. Opens QuickTime for iPhones (`--ios`).
- `--wait` for `start` and `restart`: blocks until the device has finished booting.
- `stop [name]` and `stop --all`; `restart [name]`.
- `install` works on USB-connected phones, not just emulators, and accepts a device name.
- Logs for every detached launch in `~/Library/Logs/phone` (`PHONE_LOG_DIR`).
- `PHONE_BOOT_TIMEOUT`, `NO_COLOR` support.
- `create`: "More…" option listing every device profile.

### Changed
- Exact name matches win over partial ones.
- `create` only lists system images that run on this Mac's CPU and checks AVD names before creating.
- Android Studio's JDK is only used when the default Java is older than 17.
- Color is disabled when output isn't a terminal.

### Fixed
- A process that dies on launch now reports its log instead of a false success.
- avdmanager's real error is shown when creation fails.
- No hang when a picker would be needed without a terminal; a clear error is shown instead.
- Unknown options and extra arguments are rejected instead of silently ignored.

## [0.1.0] - 2026-11-01

### Added
- `start`, `stop`, `restart`, `create`, `install` and `list` for Android emulators and iOS simulators.
- Install script, MIT license, shellcheck CI.

[0.2.0]: https://github.com/amrahmed242/phone/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/amrahmed242/phone/releases/tag/v0.1.0

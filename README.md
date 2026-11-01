<h1 align="center">phone</h1>

<p align="center">
  <b>One command for Android emulators, iOS simulators and real devices.</b><br>
  Start, stop, create, install and mirror, without opening Android Studio or Xcode.
</p>

<p align="center">
  <a href="https://github.com/amrahmed242/phone/actions/workflows/lint.yml"><img src="https://github.com/amrahmed242/phone/actions/workflows/lint.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/amrahmed242/phone/releases"><img src="https://img.shields.io/github/v/tag/amrahmed242/phone?label=version" alt="Version"></a>
  <img src="https://img.shields.io/badge/platform-macOS-lightgrey" alt="Platform: macOS">
  <img src="https://img.shields.io/badge/shell-bash%203.2%2B-4EAA25" alt="Shell: bash 3.2+">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue" alt="License: MIT"></a>
</p>

```console
$ phone start --wait
Which device do you want to start?
   1) 🤖 pixel_8_api_34
   2) 🍎 iPhone 15 Pro (iOS 17.5)
Choose [1-2]: 1
✓ Starting pixel_8_api_34
✓ pixel_8_api_34 is ready (21s)

$ phone install build/app/outputs/flutter-apk/app-debug.apk
› Installing app-debug.apk on 🤖 pixel_8_api_34  [emulator-5554]
✓ Installed

$ phone cast --wireless --record
✓ Casting Pixel 7 — close the window to stop
› Switching to Wi-Fi; you can unplug the cable once the window is up.
› Recording to ~/Desktop/Pixel_7-20261102-101500.mp4
```

---

## Contents

- [Features](#features)
- [Installation](#installation)
- [Quick start](#quick-start)
- [Commands](#commands)
- [Configuration](#configuration)
- [Requirements](#requirements)
- [Troubleshooting](#troubleshooting)
- [How it works](#how-it-works)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Android and iOS in one list:** emulators and simulators are picked from the same menu.
- **Picks for you when it can:** if only one device fits, it acts without asking. With several, you get a numbered menu, or you pass part of a name.
- **Boot-aware:** `--wait` returns only once the device has finished booting, so `phone start -w && flutter run` just works.
- **Screen mirroring:** `phone cast` mirrors real Android phones over USB or Wi-Fi, with optional recording, powered by [scrcpy](https://github.com/Genymobile/scrcpy).
- **Guided creation:** `phone create` walks you through system images, device profiles and iOS runtimes, and checks names before creating anything.
- **Survives your terminal:** emulators and mirrors run detached, so closing the tab doesn't kill them.
- **Honest failures:** if a process dies on launch, you see its log instead of a green checkmark.
- **Zero dependencies:** a single bash script that runs on macOS's stock bash 3.2.

## Installation

### Install script (recommended)

```sh
curl -fsSL https://raw.githubusercontent.com/amrahmed242/phone/main/install.sh | bash
```

Installs to `~/.local/bin/phone`. Set `PREFIX` to choose another location:

```sh
curl -fsSL https://raw.githubusercontent.com/amrahmed242/phone/main/install.sh | PREFIX=/usr/local bash
```

### From source

```sh
git clone https://github.com/amrahmed242/phone.git
cd phone
./install.sh            # symlinks bin/phone, so `git pull` keeps it up to date
```

### Uninstall

```sh
./install.sh --uninstall          # or: rm ~/.local/bin/phone
```

## Quick start

```sh
phone list                  # what's running, what's not
phone start                 # pick a device to boot
phone start -w "Pixel"      # boot the device whose name contains "Pixel", wait until ready
phone install app.apk       # install on the running emulator or connected phone
phone cast                  # mirror your Android phone
phone stop --all            # shut everything down
```

## Commands

Every command that needs a device follows the same rule. With no name, it picks the only candidate or shows a menu. With a `[name]`, it matches case-insensitively: an exact name first, then any part of the name.

### `phone start [name] [options]`

Boots a stopped Android emulator or iOS simulator.

| Option | Description |
|---|---|
| `-c`, `--cold` | Cold boot, ignoring the saved snapshot (Android). |
| `-w`, `--wait` | Block until the device reports that it has finished booting. |

### `phone stop [name] [options]`

Shuts down a running emulator or simulator. With several running and no name, the menu includes **All of them**.

| Option | Description |
|---|---|
| `-a`, `--all` | Stop every running emulator and simulator. |

### `phone restart [name] [options]`

Stops and starts a running device again. Accepts the same `--cold` and `--wait` options as `start`.

### `phone create`

Interactive wizard for a new device:

- **Android:** choose a system image (filtered to your Mac's CPU), a device profile (common ones first, **More…** for all), and a name.
- **iOS:** choose a runtime, a device type and a name.

### `phone install <file.apk> [name]`

Installs (or updates, keeping data) an APK on a running emulator or a USB-connected Android phone.

### `phone cast [name] [options]`

Mirrors a real device's screen in a window you can control with mouse and keyboard.

| Option | Description |
|---|---|
| `-w`, `--wireless` | Switch the connection to Wi-Fi, so you can unplug the cable. |
| `-r`, `--record [file]` | Record to `.mp4`/`.mkv`. Defaults to `~/Desktop/<device>-<timestamp>.mp4`. |
| `--off` | Turn the phone's screen off while mirroring. |
| `--awake` | Keep the phone awake while mirroring. |
| `--view-only` | Mirror without forwarding input. |
| `-m`, `--max-size <px>` | Limit the mirrored resolution, e.g. `-m 1024`. |
| `--emulators` | Include emulators in the device list. |
| `--ios` | Mirror a connected iPhone via QuickTime Player. |
| `-- <args>` | Pass everything after `--` to scrcpy, e.g. `phone cast -- --show-touches`. |

> **iPhone mirroring:** scrcpy is Android-only. When only an iPhone is connected (or with `--ios`), `phone cast` opens a QuickTime Player recording; pick your iPhone from the menu next to the record button.

### `phone list`

Shows running devices (emulators, simulators and connected phones) and stopped ones you can start.

## Configuration

`phone` is configured through environment variables:

| Variable | Default | Description |
|---|---|---|
| `ANDROID_HOME` / `ANDROID_SDK_ROOT` | `~/Library/Android/sdk` | Android SDK location. |
| `PHONE_LOG_DIR` | `~/Library/Logs/phone` | Where emulator and cast logs are written. |
| `PHONE_BOOT_TIMEOUT` | `300` | Seconds `--wait` waits for an Android boot. |
| `NO_COLOR` | unset | Disable colored output ([no-color.org](https://no-color.org)). Output is also plain when piped. |

## Requirements

| For | You need |
|---|---|
| Everything | macOS with bash 3.2+ (preinstalled) |
| Android | Android SDK with **Emulator**, **Platform-Tools** and, for `create`, **Command-line Tools** |
| `create` (Android) | JDK 17+; if your default Java is older, Android Studio's bundled JDK is used automatically |
| iOS | Xcode with at least one simulator runtime; `python3` for `create` |
| `cast` | [scrcpy](https://github.com/Genymobile/scrcpy). `phone` offers to install it with Homebrew the first time. |

Android-only use on Linux is expected to work but isn't tested yet.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `adb not found` | Set `ANDROID_HOME` to your SDK, or install Platform-Tools from Android Studio's SDK Manager. |
| A device exits right away | `phone` prints the last log lines. Full logs are in `~/Library/Logs/phone/`. |
| `Your phone is connected but unauthorized` | Unlock the phone and accept **Allow USB debugging**. |
| `No Android phone found` | Enable **Developer options → USB debugging** and use a data-capable cable. |
| `Several devices fit and there is no terminal…` | You're running non-interactively. Pass a more specific name (see `phone list`). |
| Simulator boots but no window appears | On Xcode 27, `phone` opens **DeviceHub**, which replaced Simulator.app. |

## How it works

`phone` is a thin, careful layer over the official tools:

| Task | Android | iOS |
|---|---|---|
| Discover | `emulator -list-avds`, `adb devices` | `xcrun simctl list` |
| Start / stop | `emulator -avd`, `adb emu kill` | `simctl boot` / `shutdown` |
| Wait for boot | `getprop sys.boot_completed` | `simctl bootstatus` |
| Create | `avdmanager create avd` | `simctl create` |
| Mirror | `scrcpy` | QuickTime Player |

## Contributing

Issues and pull requests are welcome. The whole tool is [`bin/phone`](bin/phone):

- Keep it compatible with **bash 3.2**: no associative arrays and no `mapfile`. Under `set -u`, expand possibly-empty arrays as `${arr[@]+"${arr[@]}"}`.
- Run `shellcheck bin/phone install.sh` before pushing. CI runs it on macOS.
- Run it straight from the repo while developing: `./bin/phone list`.
- Bump `VERSION` in `bin/phone` and add an entry to [`CHANGELOG.md`](CHANGELOG.md) when releasing.

### Roadmap

- Homebrew tap: `brew install amrahmed242/tap/phone`
- `phone open <url>`: deep links on the running device
- `phone push <payload.json>`: simulated iOS push notifications
- `phone locale` / `phone dark`: switch language and appearance
- `phone screenshot` / `phone record`: capture from emulators and simulators
- `phone logs`, `phone wipe`, `phone delete`
- iOS `.app` installs, shell completions, `fzf` picker

## License

[MIT](LICENSE) © Amr Ahmed

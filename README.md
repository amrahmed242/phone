# phone

Start, stop, restart, create and install apps on **Android emulators** and **iOS simulators**, all from one command.

```
$ phone start
Which device do you want to start?
   1) 🤖 pixel_8_api_34
   2) 🍎 iPhone 15 Pro (iOS 17.5)
   3) 🍎 iPhone SE (3rd generation) (iOS 17.5)
Choose [1-3]: 1
✓ Starting pixel_8_api_34
```

When there's only one option, `phone` doesn't ask. With a single device running, `phone stop` and `phone restart` just act on it.

## Install

**One-liner** (installs to `~/.local/bin`):

```sh
curl -fsSL https://raw.githubusercontent.com/amrahmed242/phone/main/install.sh | bash
```

**From a clone** (symlinked, so `git pull` updates it):

```sh
git clone https://github.com/amrahmed242/phone.git
cd phone && ./install.sh
```

Set `PREFIX` to install somewhere else, e.g. `PREFIX=/usr/local ./install.sh`.
Uninstall with `./install.sh --uninstall`.

## Usage

| Command | What it does |
|---|---|
| `phone start [-c] [name]` | Start a stopped emulator/simulator. Pick from a list, or pass part of its name. `-c` cold-boots (Android). |
| `phone stop` | Stop the running device, or pick one (or all) if several are up. |
| `phone restart [-c]` | Restart the running device, or pick one if several are up. |
| `phone create` | Create a new device: choose Android or iOS, then the system image/runtime, model and name. |
| `phone install <file.apk>` | Install an APK on the running Android emulator (picks if several are up). |
| `phone list` | Show running and stopped devices. |
| `phone --version` | Print the version. |

Examples:

```sh
phone start "iPhone 15"      # match by name
phone start -c ta_test       # cold boot an AVD
phone install ./build/app/outputs/flutter-apk/app-debug.apk
```

## Requirements

- **macOS** with stock bash 3.2 or newer. Android-only use on Linux should work but is untested.
- **Android:** Android SDK with `emulator`, `platform-tools` and `cmdline-tools` (for `create`).
  The SDK is found via `ANDROID_HOME`, then `ANDROID_SDK_ROOT`, then `~/Library/Android/sdk`.
  `avdmanager` needs JDK 17+; if your default Java is older, `phone` uses Android Studio's bundled JDK.
- **iOS:** Xcode with at least one simulator runtime. `python3` is used to read `simctl` JSON in `create`.

## Notes

- Emulators are launched in their own session, so closing the terminal doesn't kill them.
- Xcode 27 replaced `Simulator.app` with `DeviceHub.app`; `phone` opens whichever exists.
- iOS simulators have no cold boot, so `-c` is ignored for them.

## Development

The whole tool is a single bash script, [`bin/phone`](bin/phone), written to run on macOS's bash 3.2
(no associative arrays, no `mapfile`). Run it straight from the repo while hacking:

```sh
./bin/phone list
shellcheck bin/phone install.sh   # CI runs this on every push
```

When releasing, bump `VERSION` at the top of `bin/phone`.

### Roadmap

- Homebrew tap (`brew install amrahmed242/tap/phone`)
- `phone install` for iOS `.app` bundles
- Shell completions (zsh, bash)
- `fzf` picker when available

## License

[MIT](LICENSE)

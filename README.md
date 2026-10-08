# Shape-Robotics-Fable

A new client app for the **Shape Robotics Fable** robot kit (hub dongle, Spin, Joint and Face
modules). The original company and the original app have no support any more, and the mobile
and website versions no longer exist — this brings the block programming back on a website, an
Android app and an iPad app.

**Use it now in the browser:** https://robotics.miuthecat.uk
(Chrome or Edge on a computer or Android; Safari/iPad can use it through *Remote mode*.)

## What's in this repository

| Folder | What |
|---|---|
| [`apps/`](apps/) | Ready-to-install apps: `fable-blocks-v0.13.6.apk` (Android) and `fable-blocks-ios-v0.13.6.ipa` (iPad, sideload) |
| [`nix/`](nix/) | `flake.nix` — run the app locally on NixOS/Nix with `nix run github:Miu-exe/Shape-Robotics-Fable` (no install, no dependency on robotics.miuthecat.uk staying up) |
| [`server/`](server/) | The remote-mode relay (one file), for anyone hosting their own copy |
| [`docs/`](docs/) | How to use it |

No source code is published here — only what you need to run it. A Windows build (`.exe`) and
a plain Linux archive (`.tar.gz`) are planned; the Nix package is the first of the three.

### Run it locally (NixOS / Nix)

```sh
nix run github:Miu-exe/Shape-Robotics-Fable
```

Builds nothing — it's the same website bundle wrapped in nginx + the remote-mode relay, and
opens your browser to it. Nothing is installed outside a per-run temp directory.

## Features

- **Blockly programming** (Simple and Advanced toolboxes) and a **text mode** (JavaScript or
  Python) for Spin, Joint and Face modules: driving, turning, distance and colour sensors,
  joints, face emotions, sounds, speech, plots and more.
- Connects to the hub dongle over **Bluetooth** or **USB cable**.
- **Remote mode**: devices without Bluetooth/USB (e.g. an iPad in Safari) use a dongle that is
  plugged into another device — any number of dongles and devices, assigned on a web page with
  a live diagram.
- **Block reference** with a picture of every block: [`/simple`](https://robotics.miuthecat.uk/simple/)
  and [`/advanced`](https://robotics.miuthecat.uk/advanced/).
- **Diagnostics** (Settings → Diagnostics) and automatic recovery when the dongle loses a module.
- Works offline once loaded, and can be added to the home screen.

## Documentation

- [Getting started](docs/getting-started.md) — connect a robot and run your first program
- [Installing the apps](docs/apps.md) — Android APK and iPad IPA (incl. sideloading from Linux)
- [Remote mode](docs/remote-mode.md) — use a dongle from another device
- [Diagnostics and troubleshooting](docs/diagnostics.md)
- [Hosting your own copy](server/README.md)

## Status and known issues

- **Bluetooth on the iPad app is unreliable** (late or garbled replies from the dongle); USB and
  Chrome/Android Bluetooth work much better. Being worked on.
- Translations other than English are placeholders.
- Not affiliated with or endorsed by Shape Robotics. "Fable" is their product name; this is an
  independent replacement client for owners of the hardware.

## License

[MIT](LICENSE) © 2026 Miu-exe — for this project's own work. Bundled third-party libraries keep
their own licenses (e.g. Blockly and OpenCV: Apache-2.0; React and face-api.js: MIT), and the
original Fable names, icons, sounds and images belong to Shape Robotics.

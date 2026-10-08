# Getting started

## What you need

- A Fable **hub dongle** and at least one module (Spin, Joint or Face), switched on.
- One of:
  - **Chrome or Edge** on Windows, Linux, macOS or Android — Bluetooth, and USB on computers;
  - the **Android app** or **iPad app** from [`apps/`](../apps/) (see [Installing the apps](apps.md));
  - any other browser (Safari, Firefox, iPad) through [Remote mode](remote-mode.md).

Open https://robotics.miuthecat.uk (or your own copy, see [hosting](../server/README.md)).
Bluetooth and USB only work on `https://` addresses (or `http://localhost`).

## Connect the robot

1. **Settings** (gear, top right) → **Hub connection**: *Bluetooth (BLE)*, *USB cable* or
   *Remote (through a link)*. The page reloads when you change it.
2. Click the **hub pill** in the top bar → **Scan for hubs**, pick your dongle
   (`FableDongle…`) in the browser's list. For USB, plug the dongle in and pick its port.
3. The pill shows the dongle's name; the hub menu lists the modules it found (e.g. *Spin LJ9*).
   Every module has its own name — choose it in the **On Module** dropdown of each block.

## Your first program

1. In **Blocks** mode open the **Output** category and drag **Spin Set Drive Forward** onto the
   workspace; choose your Spin in *On Module*.
2. From **Loops**, snap a **Wait Time 2** under it, then a **Spin Set Drive Stop**.
3. Press **Run** (top of the workspace). **Stop** (red button in the top bar) stops any program.

Every block is explained, with a picture, in the block reference:
[Simple toolbox](https://robotics.miuthecat.uk/simple/) ·
[Advanced toolbox](https://robotics.miuthecat.uk/advanced/) (also under *Settings → Help*).

## Good to know

- Before every run the app resets the modules and waits until they're ready ("cleaning cycle"),
  so programs start 1–2 seconds after pressing Run, from a clean state.
- **Wait Until** keeps checking its condition as fast as readings arrive — use it with
  **Spin Obstacle Detected** (any of the Spin's three distance sensors; level 0–100, higher =
  closer) or **Spin Has Reached Target** (after Spin Set Drive *cm* / Spin Set Spin *degrees*).
- **Text mode** (top bar → Text): the same functions in JavaScript or Python, e.g.
  `setSpinSpeed(-50, 50, "LJ9")`, `await spinObstacleDetected(50, "LJ9")`, `await wait(1)`,
  `print("hi")`.
- **Settings**: theme (incl. colour-blind friendly), Simple/Advanced toolbox, language, text
  language, hub connection, diagnostics, help links.
- The website keeps working offline after the first visit and can be installed
  (*Add to Home screen* / install icon in Chrome's address bar).

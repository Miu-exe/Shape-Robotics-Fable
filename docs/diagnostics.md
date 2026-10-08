# Diagnostics and troubleshooting

## Diagnostics view

**Settings → Diagnostics → On**, then click the hub pill in the top bar. You get:

- **Last search** — the raw replies the dongle passed on during the last module search
  (unreadable ones in red).
- **Connected modules** — name, radio address, status (*booting, ready, running, locked…*) and
  how many replies per second arrive (for a Spin also distance readings per second).
- **Seen with this dongle before** — modules the app remembers for this dongle, whether they
  answer, and a **Reset** button.
- **Search again**, **Reset dongle**, **Forget remembered**.
- **Log** and **Bluetooth bytes** (everything sent/received) — **Copy** puts all of it on the
  clipboard for a bug report.

## What the app does by itself

- **Missing module recovery**: when a module the dongle had before stops answering (between
  programs), the app resets that module, then the dongle, then tries once more; after that the
  hub menu tells you to switch it off and on.
- **Keep-alive**: when no program has run for 10 s, the app asks each module for a reading every
  5 s, so they don't drop off while idle.
- **Cleaning cycle**: before every run the modules are reset and the program waits until they
  report ready — both Spin motors start together.

## Common problems

| Problem | Try |
|---|---|
| Can't find the dongle | It must be on and not connected to another device; Chrome/Edge (not Firefox/Safari) or Remote mode; `https://` address |
| Module not in the list | Switch the module off and on; *Diagnostics → Search again*; USB is more reliable than Bluetooth |
| Program does nothing | Check *On Module* in every block shows your module's name |
| Robot keeps moving | Red **Stop** button in the top bar |
| Spin turns but drives on immediately | Put **Wait Until [Spin Has Reached Target]** after *Spin Set Spin* / *Spin Set Drive cm* |
| Obstacle not noticed | Dark objects reflect less light — use a lighter one or a lower level (e.g. 30) |
| iPad app: Bluetooth flaky | Known issue — use USB on a link with [Remote mode](remote-mode.md) |

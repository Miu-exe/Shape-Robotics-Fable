# Hosting your own copy

Easiest: on NixOS or with Nix installed, run `nix run github:Miu-exe/Shape-Robotics-Fable`
([`../nix/`](../nix/)) — it serves the site and the relay together, locally, with no setup.

To host it on your own domain instead (so other devices can reach it over HTTPS — required for
Bluetooth/USB in the browser, except on `http://localhost`):

1. Put it behind an HTTPS reverse proxy (any will do — Caddy, nginx, etc.) pointing at the port
   `nix run` printed, or at your own build of the site.
2. For [Remote mode](../docs/remote-mode.md): run the relay
   ([`relay/relay.cjs`](relay/relay.cjs), one Node.js file, ~15 MB of memory) and proxy the
   WebSocket path `/remote/ws` to it:
   ```sh
   FABLE_REMOTE_PASSWORD=choose-a-password PORT=6791 node relay/relay.cjs
   ```
   The relay refuses to start without a password.

## Notes

- The app links to the block reference and (in the Android/iPad apps) the remote relay on
  robotics.miuthecat.uk; a self-hosted copy always uses the server it was loaded from.
- Updating: get the newer release and restart; visitors get it on their next visit (the service
  worker re-checks `index.html`).

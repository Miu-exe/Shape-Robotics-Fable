#!/usr/bin/env bash
# Runs Fable Blocks locally: nginx serves the built website, the relay (nix/relay.cjs) backs
# /remote/ws, then your browser opens to it. Everything is self-contained in @OUT@; nothing is
# installed outside a per-run temp directory. Ctrl-C stops both.
set -euo pipefail

WEB_PORT="${FABLE_PORT:-8080}"
RELAY_PORT="${FABLE_RELAY_PORT:-6791}"
FABLE_REMOTE_PASSWORD="${FABLE_REMOTE_PASSWORD:-$(od -An -tx1 -N12 /dev/urandom | tr -d ' \n')}"
export FABLE_REMOTE_PASSWORD

TMPDIR="$(mktemp -d /tmp/fable-blocks.XXXXXX)"
mkdir -p "$TMPDIR/client_body" "$TMPDIR/proxy" "$TMPDIR/fastcgi" "$TMPDIR/uwsgi" "$TMPDIR/scgi"
PIDFILE="$TMPDIR/nginx.pid"
CONF="$TMPDIR/nginx.conf"

sed \
  -e "s|@PIDFILE@|$PIDFILE|g" \
  -e "s|@MIME_TYPES@|@NGINX@/conf/mime.types|g" \
  -e "s|@TMPDIR@|$TMPDIR|g" \
  -e "s|@WEB_PORT@|$WEB_PORT|g" \
  -e "s|@SITE_ROOT@|@OUT@/share/fable-blocks/site|g" \
  -e "s|@RELAY_PORT@|$RELAY_PORT|g" \
  "@OUT@/share/fable-blocks/nginx.conf.template" > "$CONF"

cleanup() {
  [ -n "${RELAY_PID:-}" ] && kill "$RELAY_PID" 2>/dev/null || true
  [ -n "${NGINX_PID:-}" ] && @NGINX@/bin/nginx -c "$CONF" -p "$TMPDIR" -s quit 2>/dev/null || true
  rm -rf "$TMPDIR"
}
trap cleanup EXIT INT TERM

PORT="$RELAY_PORT" @NODE@/bin/node "@OUT@/share/fable-blocks/relay.cjs" &
RELAY_PID=$!

@NGINX@/bin/nginx -c "$CONF" -p "$TMPDIR" -g "daemon off;" &
NGINX_PID=$!

sleep 0.5
URL="http://127.0.0.1:$WEB_PORT/"
echo "Fable Blocks: $URL"
echo "Remote mode password: $FABLE_REMOTE_PASSWORD"
if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL" >/dev/null 2>&1 || true
fi

wait "$NGINX_PID"

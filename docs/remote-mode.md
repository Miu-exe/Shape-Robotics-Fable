# Remote mode

For devices **without Bluetooth or USB** (Safari, iPad, Firefox, a Chromebook without
Bluetooth…): the hub dongle is connected to *another* device — a **link** — and the robot
commands travel over the internet through a small relay on the server.

```
 device without Bluetooth  ──►  server (relay)  ──►  link (browser with the dongle)  ──►  dongle ─ robot
   (6-digit ID)                                         (5-digit ID)
```

## On the device without Bluetooth

1. Open the website, **Settings → Hub connection → Remote (through a link)**.
2. It shows a **6-digit remote ID** — also in the top bar, next to the Blocks/Text switch. The ID
   and the setting are remembered (also in a cookie).
3. Wait until a link gives this ID a dongle; it connects on its own. Then use it as usual.

## On the link (a computer or Android phone with Chrome/Edge)

1. Open **`/remote`** (e.g. https://robotics.miuthecat.uk/remote/) and enter the password
   (set by whoever runs the server — see [hosting](../server/README.md)).
2. Add dongles with **+ Bluetooth dongle** or **+ USB dongle** — as many as you like. Any number
   of links can be open at the same time (each has its own 5-digit ID), so you're not limited by
   how many Bluetooth connections one device can hold.
3. Give each dongle to a device: drag the device onto the dongle in the **diagram**, or pick its
   ID in the **table**.
4. Keep the link page open — the commands go through it.

**More on the /remote page**
- **Connected to**: which modules each dongle sees (green = answering now).
- **Remote devices**: give each device a **colour** (red, yellow, purple, cyan, green, blue);
  the device shows its ID in that colour, so pupils find "their" robot quickly.
- **Dongle debug**: firmware, who uses the dongle, modules found/lost — *Copy log* for reports.
- While no device uses a dongle, the link keeps its modules connected by searching for them
  every 2 seconds.
- When a device connects or reloads, the link gives it a fresh dongle session (Bluetooth
  dongles are reconnected; USB dongles don't need it).
- The link remembers its dongles, pairings and colours after a reload; USB dongles reconnect by
  themselves, Bluetooth ones when the browser allows it (otherwise press *Reconnect*).

## Notes

- Commands take a short trip through the server, so robots react slightly later than with a
  local dongle (a few milliseconds on the same network).
- USB dongles on the link are more reliable than Bluetooth ones.

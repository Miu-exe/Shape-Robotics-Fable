# Installing the apps

Both apps contain the same app as the website (version 0.13.6) and talk to the dongle directly.

## Android — `apps/fable-blocks-v0.13.6.apk`

1. Copy the APK to the phone/tablet (or download it from GitHub on the device).
2. Open it; allow *Install unknown apps* for your browser/file manager when asked.
3. Start **Fable Blocks** and allow **Bluetooth** / **Nearby devices** (and location on older
   Android versions — Android requires it for Bluetooth scanning).

Bluetooth is the default; *Settings → Hub connection → USB cable* uses a dongle on a USB-OTG
adapter. Updating: install the newer APK over the old one (your programs stay).

## iPad — `apps/fable-blocks-ios-v0.13.6.ipa`

The iPad app is not in the App Store; it is **sideloaded** with your own Apple ID. It is
unsigned — the sideloading tool signs it for you. Tested on an iPad 7th gen with iPadOS 18.

**From Windows or macOS:** [Sideloadly](https://sideloadly.io) — connect the iPad by USB,
drop the IPA in, enter your Apple ID, *Start*.

**From Linux:** Sideloadly has no Linux version; use
[Sideloader](https://github.com/Dadoum/Sideloader) or
**Plume Impactor** (both log in with your Apple ID and
install over USB). They need the Apple device services:

```sh
# Arch Linux
sudo pacman -S usbmuxd libimobiledevice
sudo systemctl start usbmuxd
idevicepair pair        # then tap "Trust" on the iPad
```

**On the iPad, after installing:**
- *Settings → General → VPN & Device Management* → your Apple ID → **Trust**.
- iPadOS 16+: *Settings → Privacy & Security → Developer Mode* → on (the iPad restarts).
- With a **free Apple ID** the app stops opening after **7 days** — install it again (your
  programs stay); at most 3 sideloaded apps at a time.

If the app ever shows a text report instead of starting, it is listing what went wrong — please
report it with a screenshot.

**Without installing anything:** open the website in Safari and use
[Remote mode](remote-mode.md) with a dongle on another device.

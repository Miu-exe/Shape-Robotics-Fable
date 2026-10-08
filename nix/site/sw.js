// Service worker for the hosted web app (robotics.miuthecat.uk): makes it installable
// ("Add to Home Screen") and keeps the server load near zero. Everything the app does runs on
// the device; after the first visit the server only answers "index.html changed or not".
//
// - On install it downloads every file listed in /precache.json (written by the build, see
//   vite.config.ts), so the app works offline right away — including the code-runner workers,
//   sounds and icons that are otherwise only fetched later. The optional vision libraries
//   (opencv, face-api) and two big example images are cached the first time they're used.
// - /assets/* names contain a content hash, so a cached copy is valid forever: cache-first.
// - The page and the other files (icons, manifest, vision models): network-first so updates
//   arrive, falling back to the cache when offline.
// Not registered inside the Android/iPad apps (they bundle the files themselves).
const CACHE = "fable-blocks-v1"

self.addEventListener("install", (event) => {
  event.waitUntil((async () => {
    const cache = await caches.open(CACHE)
    let files = []
    try {
      files = await (await fetch("/precache.json", { cache: "no-cache" })).json()
    } catch {
      // No list (e.g. an older build): fall back to caching files as they are used.
    }
    await cache.addAll([ "/", ...files ])
  })())
  self.skipWaiting()
})

self.addEventListener("activate", (event) => {
  event.waitUntil((async () => {
    for (const key of await caches.keys()) {
      if (key !== CACHE) await caches.delete(key)
    }
    await self.clients.claim()
  })())
})

self.addEventListener("fetch", (event) => {
  const request = event.request
  const url = new URL(request.url)
  if (request.method !== "GET" || url.origin !== self.location.origin) return

  if (url.pathname.startsWith("/assets/")) {
    event.respondWith((async () => {
      const cache = await caches.open(CACHE)
      const hit = await cache.match(request)
      if (hit) return hit
      const response = await fetch(request)
      if (response.ok) await cache.put(request, response.clone())
      return response
    })())
    return
  }

  event.respondWith((async () => {
    const cache = await caches.open(CACHE)
    try {
      const response = await fetch(request)
      if (response.ok) await cache.put(request, response.clone())
      return response
    } catch (error) {
      // Offline page loads: the cached app, or the cached links page for /remote.
      const page = url.pathname.startsWith("/remote") ? "/remote/index.html" : "/"
      const hit = (await cache.match(request)) ?? (request.mode === "navigate" ? await cache.match(page) : undefined)
      if (hit) return hit
      throw error
    }
  })())
})

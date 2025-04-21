---
title: Bypassing Spotify Desktop's Minimum Window Size
date: 2025-03-31T12:30:06-0700
tags:
  - tip
---

On my Windows PC, I modify my Spotify client with [Spicetify](https://spicetify.app/). Specifically, I use the [Full App Display](https://spicetify.app/docs/advanced-usage/extensions#full-app-display) extension to simply display the album art, artist, and song title on my second monitor. However, my second monitor is a portrait-oriented 1080x1920 display. Sometimes I would like to arrange Spotify on one quadrant of this screen, but the desktop client has a minimum width of ~800px for me.

I finally found a way to bypass this limit, courtesy of [`maxawake`](https://community.spotify.com/t5/Desktop-Mac/Smallest-window-size-is-too-large-when-using-low-resolution/m-p/6884196/highlight/true#M554490) on the Spotify Community forums. All I had to do is launch spotify with an obscure flag:

```sh
spotify --force-device-scale-factor=0.5
```

This works on both Windows and Linux for me. Though on Linux (`sway`), the minimum size is only enforced in floating mode; tiling mode seems to override it.

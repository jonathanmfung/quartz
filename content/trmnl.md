---
date: 2025-02-01
title: TRMNL
tags:
  - hardware
---
A e-ink dashboard device that offers open-source alternatives to their hardware (firmware) and software (web server).

The device does no rendering of it's own. It simply fetches an image from a web server and displays it. According to [their docs](https://docs.usetrmnl.com/go/how-it-works):

> 1.  TRMNL device wakes up and sends request to web server for displayable content every n period
> 2.  TRMNL web server generates a single-use, 1-bit, bitmap image (800x480 pixels). Response JSON includes a link to this image and timing instructions for the next "refresh" request.
> 3.  TRMNL device renders the content, then goes to sleep for the instructed amount of time.

TRMNL offers flexibility regarding how much a user wants to rely on the company or not. You can buy or build the device, and then use their or your server.

The rendering on the server is customized through Plugins, of which their is a open marketplace of official ones as well as community-submitted designs. There are also Playlists, which "manage the ordering of plugin instances".[^1]

-   <https://usetrmnl.com/>
-   [YT: Snazzy Labs - This Open-Source E-Ink Screen Is My Favorite New Gadget](https://www.youtube.com/watch?v=eIcZZX10pa4)
-   [Firmware](https://github.com/usetrmnl/firmware)
-   [Web Server](https://github.com/usetrmnl/byos_sinatra)

[^1]: [<https://docs.usetrmnl.com/go/diy/byod-s>](https://docs.usetrmnl.com/go/diy/byod-s)

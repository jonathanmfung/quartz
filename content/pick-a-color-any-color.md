---
title: Pick a Color, any Color
date: 2025-04-20T20:03:42-0700
tags:
  - color
---

For my [[busqer]] project, I was looking at ways to extract the dominant colors from an image, in this case an album cover. I simply want to fill the background with a nice color, dynamically.

Like starting any good research rabbit-hole, converting my abstract goal to a searchable query (with proper terms of art) takes some reflection:

I first came across this [StackOverflow post](https://stackoverflow.com/questions/3241929/how-to-find-the-dominant-most-common-color-in-an-image) where the OP shared a similar goal. The replies reminded me that /clustering/ is a term that exists.

I was reminded of this [YouTube video (timestamp 9:15)](https://youtu.be/HuW9qJbL0xM?t=555) discussing how to simplify Minecraft texture palettes using Mean Shift Clustering. The video does not explain it, but I think the algorithm terminates when no more clusters can be added-- i.e. every color is in a cluster. The video also does not explain where a new cluster is initialized. Assuming it's random, that is also my issue with the famous K-means algorithm. Yes, the bulk of the algorithm is deterministic, but the crucial step of initialization is random, thus producing different outputs for the same input. There are also concerns if input order is significant.

I eventually came across this paper: [Deterministic Initialization of the K-Means Algorithm Using Hierarchical Clustering](https://arxiv.org/pdf/1304.7465). It looks like a nice approach. Their technique takes inspiration from histogram partitioning in image processing.

I landed on some image processing textbook: [Basics of Image Processing](https://vincmazet.github.io/bip/segmentation/histogram.html). And then took a quick detour into Image Segmentation: [Thresholds and Color Spaces](https://medium.com/@johnsolomonlegara/thresholds-and-color-spaces-exploring-otsus-method-and-color-segmentation-159f848acc9c). I started to wonder if color segmentation was a thing, but was turned off because image segmentation seems more for spatial boundaries.

I somehow ended up on [Color quantization](https://en.wikipedia.org/wiki/Color_quantization) which is reducing the number of colors in an image. I was still a bit iffy on this technique because the number of resultant colors is still relatively large (~16). The article referenced an obscure method using [octrees](https://en.wikipedia.org/wiki/Octree#Application_to_color_quantization). This method constructs on octree where the the child index of a node is an octal digit corresponding to the most significant bit of each channel R, G, and B: $4r + 2g + 1b$ (à la `chmod`). The quantization actually occurs by reducing each child node up to it's parents, leveraging the fact that the MSB is at the root.

E.g: In a 12-bit RGB space: A parent at index `356_` (${(011\_,101\_,110\_)}_b$ , ${(6, 10, 12)}_d$) has children at `[2,5,4]`. Those children get reduced so now `[3562, 3565, 3564]` (${(6, 11, 12)}_d, {(7, 10, 13)}_d, {(7, 10, 12)}_d$) all map to `356_`.

This [old article](https://web.archive.org/web/20250121154225/https://www.cubic.org/docs/octree.htm) and this [2016 paper](https://pmc.ncbi.nlm.nih.gov/articles/PMC4738736/) are also good references. This method was first published in [1988](https://link.springer.com/chapter/10.1007/978-3-642-83492-9_20) with an implementation on the VAX 11/730 minicomputer.

I was still looking for methods to extract a handful of dominant colors, and came across this [StackOverflow post](https://stackoverflow.com/a/79136387/28633986) that pointed me towards Google/Android's [Material Color Utilities](https://github.com/material-foundation/material-color-utilities). A couple of years ago, the Material Design System was overhauled to be centered around Material You. A core part of this design ecosystem was allowing custom color palettes, color schemes, and themes that could be easily generated (usually from a wallpaper). I've always wondered about the [color science](https://m3.material.io/blog/science-of-color-design) of their research and implementation, but the [first step](https://github.com/material-foundation/material-color-utilities?tab=readme-ov-file#capabilities-overview) in the process, which they call "Quantize", is based on a 1991 article [Efficient Statistical Computations for Optimal Color Quantization](https://theswissbay.ch/pdf/Gentoomen%20Library/Game%20Development/Programming/Graphics%20Gems%202.pdf) and a 2011 paper [Improving the Performance of K-Means for Color Quantization](https://arxiv.org/abs/1101.0395).

Underlying all of this is me wondering if RGB-defaultism will be my downfall. I'm sure using one of the fancy new colorspaces is conducive towards deciding a "dominant" color.

> [!remark]-
> Spotify has an internal API called "colorextractor" https://github.com/spicetify/cli/blob/41ed71842258a77dc4725ea70a397f83021b7f12/jsHelper/spicetifyWrapper.js#L1184 .
> It requires some sort of user token.

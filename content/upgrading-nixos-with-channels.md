---
title: Upgrading NixOS with Channels
date: 2025-12-02T12:33:20-0800
tags:
  - nixos
---
1. Clone https://github.com/NixOS/nixpkgs as `~/nixpkgs`  (or whatever path you prefer).
  - Make sure to `git pull` if already cloned.
2. Inside the Git repo, checkout the latest tag `git checkout <YY-MM>`.
  - Use to get recent tags: `git tag --list '[0-9][0-9].*' --sort=creatordate | tail`.
3. Rebuild NixOS with this path: `nixos-rebuild switch -I nixpkgs=~/nixpkgs`.

---
title: Setting Kernel Parameters in NixOS
date: 2025-06-12T21:49:07-0700
tags:
  - nixos
  - linux
---

> [!TLDR]-
> ``` nix title="configuration.nix"
> boot.kernelParams = [
>   "amdgpu.dcdebugmask=0x10"
> ];
> ```

# A Problem #

I recently updated my NixOS channels

I had an issue with my laptop where the display would just lock up for no apparent reason. I would have to force shut down, but one time I was able to jump into a tty and get a glimpse of the error logs.

I find a few Arch[^1] and Framework[^2] support threads that eventually pointed to [drm/amd #3647](https://gitlab.freedesktop.org/drm/amd/-/issues/3647). Users on the threads and issue tracker said to add 'amdgpu.dcdebugmask=0x10' to the "kernel parameters", or that they were "testing with [it]", or to"boot with [it]", or to "add `options amdgpu dcdebugmask=0x10` to the modprobe config". Setting this parameter would disable something called "Panel Self-Refresh", which I believe is connected to adaptive refresh rate. (For my sanity, this was enough to satiate my curiosity)

I've only heard of kernel parameters by name before, but kind of just thought they were flags to set when compiling the kernel from source. So I had to find out what "booting with" and modprobe actually meant. Additionally, because NixOS takes a fundamentally different approach to configuration than most other Linux distros, it's always a bit of a journey to figure out how to apply these lower-level tweaks.

# And a Solution #

I found a couple NixOS attributes as interfaces for setting kernel parameters: `boot.kernelParams{:nix}`, `boot.kernel.sysctl{:nix}`, and `boot.extraModprobeConfig{:nix}`. To actually test these options I also had to figure out how to check if this parameter value was _actually_ set.

``` nix title="NixOS attribute options"
# Attribute 1
boot.kernelParams = ["amdgpu.dcdebugmask=0x10"];

# Attribute 2
boot.kernel.sysctl = {"amdgpu.dcdebugmask" = "0x10";};

# Attribute 3
boot.extraModprobeConfig = ''
  options amdgpu dcdebugmask=0x10
'';
```

Initially, I found two methods for introspection:
- Directory `/proc/sys` which is usually accessed by the `sysctl <mymodule>{:bash}` wrapper. The man page states: "`sysctl {:bash}` is used to modify kernel parameters at run time."
- A file with path resembling `/sys/module/<mymodule>/parameters/<paramname>` which seems to have more modules than the previous

(Later on I found `modprobe --showconfig | grep <mymodule>{:bash}`, which dumps the effective configuration of a module.)

``` bash title="Introspection options"
ls /proc/sys/amdgpu                           # Introspection 1
cat /sys/module/amdgpu/parameters/dcdebugmask # Introspection 2
```

> [!Aside]+
> This cursory search planted a seed of inquiry: "What _is_ a kernel parameter?". My future self ended up falling into this [[linux-kernel#Kernel Parameters| rabbit hole]].

Here is a table that shows if the introspection option correctly showed the configured value for the respective attribute option. I also rebooted my system each time.

|                                  | `/proc/sys` | `/sys/.../<paramname>` |
|---------------------------------:|:-----------:|:----------------------:|
|        `boot.kernelParams{:nix}` | No          | Yes                    |
|       `boot.kernel.sysctl{:nix}` | No          | No                     |
| `boot.extraModprobeConfig{:nix}` | No          | Yes                    |

In conclusion, I have no idea what the difference is between all these different options. I ended up going with `boot.kernelParams{:nix}` because it seemed the most canonical.


[^1]: https://bbs.archlinux.org/viewtopic.php?id=302499

[^2]: https://community.frame.work/t/responded-framework-13th-gen-diy-ubuntu-screen-super-laggy-1fps-on-occasion/31767/7

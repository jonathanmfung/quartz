---
title: Linux Kernel
date: 2025-06-17T16:07:56-0700
tags:
  - linux
---

# Bootconfig #

https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#proc-bootconfig

The "kernel command line" can also be inspected: `cat /proc/cmdline | sed "s/ /\n/g"`

This introduces the distinction between Kernel Parameters and Kernel Module Parameters.

It also seems that within Kernel Modules, they can either be built-in or loadable

to intospect I need to figure out what i'm actually dealing with

good SE post on kernel parameters vs module parameters vs sysctl parameters https://unix.stackexchange.com/a/123050

# Kernel Parameters #
https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.rst:
> list of the kernel parameters as implemented by the __setup(), early_param(), core_param() and module_param() macros

> modprobe looks through the kernel command line (/proc/cmdline) and collects module parameters when it loads a module, so the kernel command line can be used for loadable modules too.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/moduleparam.h

- The macro `module_param` is a "typesafe helper for a module/cmdline parameter"
- `core_param` is a special case of `module_param`
- macro `__module_param_call` refers to "registering boot/module parameters"

https://sysprog21.github.io/lkmpg/

`__init` and `__exit` are defined in `<linux/init.h>`
`module_init` and `module_exit` are defined in `<linux/module.h>`

`__init` and `__exit` are used to annotate functions for the kernel's use

For built-in modules `__init` is used to free the `module_init` function.
For built-in modules `__exit` is used to omit the `module_exit` function.
For loadable modules both `__init` and `__exit` are ignored.

It seems to me that "external" is the same as "out-of-tree" is the same as "loadable", and vice versa with "in-tree" and "built-in" (https://www.kernel.org/doc/html/latest/kbuild/modules.html).

Device drivers are a specific type of module. Character Devices are associated with an abstract file `<linux/fs.h>`, which are accessed through `/dev`

`<linux/sysfs.h>` can be inside a module source file to define a module attribute

# DAMON #
https://www.kernel.org/doc/html/latest/mm/damon/design.html#modules
> Kernel Modules fall under the DAMON subsystem, which itself falls under the Memory Management subsystem. There are two types of DAMON modules: General Purpose User Interface Modules and Special-Purpose Access-aware Kernel Modules.

Maybe DAMON modules are different from Kernel Modules?

# `sysfs` #
https://docs.kernel.org/filesystems/sysfs.html
`sysfs` is used to "export kernel data structures, their attributes, and the linkages between them to userspace"

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/sysfs.h
`sysfs` defines `struct attribute {const char *name; umode_t mode;`}

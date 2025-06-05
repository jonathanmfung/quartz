---
title: Tables in Emacs
date: 2025-05-28T15:50:24-0700
tags:
  - emacs
---

Emacs has two built-in ways to create and display tables in buffers.

`tabulated-list-mode` is the original method circa 2011. As the name implies, it formats a list of entries as a table. `tabulated-list-mode` is a major mode meant to be derived from. Adding a command that acts on the object under point means invoking `tabulated-list-get-entry`and defining a mode-map. Many built-in listing functions are based on it: `list-processes`, `list-buffers`, `list-threads`. However, some like `proced` (`proced-format`) are not.

In 2022 (v29), [`vtable`](https://www.gnu.org/software/emacs/manual/html_node/vtable/Introduction.html) was introduced as an alternative to `tabulated-list-mode`. It's primary strength is displaying fixed-width tables while using a variable pitch font (hence the prefix 'v'). A `vtable` also does not need a dedicated buffer; it can be mixed with other text in a buffer including other `vtable`s. Adding a command that acts on the object under point means adding a function to the `:actions` arg for `make-vtable`. One negative is that the column alignment is achieved through the text property `:display (space :width (N))` (Specified Space), which means that `text-scale-adjust` breaks this alignment.

`vtable` is a more casual and simpler interface, everything can be defined through the main `make-vtable` DSL. `tabulated-list-mode` is a more traditional approach with major-modes, keymaps, and buffer-local variables.

---
date: 2025-02-03
title: Hashing in Emacs
tags:
  - emacs
  - hash
---

Here are a couple ways to hash a file in emacs, useful for a content-based addressing system or cache.

``` elisp
(let ((file "~/nixos-dotfiles/configuration.nix"))
  `((with-temp-buffer ,(with-temp-buffer
             (insert-file-contents file)
             (buffer-hash (current-buffer))))
    (secure-hash ,(secure-hash 'md5 (with-temp-buffer
                      (insert-file-contents file)
                      (buffer-string))))
    (sxhash ,(sxhash (with-temp-buffer
               (insert-file-contents file)
               (buffer-string))))))
```

| Method           | Hash Value                               |
|------------------|------------------------------------------|
| with-temp-buffer | 7f5608425946119d8e8c7585fa74377e0814395a |
| secure-hash      | 4eb44892df2c033a6d706efe53532abb         |
| sxhash           | 1166580554335810656                      |

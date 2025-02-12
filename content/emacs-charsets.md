---
date: 2025-02-03
title: Emacs Charsets
tags:
  - emacs
---

Use `(nth 2 (charset-priority-list)){:elisp}` to access the 3rd highest priority charset.

These charsets have properties such as `(get-charset-property (nth 2 (charset-priority-list)) :code-space){:elisp}` `[0 255 0 255 0 16 0 0]` that are used in `list-charset-chars{:elisp}` to display a charset as a buffer. `define-charset{:elisp}` has documentation for these properties.

There is also `describe-charset{:elisp}` and `read-charset{:elisp}`for interactive purposes. This effectively uses `intern{:elisp}` under the hood, e.g. `(list-charset-chars (intern "ascii")){:elisp}`

Here we see the different representations of ㄲ and how to encode/decode between Emacs' code-point representation (Unicode) and a particular charset (Korean-ksc5601).

```elisp
(let* ((char ?ㄲ)
       (hex-str (format "%X" char))
       (kr-charset (intern "korean-ksc5601"))
       (char-kr (encode-char char kr-charset))
       (hex-str-kr (format "%X" char-kr)))
  (when (= (decode-char kr-charset char-kr) char)
    `(("Charset" "Decimal" "Hex")
      (Unicode ,char ,hex-str)
      (Korean-ksc5601 ,char-kr ,hex-str-kr))))
```
| Charset        | Decimal | Hex  |
|----------------|:-------:|:----:|
| Unicode        | 12594   | 3132 |
| Korean-ksc5601 | 9250    | 2422 |

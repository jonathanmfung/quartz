---
date: 2025-02-03
title: Ways to Export Org to HTML
tags:
  - emacs
  - html
  - orgmode
  - pandoc
---

Exporting this file via `org-mode`

``` elisp
(prog1
    (benchmark-elapse
      (org-html-export-to-html))
  (delete-file "20250203T102727--ways-to-export-org-to-html__emacs_html_orgmode_pandoc.html"))
```

Exporting this file via `pandoc`

```bash
cd ~ # For some reason pandoc cannot access ~/Zotero, need to be in home dir
hyperfine "pandoc -f org -t html ~/denote-notes/20250203T102727--ways-to-export-org-to-html__emacs_html_orgmode_pandoc.org -o /tmp/test_pandoc.html --citeproc --bibliography='Zotero/My Library.bib' --csl='Zotero/styles/ieee.csl'"
```

For pandoc, format footnotes with `<ol>{:html}` `list-style-type: cjk-earthly-branch;{:css}` (`lower-roman`). However, this does not modify the foonote-ref number - the mark used in-text.

Org-mode allows for clickable in-text citations, to jump to the bibliography.

Org-mode also needs `htmlize{:elisp}` to properly syntax-highlight source blocks: <https://emacs.stackexchange.com/questions/31439/how-to-get-colored-syntax-highlighting-of-code-blocks-in-asynchronous-org-mode-e>.

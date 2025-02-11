---
date: 2025-02-02
title: Ways to Export Denote to HTML
tags:
  - emacs
  - orgmode
  - html
---
A variant of [Ways to Export Org to HTML](20250202T151959--ways-to-export-denote-to-html__emacs_html_orgmode) but with Denote, specifically to include a note's backlinks.

``` elisp
;; original method in Totality
(benchmark-elapse
   (save-excursion
     (goto-char (point-max))
     (insert "\n\n* Backlinks")
     (denote-org-extras-dblock-insert-backlinks)
     (org-html-export-to-html)
     (revert-buffer nil t)))
```

``` elisp
;; https://emacs.stackexchange.com/a/31755
(benchmark-elapse
  (catch 'done
    (atomic-change-group
      (goto-char (point-max))
      (insert "* Backlinks ")
      (denote-org-extras-dblock-insert-backlinks)
      (org-html-export-to-html)
      (throw 'done nil))))
```

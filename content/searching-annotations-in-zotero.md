---
title: Searching Annotations in Zotero
date: 2025-05-28T19:50:05-0700
tags:
  - zotero
---

Courtesy of [kassiansun](https://forums.zotero.org/discussion/102683/search-annotations-of-pdfs).

- Both highlights and sticky notes are considered Annotations
    - highlights default with an associated `text`
    - sticky notes default with an associated `comment`

It is trivial to modify the query to do a string search (`where ia.comment like '%foo%'`).

``` bash
# Since we want to use `-wrap` & `-ww` in CLI (not sqlite3 repl), shove into the `-cmd` that runs initially
sqlite3 zotero.sqlite -header -cmd ".mode box -wrap 20 -ww" \
	"select v.value as item, ia.text, ia.comment, ipa.path from itemAnnotations ia
	left join items i on ia.itemID = i.itemID
	left join itemAttachments ipa on ia.parentItemID = ipa.itemID
	left join items ipp on ipa.parentItemID = ipp.itemID
	left join itemData d on d.itemID = ipp.itemID and d.fieldID = 1
	left join itemDataValues v on d.valueID = v.valueID;"
```

```
┌─────────────────────┬──────────────────────┬─────────────────────┬──────────────────────┐
│        item         │         text         │       comment       │         path         │
├─────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┤
│ The Implementation  │                      │ Substitution        │ storage:slpj-book-   │
│ of Functional       │                      │                     │ 1987-small.pdf       │
│ Programming         │                      │                     │                      │
│ Languages           │                      │                     │                      │
├─────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┤
│ The Implementation  │                      │ The Name-capture    │ storage:slpj-book-   │
│ of Functional       │                      │ Problem             │ 1987-small.pdf       │
│ Programming         │                      │                     │                      │
│ Languages           │                      │                     │                      │
├─────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┤
│ Hashing modulo      │ two subexpressions   │                     │ storage:Maziarz et   │
│ alpha-equivalence   │ are α-equivalent     │                     │ al. - 2021 -         │
│                     │ iff their e-         │                     │ Hashing modulo       │
│                     │ summaries are        │                     │ alpha-equivalence.   │
│                     │ equal.               │                     │ pdf                  │
├─────────────────────┼──────────────────────┼─────────────────────┼──────────────────────┤
│ Hashing modulo      │ Let us call “the     │                     │ storage:Maziarz et   │
│ alpha-equivalence   │ result of processing │                     │ al. - 2021 -         │
│                     │ an expression” the   │                     │ Hashing modulo       │
│                     │ e-summary for that   │                     │ alpha-equivalence.   │
│                     │ expression.          │                     │ pdf                  │
│                     │ expression.          │                     │ pdf                  │
└─────────────────────┴──────────────────────┴─────────────────────┴──────────────────────┘
```

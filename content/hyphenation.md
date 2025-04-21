---
title: Hyphenation
date: 2025-02-17T12:49:47-0800
tags:
  - linguistics
  - typesetting
wip: true
---

Hyphenation is the necessary feature to have reflowable words in a piece of text. Just as newlines are necessary for reflowable sentences, hyphens are necessary for reflowable words. A hyphenation algorithm determines where a given word can be split up-- where a hyphen, or hyphens, can be inserted. The trivial solution is anywhere within a word, but that does not bode for a nice reading experience. As such, proper hyphenation is closely related to syllabification, the process of dividing words into its syllabic parts. In my view, syllabification is a *hard* problem because it needs to account for locales, dialects, and stylistic choices.

> [!note]+
> Example text from https://en.wikipedia.org/wiki/Syllabification
>
> The manual example also uses a basic form of justification: The prior part of a hyphenation split may terminate the line before the max column size if the posterior part would terminate the line after the max column size; e.g. Lines 1-2, 2-3, and 5-6.
>
> This is also applied when the word cannot be split; e.g. Lines 4-5 and 6-7

``` text title="Trivial reflowable words at (column size = 50)"
At the end of a line, a word is separated in writ-|
ing into parts, conventionally called "syllables",|
if it does not fit the line and if moving it to t-|
he next line would make the first line much short-|
er than the others. This can be a particular prob-|
lem with very long words, and with narrow columns |
in newspapers. Word processing has automated the  |
process of justification, making syllabification -|
of shorter words often unnecessary.               |
```

``` text title="Manual reflowable words at syllables (column size = 50)"
At the end of a line, a word is separated in wri- |
ting into parts, conventionally called "sylla-    |
bles", if it does not fit the line and if moving  |
it to the next line would make the first line     |
much shorter than the others. This can be a par-  |
ticular problem with very long words, and with    |
narrow columns in newspapers. Word processing has |
automated the process of justification, making sy-|
llabification of shorter words often unnecessary. |
```

The need for hyphenation algorithms arose from the digital typesetting environment TeX. One of the first publications was Frank Liang's PhD thesis, advised by Donald Knuth.[^1]

---

Hyphenation algorithms can be split into two categories: data- or heuristic-driven. Liang's seminal method is data-driven.


https://hyphenation.org/

[^1]: https://tug.org/docs/liang/liang-thesis.pdf

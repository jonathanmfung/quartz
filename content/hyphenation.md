---
title: Hyphenation
date: 2025-02-17T12:49:47-0800
tags:
  - linguistics
  - typesetting
---

Hyphenation is the necessary feature to have reflowable words in a piece of text. Just as newlines are necessary for reflowable sentences, hyphens are necessary for reflowable words. A hyphenation algorithm determines where a given word can be split up-- where a hyphen, or hyphens, can be inserted. The trivial solution is anywhere within a word, but that does not bode for a nice reading experience. As such, proper hyphenation is closely related to syllabification, the process of dividing words into its syllabic parts. In my view, syllabification is a *hard* problem because it needs to account for locales, dialects, and stylistic choices.

The need for hyphenation algorithms arose from the digital typesetting environment TeX. One of the first publications was Frank Liang's PhD thesis, advised by Donald Knuth.[^1]

---

Hyphenation algorithms can be split into two categories: data- or heuristic-driven. Liang's seminal method is data-driven.


https://hyphenation.org/

[^1]: https://tug.org/docs/liang/liang-thesis.pdf

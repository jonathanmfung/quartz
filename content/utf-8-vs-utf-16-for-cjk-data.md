---
title: UTF-8 vs UTF-16 for CJK Data
date: 2025-05-14T10:20:34-0700
tags:
  - unicode
---

- [Character encoding in corpus construction (2004) - Anthony McEnery, Zhonghua Xiao](https://users.ox.ac.uk/~martinw/dlc/chapter4.htm)
    - Page 10: "While UTF-32 is wasteful of memory and disk space for all languages, UTF-16 also doubles the size of a file containing single-byte characters (such as English), though for CJK languages that have already used 2-byte encodings traditionally, the file size remains more or less the same."
- [ICU4C FAQ](https://unicode-org.github.io/icu/userguide/icu4c/faq.html#what-computer-languages-does-icu-support)
    - What is the performance difference between UTF-8 and UTF-16?
    - Most of the time, the memory throughput of the hard drive and RAM is the main performance constraint. UTF-8 is 50% smaller than UTF-16 for US-ASCII, but UTF-8 is 50% larger than UTF-16 for East and South Asian scripts. There is no memory difference for Latin extensions, Greek, Cyrillic, Hebrew, and Arabic.
    - For processing Unicode data, UTF-16 is much easier to handle. You get a choice between either one or two units per character, not a choice among four lengths. UTF-16 also does not have illegal 16-bit unit values, while you might want to check for illegal bytes in UTF-8. Incomplete character sequences in UTF-16 are less important and more benign. If you want to quickly convert small strings between the different UTF encodings or get a UChar32 value, you can use the macros provided in utf.h and its siblings utf8.h and utf16.h. For larger or partial strings, please use the conversion API.

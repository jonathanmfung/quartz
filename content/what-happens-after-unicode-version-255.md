---
title: What happens after Unicode Version 255?
date: 2024-10-24T22:29:00-0700
tags:
  - unicode
---

>[!remark]-
> I originally posted this question on superuser.com,
> but it was deemed not within scope.
>
> I also received two comments:
> > There are a lot more pressing issues to spend time on.
>
> > Like the year 10000 problem - it won't happen in our lifetime, so not worth worrying about.

The range of Unicode Versions is given by [Unicode Standard V16
#3.1.2](https://www.unicode.org/versions/Unicode16.0.0/core-spec/chapter-3/#G49512):

> Version numbers for the Unicode Standard consist of three fields,
> denoting the major version {\...}. For example, "Unicode 5.2.0"
> indicates major version 5. {\...} the version fields are limited to
> values which can be stored in a single byte. The major version is a
> positive integer constrained to the range 1..255

Together with the [version scheduling system](https://www.unicode.org/versions/Unicode16.0.0/core-spec/chapter-3/#G63430):

> Major releases of the standard are now scheduled for annual publication

Assuming this version scheduling system does not change; extrapolating from Version 16 @ 2024 gives Version 255 @ 2263.

Although this is a very far date in the software world, given that Unicode is meant to be a universal standard, my questions are:

1.  Are there any plans described by the Unicode Technical Committee to handle this issue?

2.  (Extra) Is there any reason why the UTC decided to use only one byte for the major version? (opposed to 2)

3.  (Very Extra) Consider the hypothetical case that the UTC modifies the major version to be 2 bytes. As I understand, the Standard only prescribes stability guarantees like backwards compatibility to "pragmatic" features such as codepoints and properties. What types of software and systems would be impacted by this kind of "meta" change?

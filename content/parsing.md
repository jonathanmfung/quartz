---
title: Parsing
date: 2025-06-09T14:47:09-0700
tags:
  - parsing
  - computer-science
---

From [@peytonjonesImplementingFunctionalLanguages2000, sec. 1.6]:
- `type Parser a = [Token] -> [(a, [Token])] {:haskell}`
    - Output being a list encodes the possibility of no parse (empty), unique parse (singleton), or ambiguous parse (multiple)
        - This is assuming the grammar is ambiguous

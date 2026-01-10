---
title: Parsing
date: 2025-06-09T14:47:09-0700
tags:
  - parsing
  - computer-science
---

Parsing, in general, is converting a sequence of alphabet symbols to a nicer representation, usually some memory-aware struct or abstract syntax tree.

Parsing can be converting a binary stream to a 2s complement integer. Parsing can be converting a lexeme sequence to a algebraic data type-encoded syntax tree. Parsing can be converting a sequence of binary operators and arguments to a precedence-encoding tree. Parsing can be converting an HTTP header to a server request operation.

Many data transformations are parsing, but only some fall under the computer science term-of-art of _parsing_.

---

From [@peytonjonesImplementingFunctionalLanguages2000, sec. 1.6]:
- `type Parser a = [Token] -> [(a, [Token])] {:haskell}`
    - Output being a list encodes the possibility of no parse (empty), unique parse (singleton), or ambiguous parse (multiple)
        - This is assuming the grammar is ambiguous

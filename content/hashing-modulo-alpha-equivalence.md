---
title: Hashing Modulo Alpha-Equivalence
date: 2025-05-20T11:21:57-0700
tags:
  - bib
  - hash
  - abstract-syntax-tree
  - compilers
---
@maziarzHashingModuloAlphaequivalence2021

- Overall algorithm is $O(n(\log n)^2)$
- identify identical subtrees in an AST, robust to alpha-renaming
    - specifically hashing, as applied to Common Subexpression Elimination (CSE)
- 4 Types of equivalence for subexpressions
    - Syntactic equivalence
    - α-equivalence (alpha-equivalence)
        - Focus of this paper
        - `\x.x+y` equivalent to `\p.p+y`
    - Graph equivalence
        - `(let x=e1 in let y=e2 in x+y)` equivalent to `(let y=e2 in let x=e1 in x+y)` equivalent to `(e1+e2)`
        - let-expressions express lifetimes and evaluation order
    - Semantic equivalence
        - `(3+x+4)` equivalent to `(x+7)` equivalent to `(7+x)`
        - undecidable
- To avoid false positives (name overloading) in syntactic equality, assume that expressions are preprocessed "so that every binding site binds a distinct variable name"
    - AKA [[barendregt-convention]]
- de Bruijn indexing is a form of nameless representation, to be insensitive to alpha-renaming
    - Negative: terms need to be re-indexed when substituted into other expressions
    - According to [14] http://reports-archive.adm.cs.cmu.edu/anon/2002/CMU-CS-02-120.pdf
        - "Our experiment provides evidence, at least, that mixing [de Bruijn terms and Named terms] does not appear to be efficient enough to be effective."
- "Given an expression e, in which every binding site binds a distinct variable name, identify all equivalence classes of subexpressions of e, where two subexpressions are equivalent if and only if they are α-equivalent. We wish to achieve this goal in a way that is: [compositional and sub-quadratic]"
- *e-summary* is "the result of processing an expression"
    - "two subexpressions are alpha-equivalent iff their e-summaries are equal"
- Full algorithm
    - Goal: convert an `Expression` into an `ESummary`, a pair of `Structure` and `VariableMap`
        - `Structure` is the expression with anonymized variables
        - `VariableMap` is a map of free variables and their directions to locate their position in the `Structure`
            - These directions also form a tree (`PosTree`)
    - Time-complexity is reduced by tweaking the `VariableMap` merge in the `App` case to tend towards *unbalanced* trees.
    - The naive algorithm is $O(n^2)$ and the full algorithm is $O(n(\log n)^2)$
    - `ESummary`s are only useful because they can be hashed
    - Hashing `Structure` is trivial, but `VariableMap` requires leveraging a hash combiner that is associative, commutative, and invertible
        - They use `XOR` which despite being a cryptographically weak hash combiner, still achieves low hash collisions
        - Invertibility (involution?) is leveraged when removing an element from the map
- This algorithm is generally faster compared to [@chargueraudLocallyNamelessRepresentation2012] in synthetic and practical (ML expressions) benchmarks

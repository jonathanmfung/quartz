---
title: Equality in Programming Languages
date: 2025-03-03T15:27:26-0800
tags:
  - programming-languages
---

As one of the main purposes of programming languages is abstraction, the question of what is and is not equal is not as simple as it sounds.

In OCaml, there are two operators for equality: `={:ocaml}` and `=={:ocaml}` (and their negations `<>{:ocaml}` and `!={:ocaml}`).[^1] `={:ocaml}` is for structural equality and `=={:ocaml}` for physical equality.

Structural equality is what a programmer wants in general. Physical equality has usecases for mutable types. "Physical" roughly means physical modification, i.e. mutation of x also mutates y in `x == y{:ocaml}`. For non-mutable types the same expression implies `compare x y = 0{:ocaml}`.

```ocaml
assert (1 = 1);;
assert (1 == 1);;
assert (1.0 != 1.0);;
assert ([1;2] = [1;2]);;
assert ([1;2] != [1;2]);;
(* Nested Array.make means aliasing,
where the 3 elements of the outer array point to the same inner array *)
let x = Array.make 3 (Array.make 4 'a') in
  assert (x.(0) = x.(1));
  assert (x.(0) == x.(1));;
(* Array.make_matrix correctly creates 3 sepearate inner arrays
that the 3 elements of the outer array respectively point to *)
let y = Array.make_matrix 3 4 'a' in
  assert (y.(0) = y.(1));
  assert (y.(0) != y.(1));;
```

[^1]: https://ocaml.org/manual/latest/api/Stdlib.html#1_Comparisons

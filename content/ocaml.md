---
title: OCaml
date: 2025-03-04T14:04:56-0800
tags:
  - ocaml
---

# `ref`s and `mutable` record fields
A record field can be designated as `mutable`. This allows the `<-` operator to be used, which modifies the value that `f` is pointing to. More formally:
>The expression `expr1 . field <- expr2` evaluates `expr1` to a record value, which is then modified in-place by replacing the value associated to `field` in this record by the value of `expr2`. This operation is permitted only if `field` has been declared mutable in the definition of the record type.[^1]


``` ocaml
type foo = { mutable alpha: int; beta: string };;
let f = { alpha = 0; beta = "abc" } in
  f.alpha <- 5;
  f;;

type bar = { delta: int; gamma: string };;
let b = { delta = 0; gamma = "abc" } in
  { b with delta = 5 };;
```

The `ref` type (short for "references") is essentially syntactic sugar for a record with a single mutable field.[^2]

``` ocaml
#show_type ref;;
(* type 'a ref = { mutable contents : 'a; } *)

#show (!);;
(* ( ! ) : 'a ref -> 'a = "%field0" *)
(* Equivalent to: let ( ! ) r = r.contents *)

#show (:=);;
(* ( := ) : 'a ref -> 'a -> unit = "%setfield0" *)
(* Equivalent to: let ( := ) r x = r.contents <- x *)
```

[^1]: https://ocaml.org/manual/5.3/expr.html#sss:expr-records

[^2]: https://cs3110.github.io/textbook/chapters/mut/mutable_fields.html

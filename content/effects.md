---
title: Effects
date: 2025-07-14T15:55:57-0700
tags:
  - programming-languages
---

# OCaml #

> [!note]-
> - OCaml effects are a language extension introduced in 5.0.
> - OCaml effects are untyped.

An effect is defined like:
```ocaml
(* Effect is a built-in module *)
type _ Effect.t += TransformNumber: int -> int Effect.t
```

An effect handler is a block that 'try-withs' an effectful computation, like:

```ocaml
let calculate () = 10 + Effect.perform (TransformNumber 0) + 30

let handle_transform_number () =
  try
    calculate ()
  with
  | effect (TransformNumber n), k -> Effect.Deep.continue k (n+20)
```

> [!details]-
> ```ocaml
> val perform : 'a eff -> 'a
> val continue : ('a, 'b) continuation -> 'a -> 'b
> ```
> `'a eff` is mostly synonymous with `'a Effect.t`

As evident by the syntax, effect handlers are generalizations of exception handlers. The distinguishing factor is the delimited continuation `k` that can be resumed with `continue`. _Effect handlers give meaning to the handled effects_. Here, the meaning given to the `TransformNumber` effect is to add 20 to the initial value.

One way to think about the relationship between effectful computations and effect handlers is the following. Sometimes computations need to perform effects, such as making an HTTP request, using a cache, or accessing a database. Most of the time, the effectful part is a small part of the overall function -- say just a single variable. This is the portion that is annotated with `perform`.

Now that a pure computation is converted to an effectful one, there needs to be a layer above to actually manage the raised effect. For the database example, there could be one version for unit testing and another for the real database. Either way the handler would manage the connection and pass a resultant value to the continuation `k`; now the underlying computation "feels pure".

[@hoffmanUnisonAbilitiesOCaml2025]

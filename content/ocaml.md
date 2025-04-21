---
title: OCaml
date: 2025-03-04T14:04:56-0800
tags:
  - ocaml
---

> [!note]Resources
> [@conchonLearnProgrammingOCaml2025],


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

# Records & Row Polymorphism
This is so weird to me. I guess the idea is that modules should be pretty self-contained. I've never seen shadowing(?) of record labels
``` ocaml
type foo = { a : int; b : int };;
let func1 { a = x } = x;; (* foo -> int *)

type bar = { a : string };;
let func2 { a = x } = x;; (* bar -> string *)
(* Cannot write `let func2 { a : int = x } = x` *)
```

# Modules & Interfaces
A Module (`struct` ... `end`) is a way to group functions and values together.

A Module Signature (`sig` ...  `end`) is the same thing as an Interface. They define what is publicly accessible. Defining a Module without a Signature automatically creates a Signature with everything publicly accessible.

Module Signatures are the same as Module Types. "Interface" may also refer to a separate `.mli` file.

A Functor (`module MyFunctor (T : TYPEA) : TYPEB = struct ... end{:ocaml}`) is a function from a Module of some Signature to a Module with some other Signature.

An Abstract Type cannot be constructed natively, only through the module's functions, if they even exist.

A Private Type ...

# Runtime
OCaml values are encoded as *[[tagged-pointer | tagged pointers]]*. This is the reason why `int` is effectively only 31/63 bits.[^3]

A block of size k is represented as k allocated cells and 1 header. The header is composed of 3 sections: size, GC, and tag. The size field is simply the integer size of the block (k). The GC field is used by the Garbage Collector to determine if the memory is being used. The tag is something like a type constructor and is used to implement pattern matching.

Functions are normal values, so they represented as a pointer to a block. Implementation-wise, they are represented as a Closure, which is 1. a pointer to executable code and 2. the environment. The environment is usually the free variables in the function body. Applying a closure `f` to value `v` means invoking `f`'s executable code and passing the environment and `v` to it.

# Constructors
It bothers me that constructors must take their arguments as a tuple, and thus are different from normal functions. I guess it more accurately reflects that the constructor is defined with `*`-- that they are just tuples.

``` ocaml
type foo = Foo of int * int;;
Foo(1,2);;

let bar = fun x y -> (x, y);;
bar 1;;
bar 1 2;;
```

Maybe it's just the error message that occurs when you improperly apply a construct. I interpret this message's "argument" as the same as a function argument.
``` ocaml
(* Both ways give the same error message *)
Foo 1;;
Foo (1);;
(* Error: The constructor "Foo" expects 2 argument(s),
          but is applied here to 1 argument(s) *)
```

What's even weirder is the unary constructors can have their parentheses omitted.
``` ocaml
type qux = Qux of int;;
Qux 2;;
```

# Bitwise logical operators
OCaml is the only language I've seen that calls the operation `4 ⋅ 2 = 0` (in binary: `0010 ⋅ 0100 = 0000`) "Bitwise logical 'and' on integers". Likewise for or/xor/shift left/shift right.[^4]

# `with` operator
I am a bit confused about the `with` operator used in module constraints.[^5]

When I define a functor like:
``` ocaml
module Make(L : Letter) : PersistentSet with type elt = L.t list = struct
  type elt = L.t list
  module M = Map.Make(L)
  type t = {word : bool; branches: t M.t}
  (...)
end
```

There are two instances of `type elt = L.t list{:ocaml}`. I am unsure why both are necessary, I imagine it would be possible to copy the one in line 1 to line 2. It seems that line 1 is part of the functor's signature, so that is another argument to line 1's necessity ([example](https://ocaml.org/manual/5.3/api/Map.html)).

# Directory structure and Modules
It seems that in a project, if the library root of `Library` is `./lib`, then files are implicitly converted to a module. E.g. a file:
``` ocaml title="./lib/foo.ml"
module Bar : sig
  type t
  val qux : unit -> t
end = struct
  type t = int
  let qux () = 2
end
```

then in `dune utop lib` this can be accessed by `Library.Foo.Bar{:ocaml}`

# Lwt_react Examples
Can substitute `Lwt_react` for `React`

``` ocaml title="Basic Counter"
let printer s =

let () =
  Lwt_main.run
    (let my_sig, set = Lwt_react.S.create 0 in
	(* Every time signal gets updated, printf is called with its new value *)
	(* This is because the result of S.map (`_`) is also a signal, which reacts to its underlying signal *)
     let _ = Lwt_react.S.map (Lwt_io.printf "%i") my_sig in
     let rec update_loop () =
       let () = set (succ @@ Lwt_react.S.value my_sig) in
       let* () = Lwt_unix.sleep 0.5 in
       update_loop ();
     in
     update_loop ())

```

# Nested Modules and Name Collisions
This might be a code smell, but since convention is that the underlying type of a module is `t`, I find it difficult to define nested modules. The following is not legal:

``` ocaml title="Does not Compile" {13}
module type FOOTYPE = sig
  type t
end

module type BARTYPE = sig
  type t
end

module Foo : FOOTYPE = struct
  type t = int

  module Bar : BARTYPE = struct
    type t = t
  end
end
```

The compiler reports at line 13: `Error: The type abbreviation t is cyclic`. The fix is to rename the type:

``` ocaml title="Does Compile" {6}
module type FOOTYPE = sig
  type t
end

module type BARTYPE = sig
  type v
end

module Foo : FOOTYPE = struct
  type t = int

  module Bar : BARTYPE = struct
    type v = t
  end
end
```


[^1]: https://ocaml.org/manual/5.3/expr.html#sss:expr-records

[^2]: https://cs3110.github.io/textbook/chapters/mut/mutable_fields.html

[^3]: https://stackoverflow.com/a/3774467/28633986

[^4]: https://ocaml.org/manual/5.3/expr.html#ss:expr-operators

[^5]: https://ocaml.org/manual/5.3/modtypes.html#ss:mty-with

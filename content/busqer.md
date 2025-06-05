---
title: Busqer
date: 2025-05-14T10:59:44-0700
tags:
  - personal-project
---

[Busqer](https://github.com/jonathanmfung/busqer/): Simple Spotify client via DBus/MPRIS interface

# Developing Notes #
- Using `Lwt` (cooperative thread-based concurrency, stands for [lightweight threads](https://stackoverflow.com/a/11856452/28633986)), `GTK3` (Desktop GUI), and [`React`](https://erratique.ch/software/react/doc/React/index.html) (Functional Reactive Programming, `Lwt_react` is lwt-friendly bindings)
- Brief overview
    - Write/Read Spotify's media player info through DBus/MPRIS
        - e.g. Song Length, Track Title, Album Art Url, If current track changes
        - `OBus` library exposes DBus properties as ~React~ FRP signals.
    - Display this info in a simple GUI
        - Leverage FRP signals: Trigger GTK calls if underlying FRP property changes.
        - Extract colors from Album Art to color GUI
    - Lwt and GTK both require their own infinite main loop, combined via ~lwt_glib~ library.
        - [Also, React usually needs a manually created loop](https://stackoverflow.com/a/40695385/28633986)
- Be careful about mixing Lwt with normal blocking IO (src: https://discuss.ocaml.org/t/concurrent-tasks-in-lwt/14229/5)
``` ocaml
(* This immediately returns *)
let () = Lwt_main.run @@
  let open Lwt.Syntax in
  let p1 = (let* () = Lwt_unix.sleep 4. in print_endline "waited 4"; Lwt.return ()) in
  let p2 = (let* () = Lwt_unix.sleep 2. in print_endline "waited 2"; Lwt.return ()) in
  Lwt.return ();;
(* Changing last line to `Lwt.join [p1;p2];;` properly blocks *)
```
- MPRIS spec: https://specifications.freedesktop.org/mpris-spec/latest/Player_Interface.html
    - [DBus](https://dbus.freedesktop.org/doc/dbus-tutorial.html#members) is based on Methods, Signals, and Errors. Basically an OOP language.
- Testing with `OUnit2` and `QCheck2`
    - https://cs3110.github.io/textbook/chapters/data/ounit.html
    - `QCheck2` has integrated shrinking compared to version 1
    - Dune has features for testing, like [Diffing the Result](https://dune.readthedocs.io/en/stable/tests.html#diffing-the-result)
- `React` has considerations for [concurrent updates](https://erratique.ch/software/react/doc/React/index.html#update)
    - To concurrently update values `p1` and `p2`, their respective sets of "descendents" must be disjoint from each other
        - "descendents" are signals and events that are created from `p`
        - I believe this is because the `update` step of a value can only handle 1 input
- [GTK](https://docs.gtk.org/gtk3/property.Image.pixbuf.html) handles images through `GdkPixBufs`
    - PixBufs are raw representations, i.e. each pixel is three 8-bit values and a row is N pixels
    - [rowstride](https://docs.gtk.org/gdk-pixbuf/property.Pixbuf.rowstride.html) refers to the byte-width of a row, e.g. `N channels * row_pixel_width * byte_size`
- OCaml has `Bigarray`s that are generally used to interface with C & Fortran arrays
    - They don't have any ways to map, only `get/set`
- GTK does styling and theming with CSS
    - In 3.0, it uses `CSSProvider` and `StyleContext`
    - Usually a widget has CSS classes/ids added/removed to correspond to different UI states and Theme states
    - There is no easy way to change the specific color inside a CSS class at runtime
- `Lablgtk` are the bindings I use for GTK3
    - the [Rocq IDE](https://github.com/rocq-prover/rocq/blob/5caa5ce2187793c61c912a0049de872130c85260/dune-project#L139) also uses it (sourceview is for complex multi-line text such as a text editor)
    - However, it was some rough edges [Unison proposes to move away from lablgtk](https://github.com/bcpierce00/unison/issues/1075)
        - I have had issues with `GdkPixbuf.get_pixels` seg-faulting for no apparent reason, even before manipulating the pointer
- To use Lwt with blocking IO:
    - Wrap in `Lwt_preemptive.detach`, "It is mostly useful when making calls to a third-party library that does not provide Lwt-aware system primitives." https://raphael-proust.github.io/code/lwt-part-2.html
- I profiled using `perf` flamegraphs and the Firefox Profiler viewer
    - A lot of time was spent on `Bihist.make_freqs`, which was a naive immutable `IntMap` fold
    - I converted this to a mutable `Hashtbl` fold with a parallelized `Lwt` list iteration with some `Seq`
    - runtime was reduced from  ~15s to ~6.5s (`Hashtbl`) to ~40ms (`Hashtbl` & `Lwt`)
    - commit: 2f9fdfaadb8b12067224fd14f55cb93b3e6b84a5
    - `perf record --call-graph=dwarf -- ./_build/default/bin/main.exe` - standard perf.data file
    - `perf script -F +pid > test.perf` - convert to file that Firefox Profiler can read
        - https://perfwiki.github.io/main/tutorial/#firefox-profiler

# Random Notes #
- OCaml's effects are untyped, i.e. ["the compiler does not statically ensure that all the effects performed by the program are handled"](https://ocaml.org/manual/5.3/effects.html#s:effects-unhandled)
    - As of 250514: [Future of OCaml](http://ocamlverse.net/content/future_ocaml.html) states that Typed Algebraic Effects are a long-term plan
    - Blog post on effects: https://lewinb.net/posts/17_playing_with_ocaml_effects/
    - It seems that [EIO](https://github.com/ocaml-multicore/eio) is the de facto for effects-based IO
- OCaml has polymorphic variants
    - [Discuss OCaml: Is there any kind of guidline about when to use polymorphic variants?](https://discuss.ocaml.org/t/is-there-any-kind-of-guidline-about-when-to-use-polymorphic-variants/11006/12)
    - [Cornell CS3110 notes](https://courses.cs.cornell.edu/cs3110/2021sp/textbook/data/polymorphic_variants.html)
    - [SO: Variants or Polymorphic variants?](https://stackoverflow.com/questions/9367181/variants-or-polymorphic-variants)
    - [SO: Polymorphic Variants cannot use in-line recrods](https://stackoverflow.com/questions/61503391/inline-records-in-polymorphic-variants)
- OCaml has [`StdLabels`](https://ocaml.org/manual/5.3/api/StdLabels.html) which are versions of some modules where functions liberally use labeled arguments
- Jane Street has a library [Incremental](https://opensource.janestreet.com/incremental/)
    - They say it is [self-adjusting computations, i.e., computations that can be updated efficiently when their inputs change.](https://blog.janestreet.com/introducing-incremental/).
    - [FRP and SAC are subtely different](https://blog.janestreet.com/breaking-down-frp/)
    - [Umut A. Acar](https://www.umut-acar.org/self-adjusting-computation) is the researcher behind these ideas
- [Reddit: OCaml Features + First-class modules vs Functors](https://www.reddit.com/r/ocaml/comments/2g4248/when_to_use_certain_language_features_ex_first/)
- [Discuss Ocaml: How to organize functor-heavy code?](https://discuss.ocaml.org/t/functor-trouble-how-to-organize-functor-heavy-code/8913)
    - User ivg gives good comments like using existentials (simple GADTs) `type gps = Gps : 'gps service  -> gps`
    - Existentials are variables in GADT constructors that are in arguments but not the final return type

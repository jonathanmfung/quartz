---
title: Monads
date: 2025-07-06T15:42:53-0700
tags:
  - functional-programming
---

When I first learned about monads, the `>>=` (aka 'bind') and `return` functions made sense to me. The examples with the `Maybe` instance also seemed pretty clear to me-- `Nothing`s stay as such.

``` haskell
instance Monad Maybe where
  (Just x) >>= f = f x
  Nothing  >>= _ = Nothing

  return x = Just x
```

What always confused me were data types like `Parser`, `Reader`, and `State`:

``` haskell
newtype Parser a = Parser { runParser :: String -> ([a], String) }

newtype Reader r a = Reader { runReader :: r -> a }

newtype State s a = State { runState :: s -> (s, a) }
```

Part of my confusion is my dislike for Haskell's implicit arg in record accessors; `runState` is actually `runState :: State s a -> s -> (s, a){:haskell}`.

A second part of my confusion is the imprecise naming. The State monad holds more than just state, it is by definition a function from initial state `s` to a tuple of a new state `s` and a result value `a`.

A lot of verbage regarding monads concerns 'side effects' and 'computation(s)'. Again, side effects seem pretty straightforward; examples are printing to stdout, writing to a file, or executing a database transaction. (Note that these examples are in the IO monad). Computation, on the other hand, felt very abstract to me. I could not tell the difference between the expressions `1 + 2`, `foldl (+) 0`, and `do { val <- State.get; return (length val)}{:haskell}`.

It wasn't until I made the connection that `do-notation` desugars to a large expression of bind (and `>>`) operators, and that the result type is still a monad. Close to a program's entry-point the programmer usually wants some basic value like an `Int` or `String`. Being a monad, there is no default way to go from `m a -> a`. However, what usually is implemented are the `run` functions, which return a 'normal' type `a`.

It is this notion of extraction, especially through a lazy-evaluation lens, where the term 'computation' makes sense to me. A monad-returning function only adds transformation steps. When `run`, these transformations are completely applied to get back a usable value.

Coming back full-circle, for the `Maybe` example `runMaybe` can be thought of as pattern matching on `Just`. This runs into the issue that `runMaybe` would be partial and lead to some panic/error propagation, but this is usually desired given the semantics of `Nothing`.

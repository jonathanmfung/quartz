---
title: Zipper
date: 2025-05-20T12:56:33-0700
tags:
  - functional-programming
  - data-structures
---

A zipper is a data structure that is a "focused" representation of a classical, recursive data structure.

A zipper makes use of the "spatial" structure, e.g. in a linked list you can move forward or back. Once you move forward, you keep a memory of what is behind you (prior) and adjust what is further in front (posterior). To move backward, you "pop" part of the prior into the posterior.

``` haskell
data MyList a = Nil | Cons a (MyList a)

data Path a = Forward {back_ctx :: a}

-- Distinguish between build-in List and MyList, thread is just a history of Path
data ZipperList a = Zip {list :: MyList a, thread :: [Path a]}

mkZipperList :: MyList a -> ZipperList a
mkZipperList xs = Zip {thread = [], list = xs}

goBack, goForward :: ZipperList a -> ZipperList a

goBack z@Zip {list = ls, thread = []} = z
goBack Zip {list = ls, thread = Forward {back_ctx} : ts} = Zip {list = Cons back_ctx ls, thread = ts}

goForward z@Zip {list = Nil, thread = _} = z
goForward Zip {list = Cons l ls, thread = ts} = Zip {list = ls, thread = Forward {back_ctx = l} : ts}

canon :: ZipperList a -> ZipperList a
canon z@Zip {list = _, thread = []} = z
canon Zip {list = ls, thread = Forward {back_ctx} : ts} = canon $ Zip {list = Cons back_ctx ls, thread=ts}

unZip :: ZipperList a -> MyList a
unZip Zip {list = Cons l ls, thread = []} = Cons l ls
unZip Zip {list = Nil, thread = ts} = error "unreachable, can't go up."
unZip z = unZip $ canon z
```

For a classical data structure with `n` elements, there are `n` different zippers that can be constructed from it.

Notice that fragmenting `MyList` into a sequence of `Path`s is akin to the notion of a derivative in calculus. A recursive data type can be represented as an algebraic equation. `MyList a` corresponds to `MyList(A) = 1 + A * MyList(A)`. Now treat `MyList(A)` as `X` (`1 + A * X`), then the derivative with respect to x is `A`. This corresponds to the definition of `Path`.

# Link dump
- [Learn You a Haskell](https://learnyouahaskell.com/zippers)
- [Gérard Huet: Functional Pearl - The Zipper](https://www.st.cs.uni-saarland.de/edu/seminare/2005/advanced-fp/docs/huet-zipper.pdf)
- [StackOverflow](https://stackoverflow.com/questions/380438/what-is-the-zipper-data-structure-and-should-i-be-using-it)
- [Don Stewart: Zippers in XMonad](https://donsbot.com/2007/05/17/roll-your-own-window-manager-tracking-focus-with-a-zipper/)
- [Haskell Wiki](https://en.wikibooks.org/wiki/Haskell/Zippers)
- [Conor McBride: The Derivative of a Regular Type is its Type of One-Hole Contexts](http://strictlypositive.org/diff.pdf)

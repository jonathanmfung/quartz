---
title: Tail Recursion
date: 2025-02-18T12:26:29-0800
tags:
  -
---

Tail recursion is a specific form of recursion where the recursive step is the last step in a function.

(This is ignoring any actual language/compiler semantics, laziness or not[^1])

```haskell title="Recursive, but not tail recursive"
factorial :: Int -> Int
factorial n
  | n == 1 = 1
  | otherwise = n * factorial (n - 1)
```

This evaluates `factorial 5` as
```
factorial 5
5 * factorial 4
5 * 4 * factorial 3
5 * 4 * 3 * factorial 2
5 * 4 * 3 * 2 * factorial 1
5 * 4 * 3 * 2 * 1
5 * 4 * 3 * 2
5 * 4 * 6
5 * 24
120
```


```haskell title="Tail Recursive"
factorial :: Int -> Int
factorial n = go n 1
  where
    go 1 x = x
    go n x = go (n - 1) (n * x)
```

This evaluates `factorial 5` as
```
factorial 5
go 5   1
go 4   5
go 3  20
go 2  60
go 1 120
120
```

Basically, the part of the last step in the non-tail recursive version can be shoved into a running total inside of the top-level function.

[^1]: https://stackoverflow.com/a/13052612/28633986

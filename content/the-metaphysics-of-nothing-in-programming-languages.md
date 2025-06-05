---
title: The Metaphysics of Nothing - in Programming Languages
date: 2025-02-13T16:00:04-0800
tags:
  - programming-languages
wip: true
---
> The title is a riff of [@finnMetaphysicsNothing].

In the real world there are many reasons why a data point would be absent from a dataset:
- Not collected
- Not collected for reasons
- Not observed
- Thrown out for reasons
- Anonymized for reasons

If I have an some values associated with time, like

| Year | Data A |
|------|--------|
| 2000 | 123    |
| 2003 | 456    |
| 2004 | 789    |

I want to combine this with yearly data of another data set to do some analysis:
| Year | Data A | Data B |
|------|--------|--------|
| 2000 | 123    | ab     |
| 2001 |        | cd     |
| 2002 |        | ef     |
| 2003 | 456    | gh     |
| 2004 | 789    | ij     |

Is Data A missing years 2001 and 2002? Is it missing 1995? How about 1980 or 2008?

How is this missing-ness encoded in the data methodology, data sets, software, and programming languages?

# Languages and their Nothings #

| Language        | Syntax              | Implementation                                                              | Meaning                                                                |
|-----------------|---------------------|-----------------------------------------------------------------------------|------------------------------------------------------------------------|
| IEEE 754[^1]    | `NaN`               | Value(s) of a floating-point number.  Two kinds of NaN: quiet and signaling | Not a Number                                                           |
| Python          | `None{:python}`     | Object, Singleton of `NoneType{:python}`                                    | Absence of a value[^4]                                                 |
| Python          | `nan{:python}`      | Float value                                                                 | IEEE NaN                                                               |
| Python - Pandas | `<NA>`              | Nullable Integer                                                            | Proxy for IEEE NaN[^5]                                                 |
| Julia           | `NaN{:julia}`       | Float value                                                                 | IEEE NaN                                                               |
| Julia           | `missing{:julia}`   | Value, Singleton of `Missing{:julia}`                                       | Missing value in statistical sense[^6]                                 |
| R               | `NA{:r}`            | Value, Instances for multiple types                                         | Missing value in statistical sense[^7]                                 |
| SQL             | `NULL{:sql}`        | Marker for absent value                                                     | Absence of a value, Missing or Inapplicable information                |
| C/C++           | `NULL{:c}`          | Preprocessor macro (implementation-defined)                                 | Pointer that does not point to a valid object                          |
| C/C++           | `nullptr{:c}`       | Singleton of `nullptr_t{:c}`                                                | Pointer that does not point to a valid object                          |
| Haskell         | `Nothing{:haskell}` | Value of `Maybe a{:haskell}`                                                | Optional value, used for errors or exceptional cases.[^2]              |
| Rust            | `None{:rust}`       | Value of `Option<T>{:rust}`                                                 | Optional value, used for default values, errors, nullable pointers[^3] |

There's a saying that programming is just manipulating data. But does that really apply to the statistical and experimental interpretation of "data"?

Bonus: Default function arguments, and the caller does not supply anything

# IEEE 754 #
Section 6.2
> Quiet NaNs should, by means left to the implementer’s discretion, afford retrospective diagnostic information inherited from invalid or unavailable data and results. To facilitate propagation of diagnostic information contained in NaNs, as much of that information as possible should be preserved in NaN results of operations.

# ``IEEE 754 Error Handling and Programming Languages'' #
[@maclarenIEEE754Error2000]

[@maclarenIEEE754Error2000, sec. Percolation]:
> The definition “max(1.0, NaN ) = NaN ” is correct when a NaN is a missing value and what is wanted is the maximum non-missing value of a vector (as in one expression mode in many statistical packages) but is mathematically incorrect when it is an error state (as generally in IEEE 754)

Appendix A considers some potential interpretations of `NaN`:

> - A. A missing value (i.e. unknown but valid)
> - B. Not numeric at all (e.g. ‘purple’)
> - C. Inapplicable (i.e. not a datum)
> - D. Numerically indefinite (e.g. ≈ 0/ ≈ 0)
> - E. The result of an invalid operation

[^1]: Okay, not a language but still significant.

[^2]: https://www.haskell.org/onlinereport/haskell2010/haskellch21.html#x29-25500021

[^3]: https://doc.rust-lang.org/std/option/

[^4]: https://docs.python.org/3/library/constants.html#None

[^5]: https://pandas.pydata.org/docs/user_guide/integer_na.html

[^6]: https://docs.julialang.org/en/v1/manual/missing/

[^7]: https://cran.r-project.org/doc/manuals/r-release/R-lang.html#NA-handling

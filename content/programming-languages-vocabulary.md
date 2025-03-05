---
title: Programming Languages Vocabulary
date: 2025-03-04T13:09:03-0800
tags:
  - programming-languages
---

- An ***n*-tuple** is a collection of values, e.g. `(1, "a", x -> x + 2)`.
- A **record** is an n-tuple with named fields. Usually the order of fields is not significant in records.
- **Serializing** is encoding an object/value to another data format, such as JSON.
    - Inverse with Deserializing (decoding)
- **Marshalling** is a form of serializing that crosses the type system. Usually with regards to FFI.
- **Foreign Function Interface (FFI)** is calling another language/runtime system, and converting it to the current one.

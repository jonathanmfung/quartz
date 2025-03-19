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
- A **Type Variable** is an identifier that represents the notion of "any" type in a type declaration
    - These are used in polymorphic contexts
    - Multiple type variables in a function signature are allowed to resolve to the same type
- **Polymorphism** is the generalization of a language construct to multiple types. Formally, this means a term can have multiple types.

- **Ad-Hoc Polymorphism**
- **Parametric Polymorphism**
- **Row Polymorphism**
- **Subtype/Inclusion Polymorphism**

- **Linking**
- **Static Linking**
- **Dynamic Linking**
- **Compilation Unit**
- **Module**
- **Interface**

---
- **Immutable Data Structures (Persistence)**
- **Stack/Heap**
- **Garbage Collection**
- **Atomic**

- **Dependent Types**
- **Abstract Interpretation**

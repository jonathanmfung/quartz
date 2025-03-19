---
title: Tagged Pointer
date: 2025-03-08T17:31:58-0800
tags:
  - compilers
---
Tagged Pointers are a strategy to represent objects and values of a runtime system. They are applicable under the consideration that aligning memory addresses with CPU word size is desirable.

*Tagging* means reserving a couple bits (usually 1-2) for metadata. Metadata can be things like:
  - Is this a pointer?
  - Is this a primitive type (int, float)?
  - Is this a special object (true, null)?

Consequently, the effective number of bits is reduced. For example in a 32-bit system, a tagged pointer representation of an `int` would be limited to 31 bits.

---
title: Abstract Data Types vs Data Structures
date: 2025-03-11T17:59:49-0700
tags:
  - computer-science
  - data-structures
---

**Abstract Data Types** (ADT) are, well, abstract representations of data and their associated operations.

**Data Structures** (DS) are concrete implementations of ADTs, usually involving algorithms.

Roughly, an ADT is an interface that specifies behavior, and a DS is the implementation that realizes the behavior. The ADT/DS boundary is very arbitrary, there's many examples that may be one or the other depending on context: Binary Search Tree, B-Tree, Heap, Hash Table, Trie. Natural language may also introduce ambiguity such as referring to a Python `{k: v}{:python}` as a dictionary or hashmap.

| ADT            | (Potential) DS           |
|----------------|--------------------------|
| Integer        | 64-bit Two's Complement  |
| String         | Array                    |
| Set            | AVL Tree, Red-Black Tree |
| Dictionary/Map | Hash Table               |
| Stack          | Linked List              |

Sources:
- https://cs.lmu.edu/~ray/notes/dtds/
- https://softwareengineering.stackexchange.com/questions/148747/abstract-data-type-and-data-structure
- https://stackoverflow.com/questions/13965757/what-is-the-difference-between-an-abstract-data-typeadt-and-a-data-structure

---
title: Crafting Interpreters
date: 2025-06-05T11:15:18-0700
tags:
  - cs-education
---
https://craftinginterpreters.com/contents.html

# Welcome #
## 1. Introduction ##
No Notes
## 2. A Map of the Territory ##
- Lexing (aka Scanning): chunk a stream of characters into tokens
    - sometimes it's considered that lexers output raw strings and tokenizers output annotated strings (number literal, operator)
- Parser: convert sequence of tokens to a tree that represents the grammar of the language
    - The output is the Abstract Syntax Tree (AST)
- Static Analysis: Binding, Resolution, Scope, Symbol Table
- Intermediate Representations: Control flow graph, Static single-assignment, Continuation-passing style, three-address code
- Optimization: Constant propagation, common subexpression elimination, dead code elimination, loop unrolling
- Bytecode and Virtual Machine
- Runtime
    - A fully compiled language has the runtime-implementing code inserted into the executable
    - A VM or interpreter has the runtime embedded into it
- Pathways: Single-pass compilers, Tree-walk interpreters, Transpilers, Just-in-time compilation
- A compiler translates source code to a target, which the user then has to run.
- An interpreter executes from source code
## 3. The Lox Language ##
- C-style syntax
- Dynamic Typing
- Garbage Collection
- Expressions, Statements, Control flow
- Functions, Closures
- Classes, Inheritance

# A Tree-walk Interpreter #
## 4. Scanning ##
- AKA Lexing
- 1-lookahead (`peek`)
## 5. Representing Code ##
- Chomsky Hiearchy
- Terminals & Non-terminals
## 6. Parsing Expressions ##
- Ambiguity is resolved with precedence and associativity
- Stratification is splitting production rules by precedence
- Recursive Descent
- Error Recovery is when a parser encounters an error and keeps parsing to discover other possible errors
- Lox uses a panic mode error recovery
    - synchronization is aligning parser state and input string so that next match is valid
    - designate some synchronization rule in grammar (e.g. after a semicolon for the end of a statement)
	- usually done by moving state up until sync rule, then pop input until it matches rule
     - A normal AST is returned, but it doesn't actually get passed to later stages
## 7. Evaluating Expressions ##
- straightforward translation of calculation subset
## 8. Statements and State ##
- Statements (side effects)
    - expression statement: evaluate expressions that have side effects
    - print statement: evaluate expression and display result
- Defining variables
- Blocks and local scope
    - Lexical scope: source code text itself shows beginning and end of a scope
    - Lox methods and fields are dynamically scoped
    - Shadowing is important
        - implemented with Parent pointer tree
## 9. Control Flow ##
- If statements
- dangling else problem: (`if ... if ... else`)
    - usually resolved by binding `else` to nearest `if`
- `and`, `or` both short circuit
- While loops
- For loops
    - sugar for while loops
## 10. Functions ##
- function calls are expressions, like a postfix unary
- function declarations are statements
    - function name (identifier), list of params (identifier), block statement
- each function call gets new environment
- functions implicitly return nil, unless return statement is used
- Raise an exception to handle return unwinding
    - catch in LoxFunction

## 11. Resolving and Binding ##
## 12. Classes ##
## 13. Inheritance ##

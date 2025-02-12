---
date: 2025-02-04
title: Fuzzing vs Property Testing
tags:
  - bib
  - testing
---
[@kaminskiFuzzingVsProperty2018]

-   Both:
    -   Both involve random inputs.
-   Fuzzing:
    -   Fuzzing is looking for uncovering unintended behavior.
    -   Consequently runs any in-program `asserts`, checking invariants.
    -   Runs with no assumptions, so good for testing security.
    -   Runs for a long time (hours - months).
-   Property Testing:
    -   Property Testing is looking for confirming desired behavior.
    -   Existing property tests can be used to in/validate new assumptions one thinks of.
    -   To understand if the generated inputs span the desired space, we can add assertions for code we know will fail.
    -   Runs in similar time as other tests (unit/integration).

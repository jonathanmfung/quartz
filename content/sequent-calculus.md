---
title: Sequent Calculus
date: 2025-02-18T11:12:07-0800
tags:
  - formal-logic
---
The *notation* of the sequent calculus looks something like:
$$
\frac{A, B \vdash P \quad C \vdash Q}{D \vdash R, S}
$$

There is no inherent *interpretation* of this *notation*. The common inference rules to simulate formal logic say that the left side of a turnstile are conjunctive assumptions and the right side are disjunctive conclusions. Each side can be seen as a (possibly empty) list of metavariables.

The common inference rules are:
$$
\frac{\Gamma \vdash p, \Delta \quad \Gamma \vdash q, \Delta}{\Gamma \vdash p \land q, \Delta}{\land\text{-R}}
\quad
\frac{\Gamma, p \vdash \Delta}{\Gamma, p \land q \vdash \Delta}{\land\text{-L}_1}
\quad
\frac{\Gamma, q \vdash \Delta}{\Gamma, p \land q \vdash \Delta}{\land\text{-L}_2}
$$

$\Gamma$ and $\Delta$ represent zero or more adjacent propositions, while $p$ and $q$ are single propositions.

Resources:
  - @brewerParPart12025

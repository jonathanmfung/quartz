---
title: Sequent Calculus
date: 2025-02-18T11:12:07-0800
tags:
  - formal-logic
---

> [!note]Resources
> @brewerParPart12025


The *notation* of the Sequent Calculus looks something like:
```math
A, B \vdash P
```

There is no inherent *interpretation* of this *notation*. The common inference rules to simulate formal logic say that the left side of a turnstile are conjunctive **assumptions** and the right side are disjunctive **conclusions**. Each side can be seen as a (possibly empty) list of metavariables.

These turnstile-based terms can be composed into an inference rule:
```math
\begin{prooftree}
\AxiomC{$A,B\vdash P$} \AxiomC{$C\vdash Q$}
\BinaryInfC{$D\vdash R,S$}
\end{prooftree}
```

The top can be seen as the inputs and the bottom as outputs. The separating line is an *inference line*.

To develop a Proof System, we add some Axioms and structural inference rules:
```math
\begin{prooftree}
\AxiomC{$\Gamma_1,p,q,\Gamma_2\vdash\Delta$}
\RightLabel{Exch-L}
\UnaryInfC{$\Gamma_1,q,p,\Gamma_2\vdash\Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma\vdash\Delta$}
\RightLabel{Weak-L}
\UnaryInfC{$\Gamma,p\vdash\Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma,p,p\vdash\Delta$}
\RightLabel{Contr-L}
\UnaryInfC{$\Gamma,p\vdash\Delta$}
\end{prooftree}
```

```math
\begin{prooftree}
\AxiomC{$\Gamma\vdash\Delta_1,p,q,\Delta_2$}
\RightLabel{Exch-R}
\UnaryInfC{$\Gamma\vdash\Delta_1,q,p,\Delta_2$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma\vdash\Delta$}
\RightLabel{Weak-R}
\UnaryInfC{$\Gamma\vdash p,\Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma\vdash p,p,\Delta$}
\RightLabel{Contr-R}
\UnaryInfC{$\Gamma\vdash p,\Delta$}
\end{prooftree}
```
- Exch: Exchange, reordering lists
- Weak: Weakening, introduce more assumptions or conclusions
- Contr: Contraction, remove duplicate assumptions or conclusions

L(eft) refers to assumptions and R(ight) to conclusions.

$\Gamma$ and $\Delta$ represent zero or more adjacent propositions, while $p$ and $q$ are single propositions. These are all metavariables.

Now here are some inference rules for conjunction:
```math
\begin{prooftree}
\AxiomC{$\Gamma \vdash p, \Delta$}
\AxiomC{$\Gamma \vdash q, \Delta$}
\RightLabel{$\land$-R}
\BinaryInfC{$\Gamma \vdash p\land q, \Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma, p \vdash \Delta$}
\RightLabel{$\land$-L$_1$}
\UnaryInfC{$\Gamma, p\land q \vdash \Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma, q \vdash \Delta$}
\RightLabel{$\land$-L$_2$}
\UnaryInfC{$\Gamma, p\land q \vdash \Delta$}
\end{prooftree}
```

These inference rules can be composed into a derivation tree. A derivation tree starting with all Axioms, and following valid inference rules, is a proof of the bottom-most sequent.

``` math
\begin{prooftree}
\AxiomC{}
\RightLabel{Axiom}
\UnaryInfC{$P\vdash P$}
\RightLabel{Weak-L}
\UnaryInfC{$P, Q\vdash P$}

                         \AxiomC{}
                         \RightLabel{Axiom}
                         \UnaryInfC{$Q\vdash Q$}
                         \RightLabel{Weak-L}
                         \UnaryInfC{$Q, P\vdash Q$}
                         \RightLabel{Exch-L}
                         \UnaryInfC{$P, Q\vdash Q$}

           \RightLabel{$\land$-R}
           \BinaryInfC{$P, Q \vdash P \land Q$}
\end{prooftree}
```

## Sequent Natural Deduction &  Natural Deduction ##

We can make any structural rule implicit and arrive at Sequent Natural Deduction:
``` math
\begin{prooftree}
\AxiomC{}
\RightLabel{Axiom}
\UnaryInfC{$P\vdash P$}

                         \AxiomC{}
                         \RightLabel{Axiom}
                         \UnaryInfC{$Q\vdash Q$}

           \RightLabel{$\land$-R}
           \BinaryInfC{$P, Q \vdash P \land Q$}
\end{prooftree}
```

Note that there is only ever **1 conclusion** in a turnstile term. Leveraging this fact, we can simplify once again to arrive at Natural Deduction:

``` math
\begin{prooftree}
\AxiomC{}
\RightLabel{Axiom}
\UnaryInfC{$P$}

                         \AxiomC{}
                         \RightLabel{Axiom}
                         \UnaryInfC{$Q$}

           \RightLabel{$\land$-R}
           \BinaryInfC{$P \land Q$}
\end{prooftree}
```

The transformation from Sequent Natural Deduction to Natural Deduction merges the duplication between the assumptions and the inputs above its inference line.

Some of the previous rules in the Sequent Calculus no longer apply to either Natural Deduction, due to the 1-conclusion property. Instead, there are *introduction* and *elimination* rules:

```math
\begin{prooftree}
\AxiomC{$\Gamma \vdash p$}
\AxiomC{$\Gamma \vdash q$}
\RightLabel{$\land$-Intro-R}
\BinaryInfC{$\Gamma \vdash p\land q$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma \vdash p \land q$}
\RightLabel{$\land$-Elim-R$_1$}
\UnaryInfC{$\Gamma \vdash p$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma \vdash p \land q$}
\RightLabel{$\land$-Elim-R$_2$}
\UnaryInfC{$\Gamma \vdash q$}
\end{prooftree}
```
```math
\begin{prooftree}
\AxiomC{$\Gamma,p\vdash\Delta$}
\RightLabel{$\land$-Intro-L$_1$}
\UnaryInfC{$\Gamma,p\land q\vdash\Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma,q\vdash\Delta$}
\RightLabel{$\land$-Intro-L$_2$}
\UnaryInfC{$\Gamma,p\land q\vdash\Delta$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\Gamma,p\land q\vdash\Delta$}
\RightLabel{$\land$-Elim-L}
\UnaryInfC{$\Gamma,p,q\vdash\Delta$}
\end{prooftree}
```

## One-Sided Sequent Calculus ##

Another approach is a One-sided Sequent Calculus, where terms only appear on the right side of the turnstile. Starting from scratch, we try to recreate classical logic:

``` math
\begin{prooftree}
\AxiomC{}
\RL{$\lnot$-Intro}
\UnaryInfC{$\vdash p, \lnot p$}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\vdash p, \Delta$}
\AxiomC{$\vdash \lnot p, \Delta$}
\RL{$\lnot$-Elim or "Cut"}
\BinaryInfC{$\vdash \Delta$}
\end{prooftree}
```
``` math
\begin{prooftree}
\AxiomC{$\vdash p, \Delta$}
\AxiomC{$\vdash q, \Delta$}
\RL{$\land$-Intro}
\BinaryInfC{$\vdash p \land q, \Delta $}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\vdash p \land q, \Delta$}
\RL{$\land$-Elim$_1$}
\UnaryInfC{$\vdash p, \Delta $}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\vdash p \land q, \Delta$}
\RL{$\land$-Elim$_2$}
\UnaryInfC{$\vdash q, \Delta $}
\end{prooftree}
```
``` math
\begin{prooftree}
\AxiomC{$\vdash \lnot p, \Delta$}
\UnaryInfC{$\vdash \lnot(p \land q), \Delta $}
\end{prooftree}
  \qquad
\begin{prooftree}
\AxiomC{$\vdash \lnot q, \Delta$}
\UnaryInfC{$\vdash \lnot(p \land q), \Delta $}
\end{prooftree}
```
Note that the $\lnot$-Intro axiom is the Law of Excluded Middle.

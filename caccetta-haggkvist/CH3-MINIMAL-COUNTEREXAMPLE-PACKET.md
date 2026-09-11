# Caccetta–Häggkvist, Triangle Case — Minimal-Counterexample Packet

**Author:** Jared Wilder  
**Public release:** 2026-09-10

## Status first

The triangle case of the Caccetta–Häggkvist conjecture remains open in current public literature. This packet does **not** claim a proof.

The theorem estate contains **18 records** in the `caccetta-haggkvist-ch3` domain. Seventeen are explicitly marked `SUPPORTED_CONDITIONAL`: they are structural consequences **assuming a counterexample exists and after the source packet's minimal-counterexample reductions**. One is a meta-result saying a particular simplified analytic architecture would require an unrealistically strong coefficient for closure.

Current public references still identify `1/3` as the conjectured threshold and `0.3465` as the best published unrestricted forcing constant. Recent independent computational work has closed additional finite orders but also explicitly states that the conjecture remains open.

# Setup

Assume, for contradiction-program purposes, a smallest counterexample `D` to the directed-triangle case:

- `D` has `n` vertices;
- every vertex has outdegree at least
  \[
  \left\lceil\frac n3\right\rceil;
  \]
- `D` contains no directed triangle;
- among minimum-order counterexamples, choose one with minimum number of arcs.

Write

\[
d=\left\lceil\frac n3\right\rceil.
\]

All statements below are conditional on that setup unless stated otherwise.

# I. Minimality and regularization

## Minimal-counterexample hereditary deficit

Every proper nonempty vertex set `S` contains a vertex `x` with

\[
d_S^+(x)<\frac{|S|}{3}.
\]

Equivalently, every proper induced subgraph has minimum outdegree below one third of its order.

This is the basic hereditary use of vertex-minimality.

## Elimination ordering

Every proper vertex set `S` admits an ordering obtained by repeatedly removing a vertex whose residual outdegree is below one third of the current residual order.

This is a peeling reformulation of the hereditary deficit theorem.

## Arc-minimal regularization

After minimizing the arc count among smallest counterexamples, every vertex has outdegree exactly

\[
\boxed{d=\left\lceil\frac n3\right\rceil.}
\]

The source packet calls this the arc-minimal regular kernel.

## Universal minimum-tail theorem

Every vertex has an incoming tail whose outdegree is minimum. In the arc-minimal kernel this is automatic because every vertex has outdegree `d`.

# II. Escape inequalities

The hereditary deficit immediately produces quantitative escape from every proper set.

## Minimal Escape Lemma

For every proper nonempty `S`, some `x in S` satisfies

\[
d^+_{V\setminus S}(x)>d-\frac{|S|}{3}.
\]

## Exact Escape Theorem

With integer rounding made explicit, for every proper nonempty `S` there is `x in S` with

\[
\boxed{d^+_{V\setminus S}(x)\ge d-\left\lceil\frac{|S|}{3}\right\rceil+1.}
\]

This is the packet's basic expansion inequality.

## Two-thirds escape vertex

For the selected neighborhood cell `A` in the source decomposition, some `x in A` has

\[
|N_M^+(x)|
\ge d-\left\lceil\frac d3\right\rceil+1
>\frac{2d}{3}.
\]

This is a local consequence of exact escape, not a global contradiction.

## Second-escape compression

Applying hereditary deficit to the source cell `X` produces `z in X` with a large external outneighbor set

\[
W=N^+(z)\setminus X,
\]

and the construction guarantees

\[
W\cap N^-(x)=\varnothing
\]

for the corresponding selected vertex `x`.

# III. Indegree ceilings from escape

The source packet converts large forward target sets into indegree restrictions.

## Pair-cell indegree ceiling

For the selected `x` and source set `X`,

\[
\boxed{d^-(x)\le n-d-|X|+\left\lceil\frac{|X|}{3}\right\rceil-2.}
\]

## Bridge deficit theorem

For a bridge set of size `s`,

\[
\boxed{d^-(x)\le n-d-s+\left\lceil\frac s3\right\rceil-2.}
\]

## Double-wall escape theorem

If two vertices `a,b` share a large common forward target set `C`, then

\[
|N^-(a)\cup N^-(b)|
\le
2d-|C|+\left\lceil\frac{|C|}{3}\right\rceil-1.
\]

This is a two-vertex compression of the same escape principle.

# IV. Global necessary structure

## Strong connectivity

A smallest counterexample is strongly connected.

Any source or sink strong component would inherit enough minimum outdegree relative to its order to contradict minimality.

## Forbidden residue theorem

A vertex-minimal counterexample cannot have

\[
\boxed{n\equiv1\pmod3.}
\]

This is a necessary arithmetic restriction on the order of a hypothetical minimal counterexample.

## Aperiodicity theorem

After the source packet eliminates periods 2 and 3, the regular minimal kernel is primitive / aperiodic.

In adjacency-matrix language, this is the condition needed to exclude peripheral eigenvalues coming from a nontrivial directed period.

## Strict spectral-radius gap

In the resulting primitive `d`-out-regular kernel, every non-Perron eigenvalue `lambda` satisfies

\[
\boxed{|\lambda|<d.}
\]

This is a conditional Perron–Frobenius consequence of the structural reductions, not a standalone proof of Caccetta–Häggkvist.

# V. Backward hierarchy

The hereditary-deficit theorem also supplies a peeling order on backward cells. Dense internal arcs may still point backward across that order; therefore the hierarchy is an organizational constraint, not an acyclicity theorem.

The source campaign explicitly retained this distinction to prevent a false “peeling implies DAG” shortcut.

# VI. Why the attempted analytic close did not close

The 18th record is a meta-result:

> Within the campaign's simplified pointwise fan-capacity / energy architecture, the coefficient required to force the final contradiction would have to be unrealistically large.

This was recorded as `CONDITIONAL_META`, not as a theorem about all possible approaches.

Its purpose is negative knowledge: **the particular pointwise coefficient route was too weak**, even after the minimal-counterexample structure above was imposed.

# VII. Exact claim boundary

What this packet gives:

- a vertex-minimal hereditary deficit principle;
- exact escape inequalities;
- arc-minimal out-regularization;
- strong connectivity;
- a forbidden order residue;
- indegree ceilings and double-wall inequalities;
- aperiodicity / Perron spectral consequences under the full source setup.

What it does **not** give:

- a contradiction to the existence of a minimal counterexample;
- a proof of the `1/3` threshold;
- an improvement to the published unrestricted `0.3465` forcing constant;
- a claim that these minimal-counterexample lemmas are historically new.

## Current-literature check

A 2026 doctoral manuscript still describes the `n/3` triangle case as open and gives `0.3465` as the best published unrestricted bound. Independent August 2026 computational notes likewise state that the conjecture remains open while certifying additional finite orders. This packet is therefore intentionally released as a **conditional structural reduction package**, not a closure.

# Fiber-Coherence Program — Negative-Theorem Supplement

**Public release:** 2026-09-10

This file repairs an omission in the first recovered identity indexes: several source rounds emitted negative-theorem cards separately from their positive theorem packets. They are part of the mathematics and remain public.

## Relational self-growth

### Adjacency Pair-Homogeneity Impossibility
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Let `κ` be infinite and let `G` be K4-free with `tc(G)>κ`. For the binary pair map
\[
a(\{x,y\})=\mathbf1_{xy\in E(G)},
\]
there is no `U⊆V(G)` with `tc(G[U])>κ` on which `a` is constant on all pairs.

### Exact Unary–Pair Arity Boundary
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Families of at most `κ` unary `κ`-valued vertex maps can be simultaneously homogenized on an induced positive subgraph, while complete homogeneity already fails for the single binary adjacency relation.

### Quotient-Only Sterility Theorem
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Quotient isomorphism type alone gives no nontrivial universal lower bound on triangle-cover number: every quotient graph `Q`, even one of arbitrarily large chromatic number, admits a partitioned realization whose ambient graph has triangle-cover number at most one.

### Relational Migration Theorem
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

In a null-cell partition of a positive graph, arbitrarily high-chromatic finite quotient patterns can be supported on induced-null vertex unions. Thus finite quotient patterns without their edge-fiber realization do not carry the high-cover obstruction.

## High-gear self-growth

### Unary-Profile Sterility Boundary
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

No family of at most `κ` unary invariants, each with at most `κ` values, can partition a graph with `tc(G)>κ` entirely into induced `κ`-null profile classes: one common profile class remains positive.

## Coherence-CSP

### Berge-Acyclic Coherence Frustration
**Status:** `UNCONDITIONAL_COUNTEREXAMPLE`.

A finite K4-free stable-partition graph can have a realized-type incidence graph that is a tree while the full type system has no coherent section.

### No Bounded Local Coherence Test
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

For every finite `m`, there is a finite K4-free Berge-acyclic fiber system in which every subsystem of at most `m` constraints coheres while the full system does not.

## Base fiber-coherence program

### Coherence-Only Information Deficit
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Neither an ordinary stable-partition quotient nor a family of finite endpoint-realizable Berge-C3-free triangle hypergraphs, considered without the missing fiber/gluing information, can by itself certify high triangle-cover number.

## Permutation gluing

### No Helly Bound for Pure Monodromy Coherence
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

There is no finite Helly number for finite K4-free fiber-coherence systems even after restricting to bouquets of permutation cycles with all values locally support-consistent.

## Theta collision / cycle rank two

### No Helly Bound in the 2-Connected Pure-Permutation Regime
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

No finite local-subsystem bound decides coherence even for finite K4-free systems whose tree-absorbed incidence core is 2-connected and every constraint relation is a bijection.

### One-Step Repair Matrix Collapses to the Deletion Spectrum
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

For an inclusion-minimal incoherent CSP with constraints `C_i`, the number of assignments satisfying `C_j` and every constraint except `C_i` (`i≠j`) equals the solution count after deleting `C_i`. The full one-step repair matrix therefore adds no information beyond the deletion-solution spectrum.

### Unit-Slack Theorem for Minimal Incoherent Cores
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

For every constraint of an inclusion-minimal incoherent finite CSP, the one-constraint extension slack relative to the remaining system is exactly one; deleting any other old constraint is already a valid one-constraint repair. Scalar one-step repair statistics therefore collapse on all such minimal cores.

## Unicycle core

### Arc Consistency Is Insufficient in K4-Free Fiber Systems
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Local support/arc consistency does not decide finite K4-free fiber coherence, even for binary domains and a unicyclic incidence graph.

### Bounded Feedback Does Not Give a Helly Bound
**Status:** `UNCONDITIONAL_NEGATIVE_THEOREM`.

Bounded incidence feedback number does not imply a bounded local coherence test; failure already occurs in the acyclic case.

## Rank-three kernel

### Second-Order Repair Is the First Noncollapsed Geometric Invariant
**Status:** `UNCONDITIONAL_NEGATIVE_AND_POSITIVE`.

Scalar extension slack and the one-step repair matrix collapse universally on inclusion-minimal incoherent cores, while the pair-deletion profile need not: in the intrinsic rank-three K4 core it distinguishes adjacent from disjoint constraint pairs and reconstructs constraint geometry.

## Source-authority boundary

These statements are recovered from the theorem-card/packet sources for the corresponding August 2026 self-growth rounds. Many source rows carry Lean/proof/falsifier flags; this supplement preserves the statements and source statuses but does not claim a fresh independent replay of every source artifact on 2026-09-10.

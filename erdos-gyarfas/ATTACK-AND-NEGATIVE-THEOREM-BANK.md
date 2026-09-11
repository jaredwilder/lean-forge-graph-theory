# Erdős–Gyárfás Power-of-Two Cycle Program

**Author:** Jared Wilder  
**Public release:** 2026-09-10

## Problem

Does every finite simple graph of minimum degree at least three contain a cycle whose length is a power of two?

This archive does **not** claim to settle the conjecture. It publishes the exact structural program, finite packet certificates, falsified routes, and remaining theorem targets developed in the August 2026 theorem forge.

The recovered inventory contains **202 distinct records**:

- 16 `FINITE_CERTIFICATE`;
- 20 `NEGATIVE_BANK`;
- 123 `COURT_CANDIDATE`;
- 25 `SEARCH_ONLY`;
- 9 `SEARCH_TARGET`;
- 5 `CONDITIONAL`;
- 2 `SEARCH_WITH_PROVED_CONSEQUENCE`;
- 2 `COURT_SOURCE`.

That distribution is the right headline: this is a research attack surface, not a fake closure.

# I. Exact finite packet certificates

The fixed `(4,1)⊕(4,7)` packet generated the following exact finite results.

1. **Explicit minimal three-edge obstruction.** Edges `x0-w1`, `v1-u3`, and `v3-u1` are each individually C4/C8-safe, but together create the C8
   `x0-w1-x2-v3-u1-u2-u3-v1-x0`.
2. **Exact N=0 candidate set.** The fixed 15-vertex packet has exactly 13 individually C4/C8-safe missing edges.
3. **Exact N=0 forbidden-hypergraph census.** There are exactly 56 minimal forbidden hyperedges: 48 of rank two and 8 of rank three, none larger.
4. **Five unit-forced N=0 edges.** Deficit vertices `v1,v3,w2,u5,u6` each have exactly one incident individually safe candidate edge.
5. **N=0 packet UNSAT.** No simple graph on the 15 packet vertices contains the packet, has minimum degree at least three, and avoids C4 and C8.
6. **Complete N=1 hub census.** Exactly 21 complete one-hub base configurations are C4/C8-free and give the hub degree at least three.
7. **Complete N=2 hub census.** Exactly 24 complete two-hub base configurations survive: 16 with nonadjacent hubs and 8 with adjacent hubs.
8. **N=2 adjacency split.** The `16+8` decomposition above is exact.
9. **N=1 candidate isolation.** Every one of the 21 N=1 configurations leaves an uncovered deficit vertex with no incident individually safe completion edge.
10. **N=2 candidate isolation.** The same isolation phenomenon holds for all 24 N=2 configurations.
11. **Bounded packet realization lower bound.** Any C4/C8-free minimum-degree-three completion of the fixed packet requires at least three added vertices.
12. **Deficit conflict graph.** The common-hub conflict graph on the 12 deficit vertices has exactly 40 edges.
13. **Exact hub capacity.** That conflict graph has independence number four and a unique maximum independent set `{v1,v2,u1,u2}`.
14. **Exact two-hub coverage.** Two independent hub neighborhoods with overlap at most one cover at most seven deficit vertices; the maximizing pair is uniquely `{v1,v2,u1,u2}` and `{w3,u4,u5}`, up to order.
15. **Distance-three exclusion count.** Exactly 26 nonedges have packet distance three; adding any of them directly creates a C4.
16. **Canonical witness object.** The serialized N=1/N=2 isolation object has SHA-256
   `fe2adefe67664121baaf3b8b4a6cf7cafaa5a62ebcc7c8fb2a69ca41aa2ac179`.

These are finite statements about one packet family. They do not extrapolate to all counterexamples without a transfer theorem.

# II. Negative theorem bank

The campaign's most reusable output may be the set of routes it **proved cannot work as stated**.

1. **Single-ear dyadic forcing is false.** A shortest cycle plus one ear need not generate a power-of-two cycle.
2. **Bare expansion is not a finite contradiction.** Exponential local branching around a shortest cycle does not by itself contradict finiteness.
3. **One connector packet is insufficient.** The double barriers and one three-cycle connector packet do not force a dyadic cycle.
4. **Power-of-two difference forcing is false.** Arbitrarily large integer attachment sets may avoid all power-of-two pairwise differences.
5. **Exponent repetition alone is insufficient.** Repeating one near-dyadic exponent at many cubic vertices does not itself create a dyadic cycle.
6. **Lens arithmetic alone is insufficient.** Perimeter/parity/zero-sum/mixed-route arithmetic does not eliminate every lens packet.
7. **Radius-one completion is incomplete.** Chords, cross-edges and shared immediate outside neighbors do not exhaust minimum-degree completions.
8. **Individual safety is only necessary.** Completion edges can each be individually safe yet jointly create a power-of-two cycle.
9. **The pairwise conflict graph is incomplete.** Higher-order forbidden interactions genuinely occur.
10. **Attachment-hypergraph non-universality.** The high-degree attachment hypergraph cannot serve as a universal primary representation of a minimum counterexample.
11. **Width-two three-terminal forcing is false.** Two-degeneracy plus three degree-two terminals does not force a connector of length `2^k-2`.
12. **Two-forest word doubling is false.** A decomposition into two forests alone does not force a dyadic cycle or binary-doubling law.
13. **Sparse rigidity alone is insufficient.** `m<=2n-2` and `e(S)<=2|S|-3` do not determine dyadic cycle lengths.
14. **Edge-spectrum primacy is sterile without selection.** A return-spectrum reformulation is not a compression until a theorem selects an edge with a sufficiently rich spectrum.
15. **Integer splicing cannot break an odd lock.** If all switching-circuit lengths are divisible by an odd prime `p`, integer sums/differences remain divisible by `p`; pure arithmetic splicing cannot manufacture a power of two.
16. **Power-of-two gcd does not imply a dyadic member.** A positive-integer set can have gcd a power of two while containing no power of two.
17. **Transition-cocycle equivalence withdrawn.** The proposed equivalence between odd lock and a nontrivial transition cocycle was not established.
18. **Two-arc ear compatibility is impossible.** In the stated 2+2 transition system, at most one boundary arc is compatible with a given external switching ear.
19. **Local minimum does not imply path independence.** A local minimum in the pairing-exchange graph does not imply commuting squares / zero curvature / path-independent objective changes.
20. **Canonical-ear continuity withdrawn.** Shortest external returns from neighboring boundary ports need not vary continuously in endpoint or total cycle length.

A future proof program should not spend compute rediscovering these dead ends without an explicitly stronger hypothesis.

# III. Structural candidates retained for proof

The theorem forge produced a large candidate layer. The following are representative load-bearing statements that remained live, not certified.

## Ear geometry

- A cycle of length `r` plus an ear of length `p` between vertices cutting the cycle into arcs `a` and `r-a` creates cycles of lengths `p+a` and `p+r-a`.
- For a shortest base cycle and a shortest ear, the proposed barrier is `p>=max(a,r-a)>=ceil(r/2)`.
- Shortest ears should be induced; sufficiently long shortest-ear interiors should avoid extra contacts with the base cycle.
- Exterior connectors are constrained simultaneously by ear replacement and local-cycle barriers, producing the proposed double-barrier `h>=max(d,r-d)`.

## Cubic suppression

- In a C4-free graph, the neighborhood of a cubic vertex has maximum degree at most one.
- Hence some neighbor of a cubic vertex is nonadjacent to the other two, enabling a `Y→V` suppression.
- The program tracks exactly how cycles in the suppressed graph lift depending on whether they use zero, one, or two artificial edges.
- The central candidate consequence is that every cubic vertex in a minimum counterexample carries a near-dyadic `2^k+1` cycle / a Mersenne-length path between two neighbors.

## Lens / mixed-route algebra

For two equal-length paths with ordered common vertices, the symmetric difference decomposes into lenses with arm lengths `(r_i,s_i)` and total imbalance

\[
\sum_i(r_i-s_i)=0.
\]

Choosing either arm in each lens gives a cube of route lengths. The campaign's intended close is to turn this route cube into a forced dyadic length after all legal simplifications. Several naive subset-sum variants were killed; the surviving closure target is stronger and genuinely structural.

# IV. Conditional exact consequences

Five results were retained only under named structural hypotheses. Examples include:

- low-degree attachment consequences assuming every proper subgraph of a minimum counterexample is 2-degenerate;
- a singleton-attachment multiplicity bound;
- cubicity of the root neighbor in the singleton-component case;
- a rooted degeneracy-wave elimination order;
- a two-lens cancellation schema under series realizability and equal total route length.

Two additional algebraic consequences were proved inside their stated transition-system assumptions:

- if `1_M(uv)=α(u)+α(v)` over an odd prime field, the potential alternates sign around each component of the 2-factor `G-M`;
- every vertex on an odd cycle component then has `α=0`, preventing an `M` edge from joining two odd components under those hypotheses.

# V. Explicit remaining closure targets

The packet names nine specific theorem targets rather than the vague instruction “solve the conjecture”:

1. complete ordinary-ear closure;
2. suppression-spectrum intersection;
3. cubic-suppression branch close;
4. hostile imbalance compression;
5. secondary-ear lens collapse;
6. crossed-to-ordered reduction;
7. same-scale near-dyadic overlap;
8. equal-exponent local close;
9. human candidate-isolation classification of the 45 finite N=1/N=2 configurations.

It also records 25 longer-horizon search-only targets ranging from perfect-matching odd-lock destruction and transition-system descent to defect-core classification and the final flagship closure program.

# VI. Current-status boundary

This repository makes **no claim that the Erdős–Gyárfás conjecture was solved by this campaign**.

The external literature and public computational frontier continued moving after the August forge; in September 2026 there are new SAT-certified lower-bound results and independent working-paper claims. Those developments must be adjudicated separately before anyone changes the global problem status.

The role of this release is narrower and durable:

> preserve the exact finite certificates, preserve the structural lemmas worth formalizing, and permanently bank the false routes so later work begins above them.

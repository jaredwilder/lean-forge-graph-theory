# Fiber-Coherence CSPs in K4-Free Graphs

**Author:** Jared Wilder  
**Public release:** 2026-09-10

This is the pure-mathematics extraction of the fiber-coherence program developed while attacking Erdős #595.

The central idea is to replace a lossy quotient of triangle structure by a finite constraint system that retains which concrete graph-edge fibers can realize which triangle types. Once this is done, obstruction mechanisms can be organized by the topology of the incidence graph: trees, unicycles, cacti, theta blocks, and higher cycle rank.

## Authority warning

The underlying corpus contains executable finite checks, theorem cards, Lean-associated artifacts, proof sketches and dependency graphs. Its internal labels such as `UNCONDITIONAL_CLASSIFICATION` are **not independent peer review**. Lower-rank statements below are released as the clean mathematical core of the program; the rank-three / NP-completeness layer is separated as a higher-risk candidate layer requiring independent proof and specialist novelty review.

No claim here closes Erdős #595.

---

# I. Graph-realized fiber systems

## Endpoint-scheme characterization

A 3-uniform hypergraph `H` is isomorphic to the triangle hypergraph `T(G)` of some simple graph `G` exactly when its hypergraph vertices can be represented as unordered pairs of endpoint classes satisfying the obvious nondegeneracy, uniqueness and triangle-completeness conditions.

One exact formulation from the estate uses an equivalence relation on

\[
V(H)\times\{0,1\}
\]

such that:

1. the two endpoints of each hypergraph vertex are inequivalent;
2. two distinct hypergraph vertices never determine the same unordered pair of endpoint classes;
3. each hyperedge determines exactly the three edges of a triangle;
4. every triple whose endpoint pairs form a triangle is a hyperedge.

This is the structural gateway from abstract triangle-type systems back to ordinary graphs.

---

# II. Tree and star coherence

## Star support-intersection theorem

For a star-shaped realized-type system with one shared fiber, global coherence is equivalent to nonempty intersection of the support subsets induced on that shared fiber.

This turns star coherence into ordinary set intersection.

## K4-free star universality

Arbitrary finite set systems can be realized as such support profiles inside a K4-free graph-realized fiber system.

Consequences include explicit K4-free examples where local support information is arbitrarily misleading.

## Arbitrarily large minimal acyclic frustration

For every integer `m`, there is a finite K4-free star-shaped fiber system whose full constraint family is incoherent while every proper subsystem — in particular every subsystem of size at most `m` after choosing the construction appropriately — is coherent.

Thus:

\[
\boxed{\text{there is no finite local-subsystem Helly bound for coherence in this class}.}
\]

## Infinite-fiber compactness failure

There is a countable star-shaped K4-free fiber system for which every finite constraint subsystem has a coherent section while the full countable system has none.

## Finite-fiber compactness boundary

Conversely, when every fiber domain is finite, standard compactness gives the positive boundary:

> If every finite constraint subsystem is coherent, the entire possibly infinite system is coherent.

The finite/infinite domain distinction is therefore load-bearing.

## Exact message passing on incidence trees

For an acyclic finite fiber CSP, define variable-to-constraint and constraint-to-variable messages by exact support propagation. After inward propagation to a root variable, the CSP is coherent iff the root retains at least one value.

This gives a polynomial-time decision and reconstruction algorithm in the explicitly listed domain/relation sizes.

---

# III. One cycle: exact monodromy obstruction

After tree branches are absorbed, a connected unicyclic incidence system reduces to a binary relational cycle

\[
t_0,t_1,\ldots,t_{m-1}
\]

with relations

\[
R_i\subseteq D_i\times D_{i+1}
\]

(indices modulo `m`).

## Fixed-point criterion

The original CSP is coherent iff the composed relation

\[
R_0\circ R_1\circ\cdots\circ R_{m-1}\subseteq D_0\times D_0
\]

contains a fixed point `(x,x)`.

## Complete rank-one obstruction classification

Every finite incoherent unicyclic fiber system has one of exactly two certificate types:

1. **support-pruning failure** — tree absorption empties a domain or projected relation;
2. **cycle fixed-point failure** — all local supports survive, but the full cycle composition has no fixed point.

There is no third obstruction mechanism at incidence cycle rank one under the stated model.

---

# IV. Cactus incidence graphs

## Cactus block-message theorem

When the incidence graph is a cactus, exact coherence is decided by message passing on the block-cut tree:

- tree blocks use ordinary incidence-tree support propagation;
- cycle blocks are tree-absorbed and summarized by exact boundary extension sets obtained from relation composition;
- articulation variables intersect the messages from incident blocks.

The CSP is coherent iff the root retains a value.

## Cactus obstruction classification

Every incoherent cactus system therefore has an exact certificate generated by those block messages: either some tree/unicyclic block emits an empty message, or individually nonempty child messages have empty intersection at an articulation variable.

No additional obstruction mechanism is needed inside the cactus class.

---

# V. Cycle rank two: theta collisions

A finite simple 2-connected graph with cyclomatic number two is a theta graph: two degree-three vertices joined by three internally vertex-disjoint paths, with all other vertices degree two.

After tree absorption, let the three endpoint transfer relations be

\[
R_1,R_2,R_3.
\]

## Complete theta obstruction classification

The system falls into exactly one of four branches:

1. some `R_i` is empty;
2. some pair intersection `R_i ∩ R_j` is empty, exposing an incoherent unicyclic subsystem;
3. all pair intersections are nonempty but
   \[
   R_1\cap R_2\cap R_3=\varnothing,
   \]
   giving an intrinsic theta collision;
4. the triple intersection is nonempty and the block is coherent.

This isolates a genuinely rank-two obstruction that cannot be seen in any individual cycle.

## Minimal intrinsic permutation collision

Three permutations can agree pairwise somewhere while having no common agreement point only once the fiber domain has size at least four; domain four is sufficient in the archived construction.

That yields a K4-free, support-consistent, 2-connected rank-two fiber system for which each constituent cycle coheres while the whole theta system does not.

## No finite Helly bound even in the pure-permutation regime

The program constructs arbitrarily high-rank minimal incoherent permutation multi-theta systems in which every proper path subfamily is coherent. Therefore no fixed finite local-subsystem bound decides coherence even in a rigid 2-connected, bijective-transfer regime.

---

# VI. Higher-risk frontier: rank three and complexity

The estate contains three especially strong claims that are **released as candidates pending independent proof audit**, not as externally certified theorems.

## Candidate R3K05 — universal K4-free realization of finite binary CSPs

Claim: every finite binary CSP admits a polynomial-size realization as the exact boundary projection of a finite K4-free fiber-coherence system.

If correct, this is the bridge required for the next two complexity results.

## Candidate R3K06 — NP-completeness

Claim: deciding coherence of finite K4-free graph-realized fiber systems is NP-complete, with NP-hardness already at branch-domain size three.

This depends on the exactness of the realization theorem above and should not be cited independently until that reduction is checked end-to-end.

## Candidate R3K11 / R3K21 — rank-three kernels and the parameterized split

The internal program claims a four-mechanism structural classification at cycle rank three and an algorithmic regime

\[
O(d^r\operatorname{poly}(N))
\]

for fixed cycle rank `r` and domain bound `d`, contrasted with NP-completeness when cycle rank is unbounded.

The fixed-rank tractability direction is consistent with standard bounded-cycle-rank / CSP dynamic-programming intuition; historical novelty therefore depends on the exact graph-realized restriction and kernel classification, not the mere existence of an FPT-style algorithm.

---

# VII. Relationship to Erdős #595

The theory originated as a compression audit for Erdős #595. It shows why several coarse quotient strategies lose decisive information and gives exact finite-fiber obstruction machinery.

It does **not** prove or refute the existence of the K4-free uncountable graph demanded by #595.

The strongest safe interpretation is:

> Low-cycle-rank graph-realized triangle-fiber systems admit exact topology-indexed obstruction theories; finite domains have a compactness boundary, while infinite fibers can hide genuinely infinitary frustration.

That is useful mathematics whether or not it ultimately closes the parent Erdős problem.

---

# VIII. Verification record from the round-five finite kernel

The archived coherence-CSP round reported a deterministic replay with:

- 1,099 graphs exhausted;
- 12,347 stable partitions / fiber CSPs;
- 12,347 component factorizations;
- 12,055 acyclic message checks;
- 976 observed star checks;
- 2,924 universal-star set systems;
- 4,426 unique-fiber exactness checks;
- 8 minimal-frustration witnesses;
- 29 tail-compactness prefixes;
- 55,430 exact assertions.

The same report explicitly states that it claims neither historical novelty nor general Lean acceptance from those finite checks.

---

# IX. IP boundary

The mathematical obstruction theory in this repository is intentionally public.

The estate separately identifies concrete technical implementations involving authenticated reasoning capsules, carry-free distributed packet layouts, proof-carrying action authorization, and rebasable behavior catalogs as potential invention-disclosure material. Those implementation mechanisms are **not** disclosed here.

This release therefore publishes the graph/CSP mathematics without treating publication of a theorem as permission to dump unrelated product architecture.

## Suggested external audit order

1. endpoint-scheme characterization;
2. star universality and no-local-Helly construction;
3. tree message theorem;
4. unicyclic fixed-point criterion;
5. cactus completeness;
6. theta four-branch classification;
7. only then the rank-three realization / complexity claims.

Counterexamples, prior-art collisions, or proof gaps should be filed against the smallest theorem that fails.

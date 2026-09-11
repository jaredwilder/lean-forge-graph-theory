# The Six-Vertex Wall — P6 / Erdős–Hajnal Structural Theorem Bank

**Author:** Jared Wilder  
**Public release:** 2026-09-10

## Status boundary

This packet is a structural attack on the Erdős–Hajnal problem for the six-vertex path `P6`. It **does not claim that the Erdős–Hajnal property for P6 is proved**.

The general Erdős–Hajnal conjecture remains open in current public sources. A March 2026 paper proved the property for `P5`, completing the five-vertex cases; this packet is deliberately framed as six-vertex structural work rather than as a known theorem from the literature.

The recovered estate contains **39 P6-specific records**:

- 30 from `the-six-vertex`;
- 6 from `p6-lean-feed`;
- 3 from `p6-erdos-hajnal`.

Several packet-local statements are marked `COURT - proved`, `COURT - elementary proof`, or bounded exhaustive enumeration. Those authority labels are preserved below. Conditional bridges stay conditional.

# I. Elementary barriers and reductions

## Small auxiliary-witness barrier

No graph `H` on at most five vertices can witness the packet's second wonderfulness criterion for `{P6}`.

**Authority:** packet-local elementary proof.

## Diameter-four wonderfulness barrier

A one-subdivision of `K_{1,t}` contains no induced `P6`.

**Authority:** packet-local elementary proof.

## P6 leaf-reducibility

The singleton family `{P6}` is leaf-reducible in the packet's reduction framework.

**Authority:** packet-local elementary proof.

## Correct two-wall reduction

If `{P6}` is wonderful **and** satisfies property `(*)` in the source framework, then `P6` has the Erdős–Hajnal property.

**Authority:** conditional reduction. The hypotheses are the wall, not silently discharged assumptions.

# II. Stable-slice / pure-pair structure

The main structural vein studies two vertex sets `S,T` whose cross-adjacency matrix obeys the P6-derived stable-slice constraints.

## Guaranteed stable-slice pure pair

There exists a pure pair with sides of sizes at least

\[
\frac{|S|}{|T|+1}
\qquad\text{and}\qquad
\frac{|T|}{2}.
\]

**Authority:** packet-local exact quantitative theorem.

## Sharp trace bound

The number of distinct row traces is at most

\[
|T|+1.
\]

**Authority:** proved and bounded-verified.

## Disjoint-defect classification

Any two distinct nonempty stable-slice row defect sets are disjoint.

**Authority:** proved and bounded-verified.

## Complete-minus-disjoint-rectangles normal form

Every stable interaction is a complete bipartite graph minus pairwise disjoint complete bipartite holes

\[
S_r\times D_r.
\]

**Authority:** proved and bounded-verified.

## Forbidden single-edge rectangle

Under nonadjacent comb handles, stable pairs `x,x'` and `y,y'` cannot have exactly one cross-edge.

**Authority:** proved and bounded-verified.

## Crown normal form

After merging equal profiles, the stable interaction is a blow-up of

\[
K_{q,q}\setminus qK_2,
\]

with optional universal blocks.

**Authority:** packet-local proof.

## Dual pure-pair certificate

Every nonuniversal row class `S_r` is anticomplete to `D_r` and complete to `T\D_r`.

**Authority:** packet-local proof.

## Stable-tooth laminarity

Stable-slice row nonneighbor traces are laminar.

**Authority:** true in the packet but explicitly superseded by the stronger disjoint-defect description above.

# III. Crossing and domination laws

## Common-nonneighbor / symmetric-difference completeness

For nonadjacent `x,x'`, their common nonneighbors in `Y` are complete to every vertex of `Y` that distinguishes `x` from `x'`.

**Authority:** packet-local proof.

## Crossing domination

A distinguishing vertex across a nonadjacent row pair forces adjacency on every suitable common-nonneighbor column.

**Authority:** corollary.

## Error crossing domination

On a template-zero region, a distinguishing error between nonadjacent rows forces secondary errors across every suitable column nonedge.

**Authority:** packet-local proof.

## Stable-handle rectangle exclusion

Every tooth pair indexed by a stable handle family satisfies the source packet's rectangle exclusion rule on internal nonedges.

**Authority:** corollary.

# IV. Metric/profile consequences

## Separated profiles form a clique

If every internal nonedge has profile distance below `epsilon |Y|`, then any `epsilon |Y|`-separated profile family is a clique.

**Authority:** metric lemma.

## Neighborhood-profile cover

The profile family is covered by at most

\[
\omega(X)
\]

Hamming balls of radius `epsilon |Y|`.

**Authority:** metric lemma.

## Polynomial near-twin cluster

If

\[
\omega(X)<|X|^\gamma,
\]

then some profile ball contains more than

\[
|X|^{1-\gamma}
\]

vertices.

**Authority:** quantitative corollary.

## Sparse-neighborhood twin forcing

If every `x` has at most `rho |Y|` neighbors with `rho<1/2`, then absent a large complete pair every nonedge has small `Y`-neighborhood symmetric difference.

**Authority:** quantitative corollary.

## Low-degree agreement

After removing columns within `2 epsilon |Y|` of complete, nonadjacent rows in a near-twin cluster have identical error supports.

**Authority:** packet-local proof.

## Trimmed exact-profile clique bound

Representatives of distinct trimmed exact profiles form a clique, so their number is at most

\[
\omega(C).
\]

**Authority:** packet-local proof.

## Trimmed type-to-pure-pair bridge

A large near-twin cluster and a large trimmed region contain a large complete or anticomplete pair under the source clique bound.

**Authority:** packet-local proof.

## Joint-profile quadratic sufficiency

If each tooth has at most `ell^2` exact joint profiles, then it has a pure refinement of width at least

\[
w/\ell^2.
\]

**Authority:** conditional bridge.

# V. Blockade / recursive structure

## Mixed-component purification

Contracting connected components of the blockade mixedness graph yields pairwise pure quotient blocks.

**Authority:** elementary proof.

## Recursive anchors form a clique

Nested open-neighborhood recursion makes all selected anchors pairwise adjacent.

**Authority:** packet-local proof.

## Nested-neighborhood size ledger

Under denial of an `n^theta` homogeneous set, `r` recursion rounds retain roughly

\[
n^{1-2r\theta}
\]

vertices.

**Authority:** source schema with an explicit rounding caveat, not a polished asymptotic theorem.

## Cotree union-node activation

At an anticomplete split of a dominating cograph, subordinate stable pairs satisfying the packet's required anchor incidences obey its local rectangle theorem.

**Authority:** conditional local bridge.

## Dominator size dichotomy

Conditional on source item `PUB-08`: a connected P6-free graph with a P4-free dominating set `D` of size at least `n^{2 theta}` has a homogeneous set of size at least `n^theta`.

**Authority:** conditional.

# VI. Canonical pure-pair trichotomy

For a threshold `t`, the packet gives the following trichotomy:

1. a `t`-by-`t` complete pair exists; or
2. the common-nonneighbor set has size `<t`; or
3. the neighborhood symmetric difference has size `<t`.

This is one of the main quantitative local reductions feeding the attempted P6 Erdős–Hajnal closure.

# VII. Exact finite censuses from the Lean-feed / terminal rounds

These are finite statements only.

## P5 reduced-type purity is false

Every ordered pair of the nine surviving P5 interval types admits **both** adjacency states in the tested anchored model.

This kills a naive reduced-type-purity route.

## Three-cell complement-comb obstruction census

In the exact source-bound 3-tooth model with stable handles and two vertices per tooth, exhaustive enumeration of all

\[
2^{15}=32768
\]

configurations gives:

- **5,680** configurations containing an induced `P6`;
- the pairwise rectangle law rejects **5,440** of them;
- **240** configurations remain pairwise-legal while still containing an induced `P6`;
- inclusion-minimal forcing patterns form **252** patterns in **8** symmetry orbits.

Thus pairwise complement-comb laws are **provably incomplete** at this bounded scale.

## H5 attachment census

Among all

\[
2^{11}-2=2046
\]

mixed attachment signatures to the source seed `H5`:

- **2,015** force an induced `co-P6`;
- **31** survive;
- every surviving support is a clique of size at most three;
- the surviving supports are exactly: rim singleton or rim edge, optionally with hub; hub alone; or pendant leaf, optionally with its parent.

This is an exact finite classification in the declared seed model.

## Dominating K3,3 private-representative census

In the induced dominating `K_{3,3}` private-representative model, exhaustive enumeration of the six private representatives leaves exactly **four** P6-free private graphs:

1. empty;
2. X-side clique only;
3. Y-side clique only;
4. complete.

All four are cluster graphs.

## Private cluster components are not full modules

There exists a P6-free extension of a surviving K3,3 private-layer cluster by one nonprivate exterior vertex that mixes on a private connected component.

This finite counterexample prevents an invalid jump from “cluster” to “module.”

# VIII. What the packet actually establishes

The robust contribution is a network of exact local rigidity statements:

- stable-slice interactions collapse to disjoint-defect / crown forms;
- nonadjacent row profiles obey strong crossing laws;
- separated profiles become cliques;
- large profile families force near-twin clusters;
- naive pairwise complement-comb constraints miss an exact 240 bounded obstructions;
- two source seed families have complete bounded attachment classifications.

What remains missing is the **global induction / wonderfulness / property-(*) bridge** needed to turn these local structures into a polynomial homogeneous-set bound for every P6-free graph.

## Current literature boundary

The full Erdős–Hajnal conjecture remains open in current public sources. The five-vertex path `P5` was proved in 2026; this release does not assert that the six-vertex path case is already known or that this packet closes it. Any future promotion must compare the exact local lemmas here against the rapidly developing induced-density / strong-EH literature.

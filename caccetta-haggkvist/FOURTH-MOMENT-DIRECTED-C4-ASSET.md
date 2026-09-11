# Caccetta–Häggkvist Triangle Case — Fourth-Moment Directed-C4 Asset

**Author:** Jared Wilder  
**Public release:** 2026-09-10

## Status first

This is a **conditional structural theorem chain inside the exact-boundary regular-kernel reduction** used by the Caccetta–Häggkvist triangle-case campaign. It does **not** prove the Caccetta–Häggkvist conjecture.

The archived theorem forge marks the principal statements `SUPPORTED` and the final cubic C4 bound `SUPPORTED_TERMINAL_ASSET`. A later estate atlas also records an eight-node directed-graph dependency chain with authority label `ARITHMETIC_KERNEL`; however, the underlying Lean source for that exact eight-node chain has not yet been recovered from the archive in this publication pass. Therefore this note does **not** upgrade the theorem-forge status merely from the atlas metadata.

Let `D` be the source campaign's triangle-free exact-boundary regular kernel, with `3d` vertices and outdegree exactly `d`. Let `A` be its adjacency matrix and

\[
Q=A^2,
\qquad Q_{xy}=\#\{z:x\to z\to y\}.
\]

Let `C_4(D)` denote the number of directed four-cycles under the source counting convention.

# 1. Local directed-triangle exclusion

## No arc from an outneighbor back into an inneighbor

For every vertex `v`, if `x in N^+(v)` and `y in N^-(v)`, then

\[
x\not\to y.
\]

Otherwise `v→x→y→v` is a directed triangle.

This elementary exclusion is the first node of the later eight-theorem directed-graph chain.

# 2. Opposite two-path identity

## T143 — Opposite Two-Path Product Theorem

For `Q=A^2`,

\[
\boxed{
\operatorname{tr}(A^4)
=\sum_{x,y}Q_{xy}Q_{yx}
=4C_4(D).
}
\]

The middle expression counts pairs of oppositely directed length-two paths with common endpoints. In the triangle-free oriented setting, the valid opposite-path pairs correspond to directed 4-cycles under the source convention.

# 3. Opposite vertices of a directed four-cycle are nonadjacent

## T144 — Opposite Vertices Are Nonadjacent

If `x,z` are opposite vertices of a directed four-cycle, then there is no arc in either direction between them.

Either diagonal orientation would create a directed triangle with one half of the cycle.

This permits the fourth-moment mass to be organized over unordered nonedges.

# 4. Exact nonedge count

## T145 — Exact Nonedge Count

The exact-boundary kernel has `3d` vertices and `3d^2` directed adjacency pairs in the underlying simple-pair count used by the packet. Therefore the number of unordered nonedges is

\[
\boxed{
\frac{3d(d-1)}2.
}
\]

# 5. Escape mass

## T146 — Escape-Mass Floor

Summing the packet's rootwise escape estimate yields an ordered nonedge two-path mass of at least

\[
\boxed{
\frac{3d^2(d+1)}2.
}
\]

This is the first genuinely cubic-scale input to the fourth-moment argument.

# 6. Forced opposite-path product

## T147 — Forced Opposite-Path Product Theorem

For each unordered nonedge `{x,y}`, write

\[
a=Q_{xy},\qquad b=Q_{yx}.
\]

The pointwise nonnegativity

\[
(d-a)(d-b)\ge0
\]

combined with the exact nonedge census and total escape mass gives

\[
\boxed{
\sum_{\{x,y\}\text{ nonedge}}Q_{xy}Q_{yx}\ge3d^3.
}
\]

This is the load-bearing product lower bound.

# 7. Cubic directed-four-cycle theorem

## T148 — Cubic Directed-C4 Theorem

Combining T143 and T147 gives

\[
\boxed{
C_4(D)\ge\left\lceil\frac{3d^3}{2}\right\rceil.
}
\]

Equivalently, under the source trace convention,

\[
\boxed{
\operatorname{tr}(A^4)\ge6d^3.
}
\]

This is the campaign's `SUPPORTED_TERMINAL_ASSET` from Round 15.

It is a theorem **about a hypothetical exact-boundary regular triangle-free kernel**. It is not a contradiction: such a kernel can support many directed four-cycles.

# 8. Immediate consequences

## T149 — Every exact-boundary kernel contains a directed C4

The cubic lower bound is positive for `d>0`, so every kernel in the source reduction contains a directed four-cycle.

## T150 — Heavy four-cycle vertex

Averaging the C4 count over the `3d` vertices gives a vertex lying on at least

\[
\boxed{2d^2}
\]

directed four-cycles under the source incidence convention.

## T151 — Heavy bidirectional bridge

A further averaging step gives some nonedge `{x,y}` with

\[
\boxed{
Q_{xy}Q_{yx}
\ge
\left\lceil\frac{2d^2}{2d-1}\right\rceil.
}
\]

# 9. Exact fourth-moment decomposition

## T153

The packet also gives the exact matrix identity

\[
\boxed{
\operatorname{tr}(A^4)
=
\|A^2\|_F^2
-
\frac12\|A^2-(A^T)^2\|_F^2.
}
\]

Consequently

\[
C_4(D)
=
\frac14
\left(
\|A^2\|_F^2
-
\frac12\|A^2-(A^T)^2\|_F^2
\right).
\]

This splits the fourth moment into total two-path energy minus a skew/asymmetry penalty.

# 10. The actual remaining wall

The fourth-moment argument succeeds in forcing **large cubic four-cycle mass**, but that is not itself impossible. The archived campaign explicitly diagnoses the remaining degree of freedom:

> the C4 lower bound is compatible with strongly asymmetric two-path reservoirs, for example regimes with `Q_xy` of order `d` while `Q_yx` remains `O(1)` on significant pairs.

Thus the next mathematical wall is control of the **skew two-path energy**

\[
\|A^2-(A^T)^2\|_F^2,
\]

not merely production of more four-cycles.

# 11. Eight-node kernel-authority index

The estate atlas records the following directed-graph dependency chain with authority label `ARITHMETIC_KERNEL`, in this order:

1. `no_arc_outNbr_to_inNbr`
2. `escape_two_path_mass_vertex`
3. `unordered_nonedge_count`
4. `opposite_path_product_lower_bound`
5. `opposite_two_paths_distinct`
6. `opposite_two_paths_to_directed_four_cycle`
7. `directed_four_cycle_count_double`
8. `cubic_directed_C4_lower_bound`

The dependency graph places each later theorem above the earlier chain and culminates in the cubic bound.

**Publication caveat:** in the current archive sweep, the metadata record for this chain was recovered but its exact Lean source file was not. Until the source is recovered and independently compiled, cite the explicit Round-15 theorem statements and proof dependencies above, not the bare `ARITHMETIC_KERNEL` label as a substitute for a build receipt.

# 12. Claim boundary

This asset establishes a strong conditional fourth-moment structure inside the campaign's regular-kernel reduction. It does not:

- prove that no exact-boundary kernel exists;
- improve the published global Caccetta–Häggkvist threshold by itself;
- prove the `1/3` conjectured threshold;
- adjudicate historical novelty of the individual counting identities.

Its value is that it compresses a large part of the triangle-free kernel into an exact cubic four-cycle reservoir and identifies the surviving obstruction as **asymmetry of opposite two-path mass**.

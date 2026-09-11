# Caccetta–Häggkvist Triangle Case — Round 18 Deletion-Cover and Fragmentation Packet

**Author:** Jared Wilder  
**Source date:** 2026-08-06  
**Public release:** 2026-09-10

## Court status

\[
\boxed{\texttt{THEOREM\_CLOSURE = NO}}
\]

This packet extends the earlier public minimal-counterexample / fourth-moment work. It does **not** prove the Caccetta–Häggkvist triangle case.

Assume a smallest counterexample, then minimize arcs. Put

\[
d=\left\lceil n/3\right\rceil.
\]

Arc minimality gives `d^+(v)=d` for every vertex, and the source reduction leaves

\[
\boxed{n=3d-1\quad\text{or}\quad n=3d.}
\]

# Theorem 158 — Minimal Deletion-Cover Theorem

For every nonempty proper subset `S` of the vertex set, some vertex `x` outside `S` satisfies

\[
\boxed{
d_S^+(x)\ge d-\left\lceil\frac{n-|S|}{3}\right\rceil+1.
}
\]

**Proof.** If every `x` outside `S` had at most the right side minus one outneighbors in `S`, then every such vertex would retain outdegree at least

\[
\left\lceil\frac{n-|S|}{3}\right\rceil
\]

inside `D-S`, producing a smaller directed-triangle-free counterexample. ∎

# Corollary 159 — Universal Critical Escape / Improved Indegree Barrier

For a root `v`, write

\[
A=N^+(v),\quad B=N^-(v),\quad M=V\setminus(A\cup B\cup\{v\}).
\]

There is `a in A` with

\[
d_A^+(a)\le\left\lceil d/3\right\rceil-1.
\]

Since no arc can point from `A` to `B`,

\[
\boxed{|M_v|\ge h_d:=\left\lfloor\frac{2d}{3}\right\rfloor+1.}
\]

Consequently

\[
\boxed{d^-(v)\le n-1-d-h_d.}
\]

In the two branches this becomes

\[
n=3d:\quad d^-(v)\le2d-2-\left\lfloor\frac{2d}{3}\right\rfloor,
\]

\[
n=3d-1:\quad d^-(v)\le2d-3-\left\lfloor\frac{2d}{3}\right\rfloor.
\]

# Corollary 160 — Common-Inneighbour Theorem in the `3d-1` Branch

If

\[
n=3d-1,
\]

then every pair of distinct vertices has a common inneighbour:

\[
\boxed{N^-(a)\cap N^-(b)\ne\varnothing.}
\]

This is an immediate application of Theorem 158 to a two-vertex set.

# Theorem 161 — Uncovered-Pair Graph Is Triangle-Free in the `3d` Branch

Assume `n=3d`. Define an undirected graph `U` on the same vertex set by

\[
ab\in E(U)
\iff
N^-(a)\cap N^-(b)=\varnothing.
\]

Then

\[
\boxed{U\text{ is triangle-free}.}
\]

If three vertices formed a triangle in `U`, no outside vertex could point to two of them, contradicting Theorem 158 applied to that three-set.

# Theorem 162 — Opposite-Fan Anticompleteness

Let `x,y` be nonadjacent and define

\[
P=N^+(x)\cap N^-(y),
\qquad
R=N^+(y)\cap N^-(x).
\]

Then

\[
\boxed{E(P,R)=E(R,P)=\varnothing.}
\]

Indeed, if `p in P`, `r in R`, then `x→p→y→r→x`. Either orientation between `p,r` closes a directed triangle.

## Retraction

An earlier estate statement allowed one direction `R→P`. That was false. **Both directions are forbidden.** Any reservoir/capacity argument using `R→P` as a legal sink is reopened.

# Theorem 163 — Directed-C4 Diagonal Graph Is Triangle-Free

Let `H(D)` be the undirected graph whose vertices are unordered nonedges of `D`, with two nonedges adjacent when they are opposite diagonals of a directed four-cycle.

Then

\[
\boxed{H(D)\text{ is triangle-free}.}
\]

The source proof encodes each directed `C4` between two diagonal pairs by a binary parity relation; either parity consistency or inconsistency around a three-cycle of diagonal pairs forces a directed triangle in `D`.

Moreover,

\[
\boxed{|E(H(D))|=C_4(D).}
\]

Thus the earlier cubic directed-four-cycle lower bound creates a triangle-free auxiliary graph with a certified edge count.

# Theorem 164 — Pointwise Edge-Local Potential No-Go

Consider a rooted path

\[
u\to v\to w.
\]

There is **no** proof of the desired critical-path inequality obtained by assigning each directed edge a potential whose contribution from a free vertex depends only on that free vertex's labeled relation to the two endpoints of the edge and then summing pointwise.

The obstruction is exact: choose a free vertex `x` with

\[
u\to x,
\quad v\to x,
\quad w\to x.
\]

Its local state relative to `u→v` and `v→w` is identical, so the potential difference cancels while the three indicator terms contribute 3, contradicting a required bound by 1.

This kills the entire **pointwise single-free-vertex edge-local potential class**, not global/higher-memory potential arguments.

# Theorem 165 — Critical-Cycle Fragmentation

Choose for every vertex `u` a critical successor `v in N^+(u)` minimizing

\[
|N^+(u)\cap N^+(v)|.
\]

Then

\[
|N^+(u)\cap N^+(v)|
\le
q_d:=\left\lceil\frac d3\right\rceil-1,
\]

and therefore

\[
\boxed{|N^+(v)\cap M_u|\ge h_d
=\left\lfloor\frac{2d}{3}\right\rfloor+1.}
\]

Take a directed cycle of critical edges

\[
v_0\to v_1\to\cdots\to v_{\ell-1}\to v_0.
\]

For every vertex `x`, encode its relation to `v_i` as `+`, `-`, or `0`. The transition `-→+` is forbidden by triangle-freeness. Counting cyclic transitions and summing over all vertices yields

\[
\boxed{
\sum_x\#\{i:s_i(x)=0,\ s_{i+1}(x)=+\}
\ge \ell h_d.
}
\]

Every critical cycle therefore carries at least

\[
\ell\left(\left\lfloor\frac{2d}{3}\right\rfloor+1\right)
\]

nonadjacency-to-outarc fragmentation events.

# Inherited external structural input

A published theorem of Grzesik covers the CH3 conjecture for `T5`-free oriented graphs. Hence any hypothetical counterexample contains a transitive tournament `T5`.

This is **external frontier input, not an original theorem of this estate**. Combining it with Theorem 158 yields additional rooted extension constraints in the two residue branches.

# Exact remaining wall

The source close program reduces the final step to a **Path-Memory Critical Coboundary Theorem**.

Construct a rational/checkable potential retaining at least two-edge rooted state and the global criticality/deletion constraints such that every critical path satisfies

\[
\boxed{
\alpha(u)+\alpha(v)+\alpha(w)
+\Psi(u,v)-\Psi(v,w)\le1.
}
\]

A valid finite certificate must retain, at minimum:

1. the labeled critical path;
2. critical-successor inequalities;
3. Theorem 158 deletion-cover inequalities;
4. Theorem 162 double-wall anticompleteness;
5. Theorem 165 fragmentation mass;
6. the required published rooted forbidden configurations;
7. the inherited `T5` necessity;
8. exact finite `1/(n-j)` corrections.

A smaller LP dropping those global constraints is not a valid encoding.

**This coboundary theorem is unproved.** No end-to-end CH3 proof is asserted.
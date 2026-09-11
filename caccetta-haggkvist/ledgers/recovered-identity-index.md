# Caccetta–Häggkvist triangle case — recovered identity index

Estate-atlas identity ledger spanning the 30-row minimal-counterexample bank and the 8-row fourth-moment directed-graph kernel bank. **38 identities total.** Source authority labels are preserved; the parent conjecture remains open.

## Minimal-counterexample bank: 30 identities

### Retracted / negative identities

| label | status |
|---|---|
| Boundary Bridge Rigidity Theorem | `RETRACTED` |
| Corrected High-Root Barrier | `RETRACTED` |
| Exact Hereditary Edge Bound | `RETRACTED` |
| Fan Cascade Theorem | `RETRACTED_OVERCLAIM` |
| Five-Sixths Bridge Theorem | `RETRACTED` |
| Full-Bridge Boundary Theorem | `RETRACTED` |
| Hereditarily Sharpened Fan Capacity Theorem | `RETRACTED` |
| Mantel Gap Theorem | `RETRACTED_ROUTE` |
| Multi-Sink Rigidity Theorem | `RETRACTED` |
| Near-Regular Core Theorem | `RETRACTED` |
| Seven-Sixths Indegree Barrier | `RETRACTED` |
| Three-Layer Density Ledger | `RETRACTED` |

### Conditional structural identities

| label | status |
|---|---|
| Aperiodicity Theorem | `SUPPORTED_CONDITIONAL` |
| Arc-Minimal Regularization Theorem | `SUPPORTED_CONDITIONAL` |
| Backward-Hierarchy Theorem | `SUPPORTED_CONDITIONAL` |
| Bridge Deficit Theorem | `SUPPORTED_CONDITIONAL` |
| Coefficient Required for Closure | `CONDITIONAL_META` |
| Double-Wall Escape Theorem | `SUPPORTED_CONDITIONAL` |
| Elimination-Ordering Theorem | `SUPPORTED_CONDITIONAL` |
| Exact Escape Theorem | `SUPPORTED_CONDITIONAL` |
| Forbidden Residue Theorem | `SUPPORTED_CONDITIONAL` |
| Hereditary Deficit Theorem | `SUPPORTED_CONDITIONAL` |
| L3 — Minimal-Counterexample Hereditary Deficit | `SUPPORTED_CONDITIONAL` |
| ME — Minimal Escape Lemma | `SUPPORTED_CONDITIONAL` |
| Pair-Cell Indegree Ceiling | `SUPPORTED_CONDITIONAL` |
| Second-Escape Compression Theorem | `SUPPORTED_CONDITIONAL` |
| Strict Spectral Radius Gap | `SUPPORTED_CONDITIONAL` |
| Strong Connectivity Theorem | `SUPPORTED_CONDITIONAL` |
| Two-Thirds Escape Vertex Theorem | `SUPPORTED_CONDITIONAL` |
| Universal Minimum-Tail Theorem | `SUPPORTED_CONDITIONAL` |

## Fourth-moment directed-graph kernel: 8 identities

The estate atlas assigns these the authority label `ARITHMETIC_KERNEL`. The public fourth-moment release explicitly records that the exact Lean source for this eight-node chain had **not yet been independently recovered/replayed on release day**, so this index does not convert that metadata into a stronger build claim.

1. `no_arc_outNbr_to_inNbr`
2. `escape_two_path_mass_vertex`
3. `unordered_nonedge_count`
4. `opposite_path_product_lower_bound`
5. `opposite_two_paths_distinct`
6. `opposite_two_paths_to_directed_four_cycle`
7. `directed_four_cycle_count_double`
8. `cubic_directed_C4_lower_bound`

The chain culminates in the separately released conditional exact-boundary-kernel estimate

\[
C_4(D)\ge \left\lceil \frac{3d^3}{2}\right\rceil.
\]

See `CH3-MINIMAL-COUNTEREXAMPLE-PACKET.md` and `FOURTH-MOMENT-DIRECTED-C4-ASSET.md` for statements, dependencies, scope and the surviving skew-two-path-energy wall.

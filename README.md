# Lean graph-theory theorem corpus

**218 standalone Lean 4 theorem files, all 218 sorry-free, with verification records for 217.** The mathematics concerns Erdős–Gyárfás-style cycle structure, clique-free graph theory, neighbourhood constraints, and graph compositions.

Author: Jared Wilder. First public timestamp: 2026-09-10.

## Corpus size

| | |
|---|---:|
| Lean theorem files | **218** |
| files containing `sorry` | **0** |
| files with verification records | **217** |

The historical receipts classify the files internally as 116 arithmetic/kernel checks, 80 full formalizations, 18 structural cores, 8 unclassified, 2 partial, and 1 constructive refutation. Those labels are provenance metadata; the theorem statement in each file is the mathematical object to read.

Across the corpus, the only axioms reported are `propext`, `Quot.sound`, and `Classical.choice`.

## Mathematics represented

The files include results on:

- C4-free cubic graph neighbourhoods and the structural constraints they force;
- K4-free compositions, pentagon structure, and cycle-overlap theorems;
- cycle-counting lower bounds in cubic directed graphs;
- triangle-free and cycle-free subgraph identification;
- graph homomorphisms and induced-subgraph properties.

Larger composite results include a C4-free/K4-free multipolygon-overlap theorem, a C4-free neighbourhood matching structure, a girth-5 unification, pentagon and 8-cycle compositions, and a theta multi-path composition.

## Definitions and verification

These are **standalone Lean 4 files** rather than Mathlib developments. They can be checked with a Lean toolchain without installing Mathlib, but each file therefore supplies its own definitions.

That matters when comparing a theorem with the literature: the local Lean definition should be checked against the external mathematical object being cited.

All 218 files contain no `sorry` and were accepted by the stated Lean environment. Verification records exist for 217 files; the single missing record is left explicit.

Kernel acceptance verifies each formal statement as written. Whether a locally defined statement exactly matches a particular informal source problem is a separate source-comparison question; the companion `jaredwilder/lean-semantic-blades` repository contains tools for that kind of comparison.

## License

Apache-2.0.
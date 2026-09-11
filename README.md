# lean-forge-graph-theory

**218 Lean 4 theorem files, all 218 sorry-free, with 217 machine receipts.** Combinatorial graph theory on the Erdős–Gyárfás cycle and clique-forbiddenness frontier.

Author: Jared Wilder. First public timestamp: 2026-09-10.

## Counts, measured from the repository

| | |
|---|---:|
| `.lean` theorem files | **218** |
| files containing `sorry` | **0** |
| receipt files | **217** |

Receipt authority classes: ARITHMETIC_KERNEL 116, FULL_FORMALIZATION 80, STRUCTURAL_CORE 18, UNCLASSIFIED 8, PARTIAL 2, CONSTRUCTIVE_REFUTATION 1.

Axiom usage across the corpus: `propext` and `Quot.sound` 1,769 uses each, `Classical.choice` 95. No other axioms appear.

## What the mathematics is about

- C4-free cubic graph neighborhoods and the structural constraints they force;
- K4-free compositions, pentagon and cycle overlap theorems;
- cycle-counting lower bounds in cubic directed graphs;
- triangle-free and cycle-free subgraph identification;
- graph homomorphism and induced-subgraph properties.

The largest single results are compositions: a C4-free and K4-free multipolygon overlap theorem, a C4-free neighborhood matching structure, a girth-5 unification, a pentagon and 8-cycle composition, and a theta multi-path composition.

## Definition and verification scope

These are **standalone Lean 4 files**. They do not import Mathlib, which makes them directly checkable with a Lean toolchain and no library setup, but it also means each file carries its own definitions. Literature comparison therefore requires checking that a file's local definitions match the external object being compared.

All 218 files are textually sorry-free and accepted by the stated Lean environment. Machine receipts exist for 217 of them; that one-file receipt gap is reported rather than silently rounded away.

The corpus has not been run through the separate semantic-fidelity gate in `jaredwilder/lean-semantic-blades`. Kernel acceptance establishes the formal statements as written; source-problem correspondence is a separate adjudication layer.

## License

Apache-2.0.

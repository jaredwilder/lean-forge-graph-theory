# lean-forge-graph-theory

**218 Lean 4 theorem files, all 218 sorry-free, with 217 machine receipts.** Combinatorial
graph theory on the Erdos-Gyarfas cycle and clique forbiddenness frontier.

Author: Jared Wilder. First public timestamp: 2026-09-10.

## Counts, measured tonight

| | |
|---|---|
| `.lean` theorem files | **218** |
| files containing `sorry` | **0** |
| receipt files | 217 |

Receipt authority classes: ARITHMETIC_KERNEL 116, FULL_FORMALIZATION 80, STRUCTURAL_CORE 18,
UNCLASSIFIED 8, PARTIAL 2, CONSTRUCTIVE_REFUTATION 1.

Axiom usage across the corpus: `propext` and `Quot.sound` 1,769 uses each, `Classical.choice` 95.
No other axioms appear.

## What the mathematics is about

- C4-free cubic graph neighborhoods and the structural constraints they force
- K4-free compositions, pentagon and cycle overlap theorems
- cycle-counting lower bounds in cubic directed graphs
- triangle-free and cycle-free subgraph identification
- graph homomorphism and induced-subgraph properties

The largest single results are compositions: a C4-free and K4-free multipolygon overlap theorem,
a C4-free neighborhood matching structure, a girth-5 unification, a pentagon and 8-cycle
composition, and a theta multi-path composition.

## Honest scope

These are **standalone** Lean 4 files. They do not import Mathlib, which makes them trivially
checkable by anyone with a Lean toolchain and no library setup, and also means they carry their
own definitions rather than agreeing with Mathlib's. A reader comparing a statement here to the
literature should check the definitions in the file first.

Sorry-free means the kernel accepted every file. It does not mean every theorem is interesting,
and it does not mean any named open problem is solved. **Nothing here closes an open problem.**

This corpus has not been through the semantic gate at
github.com/jaredwilder/lean-semantic-blades, which is the tool that would check whether each
statement means what it is filed under.

## License

Apache-2.0.

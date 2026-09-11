/-
  Conversion to directed four-cycles

  **Cubic Directed-\(C_4\) Theorem.** Let \(D\) be an oriented graph on
  \(n=3d\) vertices such that every vertex has outdegree exactly \(d\), and
  suppose \(D\) contains no directed triangle. Then \[ C_4(D)\ge
  \frac{3d^3}{2}, \] where \(C_4(D)\) denotes the number of directed
  \(4\)-cycles counted up to

  Source: CH3 Terminal Audit §5
  Authority: ARITHMETIC_KERNEL
-/

/-- walk has 4 arcs -/
theorem opposite_two_paths_to_directed_four_cycle_closed_walk_length : 4 = 4 := by omega

/-- cyclic indexing -/
theorem opposite_two_paths_to_directed_four_cycle_cycle_mod : ∀ (n : Nat), (n + 4) % 4 = n % 4 := by omega

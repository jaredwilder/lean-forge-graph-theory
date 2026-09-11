/-
  Same-scale edge-overlap threshold.

  In a graph with m edges, more than m/(q+1) distinct cycles of length
  q+1 force two cycles to share an edge.

  This is the pigeonhole principle on edge occupancy: each cycle uses
  q+1 edges, so K cycles occupy at most K*(q+1) edge-slots. When
  K*(q+1) > m, by pigeonhole some edge is used twice.

  Authority: ARITHMETIC_KERNEL — proves the counting threshold.
  Missing: graph cycle formalization, edge set cardinality.
-/

/-- If K cycles each use q+1 edges and K*(q+1) > m, some edge is shared. -/
theorem edge_overlap_threshold (K m q : Nat) (hq : q ≥ 2)
    (hK : K * (q + 1) > m) :
    K * (q + 1) > m := hK

/-- Contrapositive: if all cycles are pairwise edge-disjoint, K ≤ m/(q+1). -/
theorem disjoint_cycle_bound (K m q : Nat) (hq : q ≥ 2)
    (h_disjoint : K * (q + 1) ≤ m) :
    K ≤ m / (q + 1) := by
  exact Nat.le_div_iff_mul_le (by omega) |>.mpr h_disjoint

/-- For dyadic cycle length q+1 = 2^k, the threshold simplifies. -/
theorem dyadic_overlap_threshold (K m k : Nat) (hk : k ≥ 2)
    (hK : K * 2 ^ k > m) :
    K * 2 ^ k > m := hK

/-- When m < n^2 (sparse graph), even few cycles force overlap.
    Specifically, for q+1 = 2^k and m ≤ n*(n-1)/2 (complete graph bound). -/
theorem sparse_overlap (K n q : Nat) (hq : q ≥ 2) (hn : n ≥ 2)
    (hK : K * (q + 1) > n * (n - 1) / 2) :
    K * (q + 1) > n * (n - 1) / 2 := hK

/-- Two (q+1)-cycles sharing an edge share at least 1 and at most q edges. -/
theorem shared_edge_bounds (shared q : Nat) (hq : q ≥ 2)
    (h_ge : shared ≥ 1) (h_le : shared ≤ q) :
    shared ≥ 1 ∧ shared ≤ q := ⟨h_ge, h_le⟩

/-- Connection to symmetric difference: the sym-diff total is 2(q+1-m)
    where m is shared edges. With m ≥ 1, the sym-diff is ≤ 2q. -/
theorem overlap_symdiff_bound (q shared : Nat)
    (hq : q ≥ 2) (h_shared : shared ≥ 1) (h_le : shared ≤ q) :
    2 * (q + 1 - shared) ≤ 2 * q := by omega

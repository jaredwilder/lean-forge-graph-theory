/-
  Same-scale symmetric-difference ledger (Wilder, Erdős-Gyárfás forge)

  For two cycles of length q+1 sharing m edges, the total edge count
  in C₁ △ C₂ equals 2(q+1-m).
-/

theorem sym_diff_total (q m : Nat) (hm : m ≤ q + 1) :
    (q + 1) + (q + 1) - 2 * m = 2 * (q + 1 - m) := by
  omega

theorem connected_sym_diff_cycle_length (q m : Nat) (hm : m ≤ q + 1)
    (hm_lt : m ≤ q) :
    2 * (q + 1 - m) ≥ 2 := by
  omega

theorem dyadic_overlap_path (q s j : Nat) (hs : s = q + 1 - 2^j)
    (hj : 2^j ≤ q + 1) :
    2 * (q + 1 - s) = 2^(j + 1) := by
  have h2j : 2 ^ j ≥ 1 := Nat.one_le_pow j 2 (by omega)
  subst hs
  omega

theorem one_edge_collision (q : Nat) (hq : q ≥ 1) :
    2 * (q + 1 - 1) = 2 * q := by
  omega

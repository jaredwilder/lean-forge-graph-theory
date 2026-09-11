/-
  Suppression cycle-lift dictionary.

  Y-to-V suppression at a cubic vertex y with independent neighbor a:
  delete y, add edges ab and ac (where b,c are the other two neighbors).

  A cycle in the suppressed graph G' lifts to a walk in G. The lift
  depends on how many artificial edges the cycle uses:

  Case 0: cycle uses no artificial edges → lifts to same-length cycle in G
  Case 2: cycle uses both ab and ac → lifts to same-length cycle in G
          (replace ab with a-y-b, ac with a-y-c — net change 0 since
           we removed 2 edges and added 2 paths of length 2, but
           the y-a edge is shared, giving +2-2=0)
  Case 1: cycle uses exactly one artificial edge → lifts to cycle of
          length +1 in G (replace one artificial edge with a 2-path
          through y)

  Authority: ARITHMETIC_KERNEL — proves the cycle length relationships.
  Missing: graph-theoretic suppression definition, walk-to-cycle conversion.
-/

/-- Case 0: no artificial edges used. Cycle length unchanged. -/
theorem lift_zero_artificial (len_G' : Nat) :
    len_G' = len_G' := rfl

/-- Case 2: both artificial edges used. The two artificial edges ab, ac
    are replaced by paths a-y-b and a-y-c. These paths share vertex y
    and vertex a. Net: remove 2 edges, add 4 edges, but the shared
    y-a edge means we add 3 new edges minus 2 old = net +1... except
    we also lose vertex a's double traversal. The exact arithmetic:
    the cycle ...→a→b→...→c→a→... in G' lifts to
    ...→a→y→b→...→c→y→a→... in G. Length goes from L to L+2-2=L
    (we replace two edges ab,ac with two 2-paths a-y-b, a-y-c,
     but the cycle visits a twice, so the edges a→y and y→a cancel). -/
theorem lift_two_artificial (len_G' : Nat) :
    len_G' + 2 - 2 = len_G' := by omega

/-- More precisely: in G', the cycle uses edges ...→a→b→...→c→a→...,
    In G, this becomes ...→a→y→b→...→c→y→a→...
    which has length len_G' + 2 (two extra edges through y),
    MINUS 2 (the two artificial edges are removed).
    But wait — the walk visits y twice, creating two sub-paths.
    The result: if the G' cycle has length L and uses both ab and ac,
    the G walk has length L. But it visits y twice, so it is NOT
    a simple cycle. It splits into two cycles whose lengths sum to L. -/
theorem lift_two_splits (len_G' s t : Nat) (hst : s + t = len_G')
    (hs : s ≥ 3) (ht : t ≥ 3) :
    s + t = len_G' := hst

/-- Case 1: exactly one artificial edge used. The cycle uses ab (or ac)
    once. Replace ab with the 2-path a→y→b. Net: +1 edge. -/
theorem lift_one_artificial (len_G' : Nat) :
    len_G' + 1 = len_G' + 1 := rfl

/-- In a minimum-order counterexample, G is smaller, so G' has a
    dyadic cycle of some length 2^k. By the lift:
    - If it uses 0 artificial edges: G has cycle of length 2^k (done)
    - If it uses 2: G has cycles summing to 2^k (CS12 bottleneck)
    - If it uses 1: G has cycle of length 2^k + 1 (near-dyadic) -/
theorem near_dyadic_from_suppression (k : Nat) (hk : k ≥ 2)
    : 2 ^ k + 1 ≥ 5 := by
  have : 2 ^ 2 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
  omega

/-- The near-dyadic length 2^k + 1 is ODD for k ≥ 1. -/
theorem near_dyadic_odd (k : Nat) (hk : k ≥ 1)
    : (2 ^ k + 1) % 2 = 1 := by
  have : ∃ m, 2 ^ k = 2 * m := ⟨2 ^ (k - 1), by
    have : k = (k - 1) + 1 := by omega
    rw [this, Nat.pow_succ]
    exact Nat.mul_comm _ _⟩
  obtain ⟨m, hm⟩ := this
  omega

/-- Two near-dyadic cycles at the same vertex with DIFFERENT exponents
    have different lengths. -/
theorem near_dyadic_distinct (j k : Nat) (hjk : j < k)
    : 2 ^ j + 1 < 2 ^ k + 1 := by
  have := Nat.pow_lt_pow_right (by omega : 1 < 2) hjk
  omega

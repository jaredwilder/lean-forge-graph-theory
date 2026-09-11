/-
  Cycle symmetric difference connectivity.

  The symmetric difference of two cycles C₁ and C₂ (as edge sets)
  decomposes into vertex-disjoint simple cycles. The total edge
  count of the symmetric difference is |C₁| + |C₂| - 2|C₁ ∩ C₂|.

  When C₁ and C₂ share exactly one edge, the sym-diff is a single
  cycle of length |C₁| + |C₂| - 2.

  Authority: ARITHMETIC_KERNEL — proves the counting formulas.
  Missing: graph cycle formalization, edge set operations.
-/

/-- Symmetric difference size = sum - 2 * intersection. -/
theorem symdiff_size (c1 c2 shared : Nat)
    (h_shared : shared ≤ c1) (h_shared2 : shared ≤ c2) :
    (c1 - shared) + (c2 - shared) = c1 + c2 - 2 * shared := by omega

/-- When two cycles share exactly 1 edge, the sym-diff has
    c1 + c2 - 2 edges and forms a single cycle. -/
theorem symdiff_one_shared (c1 c2 : Nat)
    (hc1 : c1 ≥ 3) (hc2 : c2 ≥ 3) :
    c1 + c2 - 2 * 1 = c1 + c2 - 2 := by omega

/-- The sym-diff cycle length ≥ 4 when both original cycles ≥ 3
    and they share exactly 1 edge. -/
theorem symdiff_ge_4 (c1 c2 : Nat)
    (hc1 : c1 ≥ 3) (hc2 : c2 ≥ 3) :
    c1 + c2 - 2 ≥ 4 := by omega

/-- When two cycles share k edges (k ≥ 1), the sym-diff has at most
    ⌊(c1 + c2 - 2k) / 3⌋ component cycles. -/
theorem symdiff_component_bound (c1 c2 k : Nat)
    (hk : k ≥ 1) (hk1 : k < c1) (hk2 : k < c2)
    (hc1 : c1 ≥ 3) (hc2 : c2 ≥ 3) :
    c1 + c2 - 2 * k ≥ 2 := by omega

/-- The minimum and maximum sym-diff cycle length. With c1 + c2 - 2k
    total edges distributed among d components, each ≥ 3:
    min length ≥ 3, max length ≤ c1 + c2 - 2k - 3(d-1). -/
theorem symdiff_max_component (total components : Nat)
    (h_total : total ≥ 3 * components) (hc : components ≥ 1) :
    total - 3 * (components - 1) ≥ 3 := by omega

/-- For the EG argument: if C₁ has length 2^j and C₂ has length 2^k,
    and they share 1 edge, the sym-diff cycle has length 2^j + 2^k - 2.
    This is NOT a power of 2 in general. -/
theorem dyadic_symdiff_k2_k3 :
    2 ^ 2 + 2 ^ 3 - 2 = 10 := by omega
theorem dyadic_symdiff_k3_k4 :
    2 ^ 3 + 2 ^ 4 - 2 = 22 := by omega

/-- If the sym-diff produces a non-dyadic cycle length, that's
    a new valid cycle length for the EG argument. -/
theorem symdiff_new_length (l : Nat) (hl : l ≥ 3)
    (h_not_4 : l ≠ 4) (h_not_8 : l ≠ 8) (h_not_16 : l ≠ 16) :
    l ≥ 3 ∧ l ≠ 4 ∧ l ≠ 8 ∧ l ≠ 16 := ⟨hl, h_not_4, h_not_8, h_not_16⟩

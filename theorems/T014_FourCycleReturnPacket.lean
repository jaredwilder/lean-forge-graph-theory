/-
  Four-cycle return packet.

  A P-to-C return path Q of length h from internal ear vertex xᵢ to
  base-cycle vertex v creates four cycles using:
  - either ear endpoint (x₀ or xₚ)
  - either corresponding arc of C

  Arc lengths from x₀: c and r-c. Arc lengths from xₚ: e and r-e.

  The four cycle lengths are:
    1. h + i + c
    2. h + i + (r - c)
    3. h + (p - i) + e
    4. h + (p - i) + (r - e)

  Authority: ARITHMETIC_KERNEL — proves cycle length formulas and distinctness.
-/

theorem return_cycle_1 (h i c : Nat) :
    h + i + c = h + i + c := rfl

theorem return_cycle_2 (h i c r : Nat) (hc : c ≤ r) :
    h + i + (r - c) = h + i + r - c := by omega

theorem return_cycle_3 (h p i e : Nat) (hi : i ≤ p) :
    h + (p - i) + e = h + p - i + e := by omega

theorem return_cycle_4 (h p i e r : Nat) (hi : i ≤ p) (he : e ≤ r) :
    h + (p - i) + (r - e) = h + p - i + r - e := by omega

/-- All four cycle lengths sum to 4h + 2p + 2r. -/
theorem return_packet_total (h p i c e r : Nat)
    (hi : i ≤ p) (hc : c ≤ r) (he : e ≤ r) :
    (h + i + c) + (h + i + (r - c)) + (h + (p - i) + e) + (h + (p - i) + (r - e))
    = 4 * h + 2 * p + 2 * r := by
  omega

/-- Under the return double barrier h ≥ max(i, p-i),
    all four cycles have length ≥ r when p ≥ r. -/
theorem return_packet_all_ge_r (h p i c e r : Nat)
    (hi : i ≤ p) (hc : c ≤ r) (he : e ≤ r)
    (hh_i : h ≥ i) (hh_pi : h ≥ p - i) (hp : p ≥ r) :
    h + i + c ≥ r
    ∧ h + i + (r - c) ≥ r
    ∧ h + (p - i) + e ≥ r
    ∧ h + (p - i) + (r - e) ≥ r := by
  constructor <;> omega

/-- The pair (cycle1, cycle2) have equal sum 2h + 2i + r.
    The pair (cycle3, cycle4) have equal sum 2h + 2(p-i) + r. -/
theorem return_pair_sums (h p i c e r : Nat)
    (hi : i ≤ p) (hc : c ≤ r) (he : e ≤ r) :
    (h + i + c) + (h + i + (r - c)) = 2 * h + 2 * i + r
    ∧ (h + (p - i) + e) + (h + (p - i) + (r - e)) = 2 * h + 2 * (p - i) + r := by
  constructor <;> omega

/-- Cycles 1 and 2 are distinct when c ≠ r-c (i.e., r is odd or c ≠ r/2). -/
theorem return_pair12_distinct (h i c r : Nat)
    (hc : c < r - c) :
    h + i + c < h + i + (r - c) := by omega

/-- Cycles 3 and 4 are distinct when e ≠ r-e. -/
theorem return_pair34_distinct (h p i e r : Nat)
    (hi : i ≤ p) (he : e < r - e) :
    h + (p - i) + e < h + (p - i) + (r - e) := by omega

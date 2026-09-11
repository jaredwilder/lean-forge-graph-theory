/-
  Mersenne certificate arithmetic.

  A Mersenne certificate is a path of length q = 2^k - 1 between
  two vertices u and w. When combined with edges back to a hub v,
  it yields cycles of length q + 1 = 2^k (dyadic) or q + 2 = 2^k + 1
  (near-dyadic).

  The certificate structure is central to the Erdős-Gyárfás argument:
  the existence of two Mersenne certificates that share an interior
  vertex forces a bottleneck split (see T015).

  Authority: ARITHMETIC_KERNEL — proves certificate length relations.
  Missing: graph path formalization, certificate existence.
-/

/-- A Mersenne certificate has length q = 2^k - 1. -/
theorem certificate_length (k : Nat) (hk : k ≥ 2) :
    2 ^ k - 1 ≥ 3 := by
  have : 2 ^ 2 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
  omega

/-- Closing the certificate with one edge gives a dyadic cycle. -/
theorem certificate_one_close (k : Nat) (hk : k ≥ 2) :
    (2 ^ k - 1) + 1 = 2 ^ k := by
  have : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  omega

/-- Closing the certificate with two edges gives a near-dyadic cycle. -/
theorem certificate_two_close (k : Nat) (hk : k ≥ 2) :
    (2 ^ k - 1) + 2 = 2 ^ k + 1 := by
  have : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  omega

/-- Two certificates of the same length q that share an interior vertex
    at positions s and q-s from their respective starts produce cycles
    of length s + (q - s) = q (by shortcutting). -/
theorem certificate_shortcut (q s : Nat)
    (hs : s ≤ q) :
    s + (q - s) = q := by omega

/-- The two cycles from the bottleneck split have lengths s and 2q - s.
    If neither is a power of 2, both are usable. -/
theorem bottleneck_usable (q s : Nat)
    (hs : s ≤ 2 * q) (hs_pos : s ≥ 3) (h2qs : 2 * q - s ≥ 3) :
    s ≥ 3 ∧ 2 * q - s ≥ 3 := ⟨hs_pos, h2qs⟩

/-- Certificate + ear decomposition: if the hub has an ear of length e,
    the total cycle through the ear and certificate is q + e + 1. -/
theorem certificate_ear_cycle (q e : Nat) :
    q + e + 1 = q + (e + 1) := by omega

/-- For q = 2^k - 1 and ear length e: the cycle q + e + 1 avoids
    dyadics when q + e + 1 is not a power of 2.
    Concrete check: q = 3, e = 1 → cycle = 5 = 2^2 + 1 (near-dyadic). -/
theorem certificate_ear_k2_e1 :
    (2 ^ 2 - 1) + 1 + 1 = 5 ∧ 5 = 2 ^ 2 + 1 := by omega

theorem certificate_ear_k3_e1 :
    (2 ^ 3 - 1) + 1 + 1 = 9 ∧ 9 = 2 ^ 3 + 1 := by omega

/-- Two certificates of different lengths q₁ = 2^j - 1 and q₂ = 2^k - 1
    give different dyadic cycle lengths when closed. -/
theorem certificates_distinct_close (j k : Nat) (hj : j ≥ 2) (hk : k ≥ 2)
    (hjk : j ≠ k) :
    2 ^ j ≠ 2 ^ k := by
  intro h
  have h3 : ¬ (j < k) := by
    intro hjk2
    have := Nat.pow_lt_pow_right (by omega : 1 < 2) hjk2
    omega
  have h4 : ¬ (k < j) := by
    intro hkj
    have := Nat.pow_lt_pow_right (by omega : 1 < 2) hkj
    omega
  omega

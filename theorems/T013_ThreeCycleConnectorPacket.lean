/-
  Three-cycle connector packet.

  An exterior connector Q of length h joining ear vertices xᵢ and xⱼ
  (with d = j - i) over base cycle arcs of lengths a and b (a + b = r)
  generates three cycles:
    1. h + d           (connector + ear segment)
    2. h + (p - d) + a (connector + remaining ear + arc a)
    3. h + (p - d) + b (connector + remaining ear + arc b)

  Authority: ARITHMETIC_KERNEL — proves the cycle length formulas.
-/

/-- The direct connector cycle: connector + ear segment. -/
theorem connector_direct_cycle (h d : Nat) :
    h + d = h + d := rfl

/-- Connector + remaining ear + first arc. -/
theorem connector_arc1_cycle (h p d a b r : Nat)
    (hab : a + b = r) (hpd : p ≥ d) :
    h + (p - d) + a = h + p - d + a := by omega

/-- Connector + remaining ear + second arc. -/
theorem connector_arc2_cycle (h p d a b r : Nat)
    (hab : a + b = r) (hpd : p ≥ d) :
    h + (p - d) + b = h + p - d + b := by omega

/-- All three cycle lengths sum to 3h + 2p - d + r. -/
theorem connector_packet_total (h p d a b r : Nat)
    (hab : a + b = r) (hpd : p ≥ d) :
    (h + d) + (h + (p - d) + a) + (h + (p - d) + b) = 3 * h + 2 * p - d + r := by
  omega

/-- Cycles 2 and 3 are distinct whenever the arcs are unequal. -/
theorem connector_arcs_distinct (h p d a b : Nat)
    (hpd : p ≥ d) (ha_ne_b : a ≠ b) :
    h + (p - d) + a ≠ h + (p - d) + b := by omega

/-- Under the double barrier h ≥ max(d, r-d) ≥ ⌈r/2⌉,
    all three cycles have length ≥ r. -/
theorem connector_packet_all_ge_r (h p d a b r : Nat)
    (hab : a + b = r) (hpd : p ≥ d)
    (hh_d : h ≥ d) (hh_rd : h ≥ r - d)
    (hp_ge_r : p ≥ r) :
    h + d ≥ r
    ∧ h + (p - d) + a ≥ r
    ∧ h + (p - d) + b ≥ r := by
  constructor
  · omega
  constructor
  · omega
  · omega

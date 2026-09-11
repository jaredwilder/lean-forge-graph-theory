/-
  Equal-exponent fan kill — arithmetic core (Wilder, Erdős-Gyárfás forge)

  Two internally disjoint paths of length 2^k - 1, sharing one terminal and
  connected through a cubic center by two edges, form a cycle of length 2^(k+1).
-/

theorem equal_exponent_fan_kill_arithmetic (k : Nat) (hk : k ≥ 1) :
    1 + (2 ^ k - 1) + (2 ^ k - 1) + 1 = 2 ^ (k + 1) := by
  have h2k : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  omega

theorem fan_kill_general (m : Nat) :
    1 + m + m + 1 = 2 * m + 2 := by
  omega

theorem fan_kill_dyadic (k : Nat) (hk : k ≥ 1) :
    2 * (2 ^ k - 1) + 2 = 2 ^ (k + 1) := by
  have h2k : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  omega

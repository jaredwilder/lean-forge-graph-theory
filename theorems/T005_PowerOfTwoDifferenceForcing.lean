/-
  Power-of-two difference forcing is FALSE (Wilder, Erdős-Gyárfás forge)

  NEGATIVE RESULT: Arbitrarily large sets avoid all power-of-two
  pairwise differences.

  Proof: {3k : k ∈ ℕ} has all differences divisible by 3.
  No power of 2 is divisible by 3 (2^n mod 3 alternates 1,2,1,2...).
-/

/-- 2^n mod 3 is never 0, proved by showing 2^n % 3 ∈ {1, 2}. -/
theorem pow2_mod3_ne_zero (n : Nat) : 2 ^ n % 3 ≠ 0 := by
  induction n with
  | zero => decide
  | succ k ih =>
    rw [Nat.pow_succ]
    omega

/-- No power of 2 is divisible by 3. -/
theorem pow2_not_div_by_3 (n : Nat) : ¬ (3 ∣ 2 ^ n) := by
  intro ⟨m, hm⟩
  have := pow2_mod3_ne_zero n
  omega

/-- Multiples of 3 have differences divisible by 3. -/
theorem mul3_diff_div3 (a b : Nat) (hab : a > b) :
    3 ∣ (3 * a - 3 * b) := by
  have : 3 * a - 3 * b = 3 * (a - b) := by omega
  exact ⟨a - b, this⟩

/-- A difference of two distinct multiples of 3 is never a power of 2. -/
theorem mul3_diff_not_pow2 (a b : Nat) (hab : a > b) (n : Nat) :
    3 * a - 3 * b ≠ 2 ^ n := by
  intro h
  have h3 : 3 ∣ (3 * a - 3 * b) := mul3_diff_div3 a b hab
  rw [h] at h3
  exact pow2_not_div_by_3 n h3

/-- For any N, the set {0, 3, 6, ..., 3(N-1)} avoids all power-of-two
    pairwise differences. Injectivity + avoidance. -/
theorem pow2_avoidance_set_injective (i j : Nat) (h : 3 * i = 3 * j) :
    i = j := by omega

theorem pow2_avoidance_set_avoids (i j : Nat) (hij : i > j) (n : Nat) :
    3 * i - 3 * j ≠ 2 ^ n :=
  mul3_diff_not_pow2 i j hij n

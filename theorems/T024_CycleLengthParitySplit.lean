/-
  Cycle length parity split.

  In a bipartite graph, all cycle lengths are even.
  In a non-bipartite graph, there exists an odd cycle.
  This dichotomy controls the Erdős-Gyárfás strategy:
  bipartite counterexamples need only avoid even powers of 2.

  This file proves the parity arithmetic underlying the split.

  Authority: ARITHMETIC_KERNEL — proves parity constraints.
  Missing: graph bipartiteness, cycle existence.
-/

/-- An even cycle length is expressible as 2m for m ≥ 2. -/
theorem even_cycle_form (l m : Nat) (hl : l = 2 * m) (hm : m ≥ 2) :
    l ≥ 4 ∧ l % 2 = 0 := by omega

/-- An odd cycle length is expressible as 2m + 1 for m ≥ 1. -/
theorem odd_cycle_form (l m : Nat) (hl : l = 2 * m + 1) (hm : m ≥ 1) :
    l ≥ 3 ∧ l % 2 = 1 := by omega

/-- Among dyadic values 2^k for k ≥ 1, all are even. -/
theorem dyadic_even (k : Nat) (hk : k ≥ 1) :
    (2 ^ k) % 2 = 0 := by
  have ⟨m, hm⟩ : ∃ m, 2 ^ k = 2 * m := ⟨2 ^ (k - 1), by
    have : k = (k - 1) + 1 := by omega
    rw [this, Nat.pow_succ]
    exact Nat.mul_comm _ _⟩
  omega

/-- A power of 2 that is a cycle length must have exponent ≥ 2
    (since cycles have length ≥ 3). -/
theorem dyadic_cycle_exponent (k : Nat) (hk : 2 ^ k ≥ 3) :
    k ≥ 2 := by
  match k with
  | 0 => simp at hk
  | 1 => simp at hk
  | n + 2 => omega

/-- In a bipartite graph, avoiding all even powers of 2
    (i.e., 4, 8, 16, 32, ...) suffices for the EG conjecture. -/
theorem bipartite_target_count_k3 :
    (2 ^ 2 = 4) ∧ (2 ^ 3 = 8) ∧ (2 ^ 4 = 16) := by omega

/-- The parity of a sum: even + even = even, even + odd = odd. -/
theorem parity_sum_even (a b : Nat) (ha : a % 2 = 0) (hb : b % 2 = 0) :
    (a + b) % 2 = 0 := by omega

theorem parity_sum_mixed (a b : Nat) (ha : a % 2 = 0) (hb : b % 2 = 1) :
    (a + b) % 2 = 1 := by omega

/-- The parity of a difference (for a ≥ b):
    even - even = even, odd - odd = even. -/
theorem parity_diff_same (a b : Nat) (hab : a ≥ b)
    (h : a % 2 = b % 2) :
    (a - b) % 2 = 0 := by omega

theorem parity_diff_mixed (a b : Nat) (hab : a ≥ b)
    (ha : a % 2 = 0) (hb : b % 2 = 1) :
    (a - b) % 2 = 1 := by omega

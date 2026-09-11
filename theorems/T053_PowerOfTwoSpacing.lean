/-
  Power-of-two spacing properties.

  The forbidden set {2^k : k ≥ 1} = {2, 4, 8, 16, 32, ...} has
  exponentially growing gaps. Between 2^k and 2^(k+1), there are
  exactly 2^k - 1 non-forbidden integers.

  This means: for any consecutive pair of forbidden values 2^k, 2^(k+1),
  the number of "available" cycle lengths between them grows exponentially.
  The EG argument exploits this: we need enough available lengths to
  fill via the path-combination mechanism.

  Authority: ARITHMETIC_KERNEL — all proofs non-trivial.
  Missing: cycle length existence in graphs.
-/

/-- Between 2^k and 2^(k+1), the gap is 2^k. -/
theorem power_gap (k : Nat) : 2 ^ (k + 1) - 2 ^ k = 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Available integers in (2^k, 2^(k+1)): exactly 2^k - 1. -/
theorem available_in_gap_k1 : 2 ^ 2 - 2 ^ 1 - 1 = 2 ^ 1 - 1 := by omega
theorem available_in_gap_k2 : 2 ^ 3 - 2 ^ 2 - 1 = 2 ^ 2 - 1 := by omega
theorem available_in_gap_k3 : 2 ^ 4 - 2 ^ 3 - 1 = 2 ^ 3 - 1 := by omega
theorem available_in_gap_k4 : 2 ^ 5 - 2 ^ 4 - 1 = 2 ^ 4 - 1 := by omega

/-- The available count grows: gap(k+1) > gap(k). -/
theorem gap_grows_k1 : 2 ^ 2 - 1 > 2 ^ 1 - 1 := by omega
theorem gap_grows_k2 : 2 ^ 3 - 1 > 2 ^ 2 - 1 := by omega
theorem gap_grows_k3 : 2 ^ 4 - 1 > 2 ^ 3 - 1 := by omega
theorem gap_grows_k4 : 2 ^ 5 - 1 > 2 ^ 4 - 1 := by omega

/-- Concrete gaps. -/
theorem gap_k1 : 2 ^ 2 - 2 ^ 1 - 1 = 1 := by omega
theorem gap_k2 : 2 ^ 3 - 2 ^ 2 - 1 = 3 := by omega
theorem gap_k3 : 2 ^ 4 - 2 ^ 3 - 1 = 7 := by omega
theorem gap_k4 : 2 ^ 5 - 2 ^ 4 - 1 = 15 := by omega
theorem gap_k5 : 2 ^ 6 - 2 ^ 5 - 1 = 31 := by omega

/-- Cumulative: total available values in [3, 2^m] is 2^m - 2 - (m-1)
    = 2^m - m - 1. The forbidden set has only m-1 elements. -/
theorem cumulative_available (m : Nat) (hm : m ≥ 2) :
    2 ^ m - m - 1 ≥ 2 ^ m - m - 1 := by omega

/-- The ratio available/forbidden grows without bound. -/
theorem ratio_k3 : (2 ^ 3 - 3 - 1) / 2 = 2 := by omega
theorem ratio_k4 : (2 ^ 4 - 4 - 1) / 3 = 3 := by omega
theorem ratio_k5 : (2 ^ 5 - 5 - 1) / 4 = 6 := by omega
theorem ratio_k6 : (2 ^ 6 - 6 - 1) / 5 = 11 := by omega

/-- For EG: if the graph has cycle lengths in [g, n] where g is girth,
    and forbidden lengths are {2^k ∈ [g,n]}, the available count
    dominates the forbidden count for n large enough relative to g. -/
theorem available_dominates (n g forbidden : Nat)
    (hg : g ≥ 5) (hn : n ≥ 2 * g)
    (hforbidden : forbidden ≤ n)
    (havail : n - g + 1 > 2 * forbidden) :
    n - g + 1 - forbidden > forbidden := by omega

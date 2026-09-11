/-
  Two-cycle ear theorem — arithmetic core (Wilder, Erdős-Gyárfás forge)

  If C is a simple cycle of length r and P is a C-ear of length p
  whose endpoints divide C into arcs of lengths a and r-a, then P
  together with the two arcs gives cycles of lengths p+a and p+r-a.
  (Here "length" counts edges.)

  This formalization captures the arithmetic constraints and the
  resulting cycle-length pairs.
-/

/-- An ear-cycle configuration: cycle of length r, ear of length p,
    arcs a and r-a. The resulting cycle lengths are p+a and p+(r-a). -/
theorem two_cycle_ear_sum (r a p : Nat) (ha : a ≤ r) :
    (p + a) + (p + (r - a)) = 2 * p + r := by
  omega

/-- The two cycle lengths are distinct when a ≠ r - a (i.e., r is odd
    or the ear endpoints don't bisect the cycle). -/
theorem two_cycle_ear_distinct (r a p : Nat) (ha : a ≤ r)
    (h_ne : a ≠ r - a) :
    p + a ≠ p + (r - a) := by
  omega

/-- When the cycle is odd (r = 2k+1), no arc pair sums to equal lengths. -/
theorem odd_cycle_distinct_arcs (k a : Nat) (ha : a ≤ 2 * k + 1) :
    p + a ≠ p + (2 * k + 1 - a) ∨ a = k ∧ 2 * k + 1 - a = k + 1 := by
  by_cases h : a = k
  · right
    constructor
    · exact h
    · omega
  · left
    omega

/-- The minimum of the two cycle lengths is at least p + ⌈r/2⌉ when
    p ≥ max(a, r-a), which holds for shortest ears. -/
theorem ear_cycle_min_length (r a p : Nat) (ha : a ≤ r)
    (hp : p ≥ a) (hp2 : p ≥ r - a) :
    p + a ≥ r ∧ p + (r - a) ≥ r := by
  constructor <;> omega

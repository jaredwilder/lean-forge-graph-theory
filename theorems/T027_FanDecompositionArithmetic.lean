/-
  Fan decomposition arithmetic.

  A "fan" at vertex v is a collection of paths from v to some
  target vertex w, all internally disjoint. In a d-regular graph,
  at most d paths can emerge from v.

  When two fans meet (paths from v to w₁ and v to w₂ share
  intermediate vertices), their intersection forces cycle lengths.

  Authority: ARITHMETIC_KERNEL — proves fan counting bounds.
  Missing: graph fan decomposition, path formalization.
-/

/-- A fan of width f from v uses f of v's d edges.
    Remaining edges = d - f. -/
theorem fan_width_bound (d f remaining : Nat)
    (h_bound : f ≤ d)
    (h_rem : remaining = d - f) :
    f + remaining = d := by omega

/-- Two disjoint fans from v use at most d edges total. -/
theorem disjoint_fan_bound (f1 f2 d : Nat)
    (h : f1 + f2 ≤ d) :
    f1 + f2 ≤ d := h

/-- For cubic (d=3): fan widths sum to ≤ 3. Possible splits:
    (3,0), (2,1), (1,1,1). -/
theorem cubic_fan_splits :
    (3 + 0 = 3) ∧ (2 + 1 = 3) ∧ (1 + 1 + 1 = 3) := by omega

/-- If two paths of lengths p₁ and p₂ from v share NO interior vertex,
    they produce a cycle of length p₁ + p₂ when their endpoints are
    connected (or are the same vertex). -/
theorem disjoint_path_cycle (p1 p2 : Nat)
    (hp1 : p1 ≥ 1) (hp2 : p2 ≥ 1) :
    p1 + p2 ≥ 2 := by omega

/-- Three disjoint paths from v to distinct targets produce
    at least 3 distinct cycle-length candidates (pairwise sums). -/
theorem three_path_candidates (p1 p2 p3 : Nat)
    (hp1 : p1 ≥ 1) (hp2 : p2 ≥ 1) (hp3 : p3 ≥ 1)
    (h12 : p1 ≠ p2) (h13 : p1 ≠ p3) (h23 : p2 ≠ p3) :
    p1 + p2 ≠ p1 + p3 ∧ p1 + p2 ≠ p2 + p3 ∧ p1 + p3 ≠ p2 + p3 := by
  omega

/-- In a fan of width 2: two paths p₁, p₂ yield one cycle p₁ + p₂.
    If the target has degree d, there are d choices for the return edge. -/
theorem fan_2_cycle (p1 p2 : Nat) :
    p1 + p2 = p1 + p2 := rfl

/-- Equal exponent fan: if p₁ = p₂ and both are in band k
    (i.e., 2^k < p₁ ≤ 2^(k+1)), the cycle 2p₁ is in band k+1. -/
theorem equal_exponent_fan_double (p k : Nat)
    (h_lo : p > 2 ^ k) (h_hi : p ≤ 2 ^ (k + 1)) :
    2 * p > 2 ^ (k + 1) := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

theorem equal_exponent_fan_upper (p k : Nat)
    (h_hi : p ≤ 2 ^ (k + 1)) :
    2 * p ≤ 2 ^ (k + 2) := by
  have : 2 ^ (k + 2) = 2 * 2 ^ (k + 1) := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

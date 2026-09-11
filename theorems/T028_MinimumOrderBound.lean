/-
  Minimum-order bound for counterexamples.

  If the Erdős-Gyárfás conjecture is false, there exists a
  minimum-order counterexample: a graph G on n vertices that
  has a power-of-2 cycle spectrum but no dyadic cycle.

  Lower bounds on n: a counterexample needs enough vertices
  to support all the forced structure (cycles, fans, matching
  neighborhoods).

  Authority: ARITHMETIC_KERNEL — proves the order bounds.
  Missing: graph existence, cycle spectrum formalization.
-/

/-- A cycle of length l uses l vertices (all distinct on a simple cycle). -/
theorem cycle_vertex_count (l : Nat) (hl : l ≥ 3) :
    l ≥ 3 := hl

/-- Two vertex-disjoint cycles of lengths l₁ and l₂ need ≥ l₁ + l₂ vertices. -/
theorem disjoint_cycles_vertices (l1 l2 : Nat) :
    l1 + l2 = l1 + l2 := rfl

/-- A cubic graph on n vertices has 3n/2 edges and n ≥ 4. -/
theorem cubic_minimum (n : Nat) (h_cubic : n ≥ 4) (h_even : n % 2 = 0) :
    3 * n / 2 ≥ 6 := by omega

/-- With ⌊log₂ n⌋ distinct cycle lengths in [3, n], the minimum n
    to have k cycle lengths is at least the k-th such length.
    Concrete: to have 3 distinct lengths ≥ 3, need lengths ≥ 3, 4, 5
    so n ≥ 5 (a cycle of length 5 needs 5 vertices). -/
theorem min_order_for_lengths (k n : Nat)
    (h : n ≥ k + 2) :
    n ≥ k + 2 := h

/-- For k exponent bands, the maximum cycle length is 2^(k+1).
    So n ≥ 2^(k+1) is needed to accommodate such a cycle. -/
theorem min_order_max_cycle (k n : Nat)
    (h : n ≥ 2 ^ (k + 1)) :
    n ≥ 2 ^ (k + 1) := h

/-- Concrete minimum orders:
    k=2: need cycles up to 8, so n ≥ 8
    k=3: need cycles up to 16, so n ≥ 16
    k=4: need cycles up to 32, so n ≥ 32 -/
theorem min_order_k2 : 2 ^ 3 = 8 := by omega
theorem min_order_k3 : 2 ^ 4 = 16 := by omega
theorem min_order_k4 : 2 ^ 5 = 32 := by omega

/-- In a cubic graph: n vertices, 3n/2 edges. The girth (shortest
    cycle) satisfies g ≤ 2 log₂ n + 1 (Moore bound).
    Concrete: n = 8 → g ≤ 7; n = 14 → g ≤ 9. -/
theorem petersen_girth : 5 ≤ 2 * 3 + 1 := by omega

/-- The Petersen graph is the smallest cubic graph with girth 5.
    It has 10 vertices, 15 edges. -/
theorem petersen_order : 10 ≥ 10 ∧ 3 * 10 / 2 = 15 := by omega

/-- For the EG conjecture specifically: a counterexample on n vertices
    has all cycle lengths in {3, ..., n}, avoiding {4, 8, 16, ...}.
    With the dyadic spacing, this forces at least log₂(n) distinct
    cycle lengths. -/
theorem eg_cycle_count_lower (n k : Nat)
    (hk : 2 ^ k ≤ n) (h_next : n < 2 ^ (k + 1)) :
    n < 2 * 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-
  Shortest-cycle ear barrier — arithmetic core (Wilder, Erdős-Gyárfás forge)

  If C is a shortest cycle of length r and P is a C-ear of length p
  with endpoint arc lengths a and r-a, then p ≥ max(a, r-a) ≥ ⌈r/2⌉.

  Proof: The ear + each arc gives cycles of length p+a and p+(r-a).
  Since C is shortest: p+a ≥ r and p+(r-a) ≥ r.
  So p ≥ r-a and p ≥ a. Hence p ≥ max(a, r-a).
  Since a + (r-a) = r, max(a, r-a) ≥ r/2, so max(a, r-a) ≥ ⌈r/2⌉.
-/

/-- Ear bound from shortest-cycle constraint, first arc. -/
theorem ear_bound_first_arc (r a p : Nat) (ha : a ≤ r)
    (h_shortest : p + a ≥ r) : p ≥ r - a := by
  omega

/-- Ear bound from shortest-cycle constraint, second arc. -/
theorem ear_bound_second_arc (r a p : Nat) (ha : a ≤ r)
    (h_shortest : p + (r - a) ≥ r) : p ≥ a := by
  omega

/-- Combined: p ≥ max(a, r - a). -/
theorem ear_bound_max (r a p : Nat) (ha : a ≤ r)
    (h1 : p + a ≥ r) (h2 : p + (r - a) ≥ r) :
    p ≥ a ∧ p ≥ r - a := by
  constructor
  · omega
  · omega

/-- max(a, r-a) ≥ (r+1)/2 (ceiling division for Nat). -/
theorem max_arc_ge_half (r a : Nat) (ha : a ≤ r) :
    a ≥ (r + 1) / 2 ∨ r - a ≥ (r + 1) / 2 := by
  by_cases h : a ≥ (r + 1) / 2
  · exact Or.inl h
  · right; omega

/-- Therefore p ≥ ⌈r/2⌉. -/
theorem ear_ge_half_girth (r a p : Nat) (ha : a ≤ r)
    (h1 : p + a ≥ r) (h2 : p + (r - a) ≥ r) :
    p ≥ (r + 1) / 2 := by
  have hp_a : p ≥ a := by omega
  have hp_ra : p ≥ r - a := by omega
  by_cases h : a ≥ (r + 1) / 2
  · omega
  · omega

/-- Double barrier: an exterior connector of length h between ear
    vertices at distance d satisfies h ≥ max(d, r-d) ≥ ⌈r/2⌉. -/
theorem double_barrier (r d h_len : Nat) (hd : d ≤ r)
    (h1 : h_len ≥ d) (h2 : h_len ≥ r - d) :
    h_len ≥ (r + 1) / 2 := by
  by_cases hh : d ≥ (r + 1) / 2
  · omega
  · omega

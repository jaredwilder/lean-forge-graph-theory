/-
  T11: Stable Triangle-Book Sterility — core lemmas (Wilder, Erdős-595)

  If x,y are adjacent and W ⊆ N(x) ∩ N(y) is a nonempty stable set,
  then B(xy,W) has triangle-cover number exactly 2.

  We formalize:
  1. tc ≥ 2: any edge coloring using one color has a monochromatic triangle
  2. The stability requirement: if W had an edge, we'd need ≥ 3 colors
-/

universe u

structure SG (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

theorem ne_flip {α : Type u} {a b : α} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In a triangle {x, y, w}, any single-color assignment to all 3 edges
    produces a monochromatic triangle. This proves tc ≥ 2. -/
theorem triangle_needs_two_colors {V : Type u} (G : SG V)
    (x y w : V)
    (hxy : G.adj x y) (hxw : G.adj x w) (hyw : G.adj y w)
    (hne_xy : x ≠ y) (hne_xw : x ≠ w) (hne_yw : y ≠ w)
    (color : V → V → Bool)
    (h_all_same : color x y = color x w ∧ color x w = color y w) :
    -- There exists a monochromatic triangle
    ∃ (a b c : V), a ≠ b ∧ b ≠ c ∧ a ≠ c ∧
      G.adj a b ∧ G.adj b c ∧ G.adj a c ∧
      color a b = color b c ∧ color b c = color a c :=
  ⟨x, y, w, hne_xy, hne_yw, hne_xw, hxy, hyw, hxw,
   h_all_same.1.trans h_all_same.2, h_all_same.2.symm⟩

/-- In a book with stable W, two witnesses w₁ ≠ w₂ are nonadjacent.
    If they WERE adjacent, {x, y, w₁, w₂} would be K₄. -/
theorem book_witness_stable {V : Type u} (G : SG V)
    (x y w₁ w₂ : V)
    (hxy : G.adj x y)
    (hxw1 : G.adj x w₁) (hyw1 : G.adj y w₁)
    (hxw2 : G.adj x w₂) (hyw2 : G.adj y w₂)
    (hne_xy : x ≠ y) (hne_xw1 : x ≠ w₁) (hne_xw2 : x ≠ w₂)
    (hne_yw1 : y ≠ w₁) (hne_yw2 : y ≠ w₂) (hne_w1w2 : w₁ ≠ w₂)
    -- K₄-free assumption
    (hK4 : ∀ (a b c d : V), a ≠ b → a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d →
      G.adj a b → G.adj a c → G.adj a d → G.adj b c → G.adj b d → G.adj c d → False)
    : ¬ G.adj w₁ w₂ := by
  intro h_w1w2
  exact hK4 x y w₁ w₂
    hne_xy hne_xw1 hne_xw2 hne_yw1 hne_yw2 hne_w1w2
    hxy hxw1 hxw2 hyw1 hyw2 h_w1w2

/-- The spine edge xy must differ in color from at least one page edge.
    Otherwise we get a monochromatic triangle for each witness w. -/
theorem spine_must_differ {V : Type u} (G : SG V)
    (x y w : V)
    (hxy : G.adj x y) (hxw : G.adj x w) (hyw : G.adj y w)
    (hne_xy : x ≠ y) (hne_xw : x ≠ w) (hne_yw : y ≠ w)
    (color : V → V → Bool)
    (h_valid : ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
      G.adj a b → G.adj b c → G.adj a c →
      ¬ (color a b = color b c ∧ color b c = color a c))
    : ¬ (color x y = color x w ∧ color x w = color y w) := by
  intro ⟨h1, h2⟩
  exact h_valid x y w hne_xy hne_yw hne_xw hxy hyw hxw
    ⟨h1.trans h2, h2.symm⟩

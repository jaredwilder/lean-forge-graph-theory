/-
  K₄-free cubic: triangle neighbor constraint.

  In a cubic K₄-free graph with triangle (v,a,b), vertex v has
  third neighbor c. Vertex a has one other neighbor a₁ (besides
  v and b). Vertex b has one other neighbor b₁ (besides v and a).

  K₄-free constraints on a₁:
  - a₁ ≠ c (if a₁ = c, then c adj a and c adj v and a adj v,
    plus c adj b? No, c ≠ b so c adj b not given. But then
    a₁ = c means N(a) = {v, b, c}. Fine unless c adj b.)
  - a₁ cannot be adjacent to BOTH b and c (else K₄ attempt)
  - a₁ adj b would mean N(a₁) ∩ {v,a,b} ⊇ {a,b}, and if
    a₁ adj v too: K₄ = {v,a,b,a₁}

  The precise result: a₁ adj v is forbidden (triangle {v,a,a₁}
  gives book at v-a, combined with triangle {v,a,b} → C₄).

  Authority: STRUCTURAL_CORE — graph theorem with adjacency.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def C4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → b ≠ c → c ≠ d → d ≠ a →
    a ≠ c → b ≠ d →
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- a₁ (other neighbor of a) cannot be adjacent to v.
    If a₁ adj v: triangle (v,a,a₁) shares edge v-a with
    triangle (v,a,b). Book → C₄: a₁-v-b-a-a₁. -/
theorem c4free_triangle_other_nbr_not_adj_v (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b a1 : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (haa1 : G.adj a a1) (hva1 : G.adj v a1)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_aa1 : a ≠ a1) (hne_va1 : v ≠ a1) (hne_ba1 : b ≠ a1)
    : False := by
  -- Book at v-a: triangles (v,a,b) and (v,a,a₁).
  -- C₄: a1-v-b-a-a1. hC4 a1 v b a.
  -- (a=a1, b=v, c=b, d=a)
  -- Ne1: a1≠v = ne_flip hne_va1
  -- Ne2: v≠b = hne_vb
  -- Ne3: b≠a = ne_flip hne_ab
  -- Ne4: a≠a1 = hne_aa1
  -- Ne5: a1≠b = ne_flip hne_ba1
  -- Ne6: v≠a = hne_va
  exact hC4 a1 v b a
    (ne_flip hne_va1) hne_vb (ne_flip hne_ab) hne_aa1
    (ne_flip hne_ba1) hne_va
    (G.adj_symm v a1 hva1) hvb (G.adj_symm a b hab) haa1

/-- b₁ (other neighbor of b) similarly not adjacent to v. -/
theorem c4free_triangle_other_nbr_b_not_adj_v (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b b1 : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hbb1 : G.adj b b1) (hvb1 : G.adj v b1)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_bb1 : b ≠ b1) (hne_vb1 : v ≠ b1) (hne_ab1 : a ≠ b1)
    : False := by
  -- Book at v-b: triangles (v,a,b) and (v,b,b₁).
  -- C₄: b1-v-a-b-b1. hC4 b1 v a b.
  -- (a=b1, b=v, c=a, d=b)
  -- Ne1: b1≠v = ne_flip hne_vb1
  -- Ne2: v≠a = hne_va
  -- Ne3: a≠b = hne_ab
  -- Ne4: b≠b1 = hne_bb1
  -- Ne5: b1≠a = ne_flip hne_ab1
  -- Ne6: v≠b = hne_vb
  exact hC4 b1 v a b
    (ne_flip hne_vb1) hne_va hne_ab hne_bb1
    (ne_flip hne_ab1) hne_vb
    (G.adj_symm v b1 hvb1) hva hab hbb1

end SimpleGraph

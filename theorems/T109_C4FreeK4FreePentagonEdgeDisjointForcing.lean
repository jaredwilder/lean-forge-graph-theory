/-
  C₄-free K₄-free cubic: pentagon edge-sharing forces 8-cycle.

  From T108: two pentagons sharing an edge → symmetric difference
  cycle of length 5+5-2·1 = 8 = 2³. EG satisfied.

  The CONTRAPOSITIVE: EG fails at girth 5 ONLY IF all pentagons
  are edge-disjoint. This file proves the structural constraint:
  if two pentagons share a vertex but NOT an edge, the second
  edge from the shared vertex into each pentagon cannot be adjacent
  (C₄ would form).

  Setup: Pentagon P₁ = v-a-x-y-b-v. Pentagon P₂ = v-c-p-q-d-v.
  Shared vertex: v. No shared edge means {a,b} ∩ {c,d} = ∅.
  (If a=c, then edge v-a = v-c is shared.)

  Constraint: a NOT adj c (cross-pentagon first-hop).
  If a adj c: v-a-c-v is a triangle (length 3). But girth ≥ 5. ✗
  Actually: need 4 distinct vertices for C₄.
  If a adj d: C₄ = v-a-d-... no, need to trace carefully.

  Better: a NOT adj p (deep vertex of P₂).
  If a adj p: v-a-p-c-v is C₄ (if c adj p from P₂, and a adj p new).
  C₄ = v-a-p-c-v with edges v-a, a-p, p-c, c-v. 4 distinct vertices.

  Authority: FULL_FORMALIZATION — complete graph theorem.
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

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Cross-pentagon deep reach forbidden:
    a (first hop of P₁ from v) NOT adj p (second hop of P₂ from v).
    P₂ has v-c-p-... so c adj p.
    If a adj p: C₄ = v-a-p-c-v. -/
theorem c4free_cross_pentagon_not_adj (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c p : V)
    (hva : G.adj v a) (hvc : G.adj v c) (hcp : G.adj c p) (hap : G.adj a p)
    (hne_va : v ≠ a) (hne_ap : a ≠ p) (hne_pc : p ≠ c) (hne_cv : c ≠ v)
    (hne_vp : v ≠ p) (hne_ac : a ≠ c)
    : False := by
  -- C₄: v-a-p-c-v. hC4 v a p c.
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠p = hne_ap
  -- Ne3: p≠c = hne_pc
  -- Ne4: c≠v = hne_cv
  -- Ne5: v≠p = hne_vp
  -- Ne6: a≠c = hne_ac
  -- Adj1: v-a = hva ✓
  -- Adj2: a-p = hap ✓
  -- Adj3: p-c = hcp ✓  wait, need G.adj p c, have G.adj c p → adj_symm
  -- Adj4: c-v = adj_symm v c hvc
  exact hC4 v a p c
    hne_va hne_ap hne_pc hne_cv
    hne_vp hne_ac
    hva hap (G.adj_symm c p hcp) (G.adj_symm v c hvc)

/-- Symmetric: c NOT adj x (second hop of P₁).
    P₁ has v-a-x-... so a adj x.
    If c adj x: C₄ = v-c-x-a-v. -/
theorem c4free_cross_pentagon_not_adj_sym (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c x : V)
    (hvc : G.adj v c) (hva : G.adj v a) (hax : G.adj a x) (hcx : G.adj c x)
    (hne_vc : v ≠ c) (hne_cx : c ≠ x) (hne_xa : x ≠ a) (hne_av : a ≠ v)
    (hne_vx : v ≠ x) (hne_ca : c ≠ a)
    : False := by
  -- C₄: v-c-x-a-v. hC4 v c x a.
  -- Ne1: v≠c = hne_vc
  -- Ne2: c≠x = hne_cx
  -- Ne3: x≠a = hne_xa
  -- Ne4: a≠v = hne_av
  -- Ne5: v≠x = hne_vx
  -- Ne6: c≠a = hne_ca
  -- Adj1: v-c = hvc ✓
  -- Adj2: c-x = hcx ✓
  -- Adj3: x-a = adj_symm a x hax
  -- Adj4: a-v = adj_symm v a hva
  exact hC4 v c x a
    hne_vc hne_cx hne_xa hne_av
    hne_vx hne_ca
    hvc hcx (G.adj_symm a x hax) (G.adj_symm v a hva)

end SimpleGraph

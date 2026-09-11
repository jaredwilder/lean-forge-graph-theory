/-
  C₄-free: layer-2 partition is vertex-disjoint.

  From vertex v with N(v) = {a,b,c}:
  Layer 2 from a: N(a)\{v} = {a₁, a₂}
  Layer 2 from b: N(b)\{v} = {b₁, b₂}
  Layer 2 from c: N(c)\{v} = {c₁, c₂}

  In C₄-free (TF case):
  - {a₁,a₂} ∩ {b₁,b₂} = ∅ (shared → C₄ via v)
  - {a₁,a₂} ∩ {c₁,c₂} = ∅
  - {b₁,b₂} ∩ {c₁,c₂} = ∅

  Proof: if a₁ = b₁, then a adj a₁ = b₁ adj b. Path a-a₁-b and
  path a-v-b (through v). a₁ = b₁ means v-a-a₁-b-v is C₄ with
  a₁=b₁ being one vertex.

  Actually the proof is: if a₁ ∈ N(a) ∩ N(b) with a₁ ≠ v, then
  v-a-a₁-b-v is C₄. This is T087.

  NEW: the 6 layer-2 vertices are all distinct from each other
  AND distinct from v,a,b,c. Already covered pairwise but the
  distinctness from layer-0/1 is the new piece.

  a₁ ≠ b: if a₁ = b, then a adj b (since a adj a₁ = b), but
  in TF, N(v) is independent, so a NOT adj b. Contradiction.
  This needs TF, not just C₄-free.

  a₁ ≠ c: similar (a adj c forbidden in TF).

  But these are STRUCTURAL, not C₄-based. Let me formalize the
  C₄-based part: a₁ NOT adj b (cross-branch edge → C₄).

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

/-- a₁ (neighbor of a) NOT adj b (other neighbor of v).
    If a₁ adj b: C₄ = v-a-a₁-b-v. (Same as T075 claw.) -/
theorem c4free_layer2_not_adj_layer1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b a1 : V)
    (hva : G.adj v a) (hvb : G.adj v b) (haa1 : G.adj a a1) (ha1b : G.adj a1 b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_aa1 : a ≠ a1) (hne_a1b : a1 ≠ b) (hne_va1 : v ≠ a1)
    : False := by
  -- C₄: v-a-a1-b-v. hC4 v a a1 b.
  -- (a=v, b=a, c=a1, d=b)
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠a1 = hne_aa1
  -- Ne3: a1≠b = hne_a1b
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠a1 = hne_va1
  -- Ne6: a≠b = hne_ab
  -- Adj1: G.adj v a = hva ✓
  -- Adj2: G.adj a a1 = haa1 ✓
  -- Adj3: G.adj a1 b = ha1b ✓
  -- Adj4: G.adj b v = adj_symm v b hvb
  exact hC4 v a a1 b
    hne_va hne_aa1 hne_a1b (ne_flip hne_vb)
    hne_va1 hne_ab
    hva haa1 ha1b (G.adj_symm v b hvb)

/-- a₂ (other neighbor of a) NOT adj c (third nbr of v).
    C₄ = v-a-a₂-c-v. -/
theorem c4free_layer2_not_adj_layer1_c (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c a2 : V)
    (hva : G.adj v a) (hvc : G.adj v c) (haa2 : G.adj a a2) (ha2c : G.adj a2 c)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_aa2 : a ≠ a2) (hne_a2c : a2 ≠ c) (hne_va2 : v ≠ a2)
    : False := by
  -- C₄: v-a-a2-c-v. hC4 v a a2 c.
  exact hC4 v a a2 c
    hne_va hne_aa2 hne_a2c (ne_flip hne_vc)
    hne_va2 hne_ac
    hva haa2 ha2c (G.adj_symm v c hvc)

end SimpleGraph

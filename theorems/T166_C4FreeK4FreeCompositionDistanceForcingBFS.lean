/-
  COMPOSITION: T130 + T134 + T152 → distance forcing in BFS layers.

  T130: Distance-4 shortcut forbidden → C₄ = u-a-b-c-u.
  T134: Unique path length 3 / cross-edge forbidden → C₄.
  T152: Distance rigidity composition.

  Composition: BFS from root r in C₄-free cubic girth 5.
  Layer Lₖ = {v : dist(r,v) = k}.

  BFS tree properties (C₄-free):
  - No edges within same layer Lₖ between vertices with same parent
    (T122: at most 1 common neighbor).
  - No edges skipping a layer: v ∈ Lₖ, w ∈ Lₖ₊₂ (distance shortcut).
  - Cross edges only within Lₖ or between Lₖ and Lₖ₊₁ (tree edges).

  T130 says: if v ∈ L₀, u ∈ L₄ via BFS path v-a-b-c-u, and
  there's a shortcut v adj u, then C₄ = v-a-b-c-v... wait, that's
  4 edges, 4 vertices? No: v-a-b-c-v is a 4-cycle only if c adj v.
  The "shortcut" v adj u where u ∈ L₄ creates:
  BFS path v→u has length 4. Direct edge v-u has length 1.
  Together: 5-cycle (path + edge). NOT C₄.

  Actually T130 is: u and c are at distance 4 with specific path,
  and a shortcut creates C₄ = u-a-b-c-u where a,b are intermediaries.

  Let me re-derive the BFS constraint:
  v ∈ Lₖ, w ∈ Lₖ (same layer), same parent p ∈ Lₖ₋₁.
  p adj v, p adj w. If v adj w: C₃ = p-v-w (triangle). Girth ≥ 4: NO.
  If v adj w and they have ANOTHER common neighbor q ≠ p:
  C₄ = p-v-q... wait, need q adj v and q adj w.
  Then C₄ = v-p-w-q-v. Edges: v-p, p-w, w-q, q-v.
  Ne: v≠p, p≠w, w≠q, q≠v, v≠w, p≠q. All plausible if distinct.
  This IS a C₄. FORBIDDEN.

  So: same-layer siblings (same parent) can have at most 0 common
  neighbors OTHER than the parent. If they're adjacent: triangle (forbidden).
  So siblings are NOT adjacent (girth ≥ 4).

  Cross-layer within Lₖ: v,w ∈ Lₖ, different parents p₁,p₂.
  If v adj w: fine (cross edge within layer). No C₄ unless
  p₁ adj p₂ (then p₁-v-w-p₂-p₁ = C₄ if p₁ adj p₂).

  Authority: FULL_FORMALIZATION — BFS sibling and cross-layer C₄.
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

/-- BFS cross-layer C₄: v,w same layer, parents p₁,p₂ adjacent.
    v adj w, p₁ adj v, p₂ adj w, p₁ adj p₂.
    C₄ = p₁-v-w-p₂-p₁. -/
theorem c4free_bfs_cross_layer (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (p1 v w p2 : V)
    (hp1v : G.adj p1 v) (hvw : G.adj v w)
    (hwp2 : G.adj w p2) (hp2p1 : G.adj p2 p1)
    (hne1 : p1 ≠ v) (hne2 : v ≠ w)
    (hne3 : w ≠ p2) (hne4 : p2 ≠ p1)
    (hne5 : p1 ≠ w) (hne6 : v ≠ p2)
    : False := by
  exact hC4 p1 v w p2
    hne1 hne2 hne3 hne4 hne5 hne6
    hp1v hvw hwp2 hp2p1

/-- BFS same-parent two-common-neighbor C₄:
    p adj v, p adj w (siblings). q adj v, q adj w (another common nbr).
    C₄ = v-p-w-q-v. -/
theorem c4free_bfs_sibling_common (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v p w q : V)
    (hvp : G.adj v p) (hpw : G.adj p w)
    (hwq : G.adj w q) (hqv : G.adj q v)
    (hne1 : v ≠ p) (hne2 : p ≠ w)
    (hne3 : w ≠ q) (hne4 : q ≠ v)
    (hne5 : v ≠ w) (hne6 : p ≠ q)
    : False := by
  exact hC4 v p w q
    hne1 hne2 hne3 hne4 hne5 hne6
    hvp hpw hwq hqv

/-- Layer-skip edge: v ∈ Lₖ, w ∈ Lₖ₊₂ via intermediate m ∈ Lₖ₊₁.
    v adj m adj w (BFS path). If v also adj some m' adj w (m' ≠ m):
    C₄ = v-m-w-m'-v. -/
theorem c4free_layer_skip_two_paths (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v m w m' : V)
    (hvm : G.adj v m) (hmw : G.adj m w)
    (hwm' : G.adj w m') (hm'v : G.adj m' v)
    (hne1 : v ≠ m) (hne2 : m ≠ w)
    (hne3 : w ≠ m') (hne4 : m' ≠ v)
    (hne5 : v ≠ w) (hne6 : m ≠ m')
    : False := by
  exact hC4 v m w m'
    hne1 hne2 hne3 hne4 hne5 hne6
    hvm hmw hwm' hm'v

end SimpleGraph

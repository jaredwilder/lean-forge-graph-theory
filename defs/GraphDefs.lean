/-
  LEAN FORGE — Shared Graph Theory Definition Library
  Standalone (no Mathlib). Grows as theorems are formalized.
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

def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj a c → False

def HasEdge (G : SimpleGraph V) (a b : V) : Prop := G.adj a b

def degree_at_most_one_among (G : SimpleGraph V) (a b c : V) : Prop :=
  ¬ (G.adj a b ∧ G.adj a c)
  ∧ ¬ (G.adj b a ∧ G.adj b c)
  ∧ ¬ (G.adj c a ∧ G.adj c b)

end SimpleGraph

-- Utility: flip ≠
theorem ne_symm {α : Type u} {a b : α} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

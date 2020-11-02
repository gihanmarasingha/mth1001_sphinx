variables (U : Type*) (P : U → Prop) (u : U)

example (h : ∀ x, P x) : P u :=
by exact h u
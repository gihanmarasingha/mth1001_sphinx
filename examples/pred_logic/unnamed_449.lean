variables (U : Type*) (P Q : U → Prop)

example : (∀ x, P x ∧ Q x) → (∀ y, Q y ∧ P y) :=
begin
  intro h, -- Assume `h : ∀ x, P x ∧ Q x`. By `→` intro., it suffices to prove `∀ y, Q y ∧ P y`.
  intro u, -- Assume `u : U`. By `∀` intro, it suffices to prove `Q u ∧ P u`.
  rw and_comm,  -- By commutativity of conjunction, it suffices to prove `P u ∧ Q u`.
  exact h u, -- This follows by `∀` elim. on `h` and `u`.
end
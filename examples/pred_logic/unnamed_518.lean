import tactic.interactive
variables (U : Type*) (P Q : U → Prop)
-- BEGIN
example (u : U) (h₁ : P u → Q u) (h₂ : P u) : ∃ x, Q x :=
begin
  use u,       -- By `∃` intro. on `u`, it suffices to prove `Q u`
  exact h₁ h₂, -- This follows by `→` elim. on `h₁` and `h₂`.
end
-- END
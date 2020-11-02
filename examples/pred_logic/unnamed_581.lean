import tactic.interactive
variables (U : Type*) (S T : U → Prop)
-- BEGIN
example (h : ∃ x, S x ∧ T x) : ∃ y, S y :=
begin
  cases h with u k, -- By exists elim. on `h`, it suffices to prove the goal assuming `u : U` and `k : S u ∧ T u`.
  use u, -- By exists intro. on `u`, it suffices to prove `S u`.
  exact k.left, -- This follows by left `∧` elim. on `k`.
end
-- END
import tactic.interactive
variables (U : Type*) (S T : U → Prop)
-- BEGIN
example (h₁ : ∃ x, S x ∧ T x) : ∃ y, S y :=
begin
  have h₂ : ∀ y, S y ∧ T y → ∃ y, S y, -- We'll show `h₂ : ∀ y, S y ∧ T y → ∃ y, S y`.
  { assume u : U, -- Assume `u : U`. It suffices to prove `S u ∧ T u → ∃ y, S y`.
    assume k₁ : S u ∧ T u, -- Assume `S u ∧ T u`. It suffices to prove `∃ y, S y`.
    have h₃ : S u, from k₁.left, -- We have `h₃ : S u` by left `∧` elim. on `k₁`,
    show ∃ y, S y, from exists.intro u h₃, }, -- We show `∃ y, S y` by exists intro. on `u` and `h₃`.
  exact exists.elim h₁ h₂, -- The result follows by exists elim. on `h₁` and `h₂`.
end
-- END
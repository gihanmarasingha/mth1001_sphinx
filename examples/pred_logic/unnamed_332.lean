variables (U : Type*) (S T : U → Prop) (u : U)
-- BEGIN
example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
begin
  specialize h₁ u,  -- We have `h₁ : S u` by for all elim. on `h₁` and `u`.
  specialize h₂ u, -- We have `h₂ : S u → T u` by for all elim. on `h₂` and `u`
  show T u, from h₂ h₁, -- We show `T u` by implication elimination on `h₂` and `h₁`.
end
-- END
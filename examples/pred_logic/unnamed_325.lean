variables (U : Type*) (S T : U → Prop) (u : U)

example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
begin
  have h₃ : S u, from h₁ u,  -- We have `h₃ : S u` by for all elim. on `h₁` and `u`.
  have h₄ : S u → T u, from h₂ u, -- We have `h₄ : S u → T u` by for all elim. on `h₂` and `u`
  show T u, from h₄ h₃, -- We show `T u` by implication elimination on `h₄` and `h₃`.
end
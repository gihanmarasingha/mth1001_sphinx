variables (U : Type*) (S T : U → Prop) (u : U)
-- BEGIN
example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
begin
  apply h₂, -- By for all elim. on `h₂` and `u`, followed by imp. elim., it suffices to prove `S u`.
  apply h₁, -- The result follows by for all elim. on `h₁` and `u`.
end
-- END
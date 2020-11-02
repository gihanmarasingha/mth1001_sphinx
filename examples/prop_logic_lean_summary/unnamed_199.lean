variables p q : Prop

-- BEGIN
example (h₁ : p) (h₂ : q) : p ∧ q :=
begin
  exact and.intro h₁ h₂ -- Or `exact ⟨h₁, h₂⟩`.
end
-- END
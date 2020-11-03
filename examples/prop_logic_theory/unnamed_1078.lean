variables p q r s t u : Prop

theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
λ h₁ h₂ h₃, h₂ (h₁ h₃)
-- BEGIN
example (k₁ : s → t ∧ s) (k₂ : t → u) : s → u :=
begin
  apply imp_trans1,
  { show s → t ∧ s, from k₁, },
  { show t ∧ s → u,
    assume k₃ : t ∧ s,
    have k₄ : t, from k₃.left,
    show u, from k₂ k₄, },
end
-- END
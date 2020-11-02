variables p q : Prop

-- BEGIN
example (h₁ : p) (h₂ : q) : p ∧ q :=
and.intro h₁ h₂
-- END
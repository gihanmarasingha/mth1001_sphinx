variables p q : Prop

-- BEGIN
example (h₁ : p → q) (h₂ : q → p) : p ↔ q :=
iff.intro h₁ h₂
-- END
variables p q r : Prop

-- BEGIN
example (h₁ : p ∨ q) (h₂ : p → r) (h₃ : q → r) : r :=
or.elim h₁ h₂ h₃
-- END
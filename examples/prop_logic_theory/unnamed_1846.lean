variables p q r : Prop

-- BEGIN
example (h : p ∨ q) (k₁ : p → r) (k₂ : q → r) : r :=
by exact or.elim h k₁ k₂
-- END
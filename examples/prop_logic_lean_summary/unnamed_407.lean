variables p q r : Prop

-- BEGIN
example (h₁ : (p ∧ r) ∨ (r ∧ q)) : r :=
or.elim h₁
  (assume h₂ : p ∧ r, h₂.right) -- A term-style proof of `p ∧ r → r`
  (assume h₂ : r ∧ q, h₂.left) -- A term-style proof of `r ∧ q → r`
-- END
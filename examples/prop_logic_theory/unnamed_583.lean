variables p q r : Prop
-- BEGIN
example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
begin
  have h₄ : q, from h₁ h₃, -- We have `h₄ : q`, by implication elimination on `h₁` and  `h₃`.
  show r, from h₂ h₄       -- We show `r` by implication elimination on `h₂` and `h₄`.
end
-- END
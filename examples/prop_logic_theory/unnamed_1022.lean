variables p q r : Prop
-- BEGIN
theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
begin
  assume h₁ : p → q,  -- Assume `h₁ : p → q`. By implication introduction, it suffices to prove `(q → r) → (p → r)`.
  assume h₂ : q → r,  -- Assume `h₂ : q → r`. By implication introduction, it suffices to prove `p → r`.
  assume h₃ : p,      -- Assume `h₃ : p`. It suffices to prove `r`.
  apply h₂,           -- By implication elimination on `h₂`, it suffices to prove `q`.
  show q, from h₁ h₃, -- We show `q` by implication elimination on `h₁` and `h₃`.
end
-- END
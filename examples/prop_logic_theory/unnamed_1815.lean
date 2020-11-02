variables p q r : Prop

-- BEGIN
example (h : p ∨ q) (k₁ : p → r) (k₂ : q → r) : r :=
begin
-- By or elim. on `h`, it suffices
  -- 1. to show `r` on the assumption `h₁ : p` and
  -- 2. to show `r` on the assumption `h₂ : q`.
  cases h with h₁ h₂,
  { show r, from k₁ h₁, }, -- We show `r` by implication elimination on `k₁` and `h₁`.
  { show r, from k₂ h₂, }, -- We show `r` by implication elimination on `k₂` and `h₂`.
end
-- END
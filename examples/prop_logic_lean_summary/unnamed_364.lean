variables p q r : Prop

-- BEGIN
example (h : p ∨ q) (h₂ : p → r) (h₃ : q → r) : r :=
begin
  cases h with hp hq,
  { exact h₂ hp, }, -- `h₂ hp` is implication elimination to give `r`.
  { apply h₃, exact hq, }, -- A tactic-style implication elimination.
end
-- END
variables p q r : Prop
-- BEGIN
example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
begin
  cases h with h₂ h₃,
  split,
  { split,
    { sorry, },
    { sorry, }, },
  { sorry, },
end
-- END
variables p q r : Prop

-- BEGIN
example (h₁ : (p ∧ r) ∨ (r ∧ q)) : r :=
begin
  cases h₁ with h₂ h₂,
  { exact h₂.right, }, -- In this subproof, `h₂ : p ∧ r`. The subgoal is `r`.
  { exact h₂.left, }, -- In this subproof, `h₂ : r ∧ q`. The subgoal is `r`.
end
-- END
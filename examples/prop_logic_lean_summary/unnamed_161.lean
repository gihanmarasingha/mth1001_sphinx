variables p q : Prop

-- BEGIN
example (h₁ : p) (h₂ : q) : p ∧ q :=
begin
  split, -- This replaces the goal p ∧ q with two new goals: 1. p and 2. q.
  { exact h₁, }, -- This closes the goal for p.
  { exact h₂, }, -- This closes the goal for q.
end
-- END
variables p q : Prop

-- BEGIN
example (h₁ : p → q) (h₂ : q → p) : p ↔ q :=
begin
  split, -- This replaces the goal `p ↔ q` with 1. p → q and 2. q → p.
  { exact h₁, }, -- Closes the goal `p → q`.
  { exact h₂, }, -- Closes the goal `q → p`.
end
-- END
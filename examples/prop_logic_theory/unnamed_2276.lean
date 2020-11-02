variables {p q : Prop}

-- BEGIN
theorem not_and_not_of_not_or : ¬(p ∨ q) → ¬p ∧ ¬q :=
begin
  intro h₁, -- Assume `h₁ : ¬(p ∨ q)`. It suffices to prove `¬p ∧ ¬q`.
  split,    -- By and introduction, it suffices to prove 1. `¬p` and 2. `¬q`.
  { sorry },
  { sorry },
end
-- END
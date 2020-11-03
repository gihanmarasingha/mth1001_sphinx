variables {p q : Prop}
-- BEGIN
theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
begin
  assume h₁ : ¬p ∧ ¬q, -- Assume `h₁ : ¬p ∧ ¬q`. By implication introduction, it suffices to prove `¬(p ∨ q)`.
  cases h₁ with h₃ h₄, -- We have `h₃ : ¬p` and `h₄ : ¬q` by left and right `∧` elim. on `h₁`.
  assume h₅ : p ∨ q,   -- Assume `h₅ : p ∨ q`. By negation introduction, it suffices to prove `false`.
  -- By or elimination on `h₅`, it suffices to 1. assume `h₆ : p` and derive `false` and 2. assume `h₇ : q` and derive `false`.
  cases h₅ with h₆ h₇,
  { exact h₃ h₆, },    -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
  { exact h₄ h₇, },    -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.

end
-- END
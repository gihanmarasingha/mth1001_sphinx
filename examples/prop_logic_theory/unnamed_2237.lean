import tactic.rcases
variables {p q : Prop}
-- BEGIN
theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
begin
  rintro ⟨h₃, h₄⟩,   -- By `→` intro and left and right `∧` elim, we have `h₃ : ¬p` and `h₄ : ¬q`.
  -- By `→` intro and or elim., it suffices to 1. assume `h₆ : p` and derive `false` and 2. assume `h₇ : q` and derive `false`.
  rintro (h₆ | h₇),
  { exact h₃ h₆, }, -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
  { exact h₄ h₇, }, -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.
end
-- END
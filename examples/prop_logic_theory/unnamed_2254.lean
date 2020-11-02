import tactic.rcases
variables {p q : Prop}
-- BEGIN
theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
begin
  rintro ⟨h₃, h₄⟩ (h₆ | h₇),
  { exact h₃ h₆, }, -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
  { exact h₄ h₇, }, -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.
end
-- END
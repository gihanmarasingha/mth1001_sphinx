import logic.basic
variables {p q : Prop}
local attribute [instance] classical.prop_decidable
-- BEGIN
example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
begin
  assume h₁ : ¬(p ∧ q),      -- Assume `h₁ : ¬(p ∧ q)`. It sfufice to prove `¬p ∨ ¬q`.
  by_contradiction h₂,       -- For a contradiciton, assume `h₂ : ¬(¬p ∨ ¬q)`. It suffices to prove `false`.
  rw not_or_distrib at h₂,   -- Rewriting using De Morgan's law `not_or_distrib`, `h₂` is `¬¬p ∧ ¬¬q`.
  repeat {rw not_not at h₂}, -- Repeatedly using double negation, `h₂` is `p ∧ q`.
  show false, from h₁ h₂,    -- We show false by false introduction on `h₁` and `h₂`.
end
-- END
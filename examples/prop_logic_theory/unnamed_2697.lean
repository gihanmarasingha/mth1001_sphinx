import logic.basic
variables {p q : Prop}
local attribute [instance] classical.prop_decidable
-- BEGIN
example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
begin
  rw ←not_imp_not, -- It suffices to prove the contrapositive, `¬(¬p ∨ ¬q) → ¬¬(p ∧ q)`.
  rw not_or_distrib, -- By De Morgan's Law `not_or_distrib`, it suffices to prove `¬¬p ∧ ¬¬q → ¬¬(p ∧ q)`.
  repeat {rw not_not}, -- By repeated double negation, it suffices to prove `p ∧ q → p ∧ q`.
  exact id, -- This follows by `id`, the reflexivity of implication.
end
-- END
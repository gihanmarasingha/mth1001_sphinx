import logic.basic
variables {p q : Prop}
local attribute [instance] classical.prop_decidable
-- BEGIN
example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
begin
  assume h₁ : ¬(p ∧ q), -- Assume `h₁ : ¬(p ∧ q)`. It sfufice to prove `¬p ∨ ¬q`.
  have h₂ : ¬¬(¬p ∨ ¬q) ↔ ¬p ∨ ¬q, from not_not, -- By double negation, we have `¬¬(¬p ∨ ¬q) ↔ ¬p ∨ ¬q`.
  rw ←h₂,                 -- Rewriting with `h₂`, the goal is to show `¬¬(¬p ∨ ¬q)`.
  rw not_or_distrib,      -- Rewriting with `not_or_distrib`, the goal is to show `¬(¬¬p ∧ ¬¬q)`
  repeat { rw not_not, }, -- Repeatedly rewriting with double negation, the goal is to show `¬(p ∧ q)`.
  show ¬(p ∧ q), from h₁, -- We show `¬(p ∧ q)` from `h₁`.
end
-- END
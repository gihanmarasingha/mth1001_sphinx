variables {p q : Prop}
-- BEGIN
local attribute [instance] classical.prop_decidable

theorem not_or_not_of_not_and : ¬(p ∧ q) → ¬p ∨ ¬q :=
begin
  assume h₁ : ¬(p ∧ q),    -- Assume `h₁ : ¬(p ∧ q)`. It suffices to prove `¬p ∨ ¬q`.
  -- Via proof by cases, it suffices to prove we can derive `¬p ∨ ¬q` 1. assuming `h₂ : p` and 2. assuming `h₂ : ¬p`.
  by_cases h₂ : p,
  { right,                 -- Assume `h₂ : p`. By right or introduction, it suffices to prove `¬q`.
    assume h₃ : q,         -- Assume `h₃ : q`. By negation introduction, it suffices to prove `false`.
    apply h₁,              -- By false introduction on `h₁`, it suffices to prove `p ∧ q`.
    exact ⟨h₂, h₃⟩, },      -- This follows by and introduction on `h₂` and `h₃`.
  { sorry },
end
-- END
variables {p : Prop}
theorem not_not_of_self : p → ¬¬p := λ hp hnp, hnp hp
local attribute [instance] classical.prop_decidable
-- BEGIN
theorem not_not : ¬¬p ↔ p :=
begin
  split,                      -- By iff intro., it suffices to prove 1. `p → ¬¬p` and 2. `¬¬p → p`.
  { assume h₁ : ¬¬p,          -- Assume `h₁ : ¬¬p`. It suffices to prove `p`.
    by_cases h₂ : p,          -- We'll show `p` via proof by cases on `p`.
    { exact h₂,  },           -- Assume `h₂ : p`. The goal, `p` follows by reiteration on `h₂`.
    { exfalso,                -- By false elimination, it suffices to prove `false`.
      exact h₁ h₂, }, },      -- This follows by false introduction on `h₁` and `h₂`.
  { exact not_not_of_self, }, -- Goal 2. follows by a previously-proved theorem.
end
-- END
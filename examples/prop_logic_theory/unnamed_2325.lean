import tactic.rcases
variables {p q : Prop}
namespace hidden
-- BEGIN
theorem not_and_of_not_or_not : ¬p ∨ ¬q → ¬(p ∧ q) :=
begin
  assume h₁ : ¬p ∨ ¬q, -- Assume `h₁ : ¬p ∨ ¬q`. It suffices to prove `¬(p ∧ q)`.
  rintro ⟨h₂, h₃⟩,      -- Introduce `p ∧ q`. By and elim., `h₂ : p` and `h₃ : q`. By neg. intro, it suffices to prove `false`.
  -- By or elim. on `h₁`, it suffices to 1. assume `h₄ : ¬p` and prove `false` and 2. assume `h₅ : ¬q` and prove `false`.
  cases h₁ with h₄ h₅,
  { exact h₄ h₂, }, -- This follows by negation introduction on `h₁` and `h₃`.
  { sorry },
end
-- END
end hidden
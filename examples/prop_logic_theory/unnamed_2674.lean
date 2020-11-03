import logic.basic
variables {p q : Prop}
local attribute [instance] classical.prop_decidable
namespace hidden
-- BEGIN
theorem not_imp_not : (¬q → ¬p) ↔ (p → q) :=
begin
  split, -- By iff intro., it suffices to prove 1. `¬q → ¬p → p → q` and 2. `p → q → ¬q → ¬p`.
  { intros h₁ h₂, -- Assume `h₁ : ¬q → ¬p`, `h₂ : p`. It suffices to prove `q`.
    by_contradiction h₃, -- For a contradiction, assume `h₃ : ¬q`. It suffices to prove `false`.
    have h₄ : ¬p, from h₁ h₃, -- We have `h₄ : ¬p` by implication elimination on `h₁` and `h₃`.
    show false, from h₄ h₂, -- We show `false` by false introduction on `h₄` and `h₂`.
  },
  { exact mt }, -- We show `(p → q) → (¬q → ¬p)` by modus tollens.
end
-- END
end hidden
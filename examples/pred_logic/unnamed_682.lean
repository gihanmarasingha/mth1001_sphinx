import tactic.interactive
variables {U : Type*} {P : U → Prop}
namespace hidden
-- BEGIN
theorem not_forall : ¬(∀ x, P x) ↔ ∃ x, ¬P x :=
begin
  -- By iff intro., it suffices to prove 1. `¬(∀ x, P x) → ∃ x, ¬P x` and 2. `∃ x, ¬P x → ¬(∀ x, P x)`
  split,
  { intro h₁, -- Case 1. Assume `h₁ : ¬(∀ x, P x)`. It suffices to prove `∃ x, ¬P x`.
    by_contradiction h₂, -- For a contradiction, suppose `h₂ : ¬(∃ x, ¬P x)`. It suffices to prove `false`.
    sorry, },
  { intro h₁, -- Case 2. Assume `h₁ : ∃ x, ¬P x`. It suffices to prove `¬(∀ x, P x)`.
    intro h₂, -- Assume `h₂ : ∀ x, P x`. By negation introduction, it suffices to prove `false`.
    cases h₁ with u hu, -- By `∃` elim. on `h₁`, it suffices to prove the goal assuming `u : U` and `hu : ¬P u`.
    apply hu, -- By false introduction on `hu`, it suffices to prove `P u`.
    exact h₂ u, } -- The result follows by for all elimination on `h₂` and `u`.
end
-- END
end hidden
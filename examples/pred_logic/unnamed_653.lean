import tactic.interactive
variables {U : Type*} {P : U → Prop}
namespace hidden
-- BEGIN
theorem not_exists : ¬(∃ x, P x) ↔ ∀ x, ¬P x :=
begin
  -- By iff intro., it suffices to prove 1. `¬(∃ x, P x) → ∀ x, ¬P x` and 2. `∀ x, ¬P x → ¬(∃ x, P x)`
  split,
  { intro h₁,    -- Case 1. Assume `h₁ : ¬(∃ x, P x)`. By `→` intro, it suffices to prove `∀ x, ¬P x`.
    intro u,     -- Assume `u : U`. By for all intro., it suffices to show `¬P u`.
    intro h₂,    -- Assume `h₂ : P u`. By negation introduction, it suffices to prove `false`.
    apply h₁,    -- By false introduction on `h₁`, it suffices to prove `∃ x, P x`.
    use u,       -- By `∃` intro on `u`, it suffices to prove `P u`.
    exact h₂, }, -- This follows by reiteration on `h₂`.
  { intro h₁,    -- Assume `h₁ : ∀ x, ¬P x`. It suffices to prove `¬∃ x, P x`.
    intro h₂,   --- Assume `h₂ : ∃ x, P x`. By negation introduction, it suffices to prove `false`.
    -- By `∃` elim. on `h₂`, it suffices to prove `false` assuming `u : U` and `hu : P u`.
    cases h₂ with u hu,
    have h₃ : ¬P u, from h₁ u, -- By `∀` elim. on `h₁` applied to `u`, we have `h₃ : ¬P u`.
    exact h₃ hu, }, -- We show the goal by false introduction on `h₃` and `hu`.
end
-- END
end hidden
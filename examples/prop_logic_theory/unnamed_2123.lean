variables {p q : Prop}
-- BEGIN
example : (¬p ∨ q) → (p → q) :=
begin
  intros h₁ h₂,                  -- Assume `h₁ : ¬p ∨ q`. Assume `h₂ : p`. It suffices to prove `q`.
  -- By or elim. on `h₁`, it suffices to 1. assume `h₃ : ¬p` and derive `q` and 2. assume `h₄ : q` and derive `q`
  cases h₁ with h₃ h₄,
  { exfalso,                    -- By false elimination, it suffices to prove `false`.
    show false, from h₃ h₂, },  -- We show false by false introduction on `h₃` and `h₂`.
  { show q, from h₄, },         -- We show `q` by reiteration on `h₄`.
end
-- END
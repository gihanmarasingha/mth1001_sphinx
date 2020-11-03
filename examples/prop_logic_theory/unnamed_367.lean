variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
begin
  cases h with h₂ h₃,                     -- We have `h₂ : (p ∧ q)`, `h₃ : r` by left & right and elim. on `h`.
  cases h₂ with h₄ h₅,                    -- We have `h₄ : p` and `h₅ : q` by left & right and elim. on `h₂`.
  have h₆ : q ∧ r, from and.intro h₅ h₃,  -- We have `h₆ : q ∧ r` by and introduction on `h₅` and `h₃`.
  show p ∧ (q ∧ r), from ⟨h₄, h₆⟩,         -- We show `p ∧ (q ∧ r)` by and introduction on `h₄` and `h₆`.
end
-- END
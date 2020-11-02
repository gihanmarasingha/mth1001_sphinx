example : ∀ p q : Prop, p ∧ q ↔ q ∧ p :=begin
  intros r s, -- Assume `r : Prop` and `s : Prop`. It suffices to prove `r ∧ s ↔ s ∧ r`.
  split; -- By iff intro., it suffices to prove 1. `r ∧ s → s ∧ r` and 2. `s ∧ r → r ∧ s`. We'll use the same proof in each case.
  { intro h, exact ⟨h.2, h.1⟩, }, -- Assume the antecedent, `h`. The goal is closed by and intro. on `h.1` and `h.2`
end
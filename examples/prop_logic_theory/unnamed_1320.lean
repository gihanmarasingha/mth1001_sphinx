variables p q r : Prop

theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
λ h₁ h₂ h₃, h₂ (h₁ h₃)
-- BEGIN
example (h₁ : p ↔ q) (h₂ : q ↔ r) : p ↔ r :=
begin
  split,                            -- By iff intro., it suffices to prove `p → r` and `r → p`.
  { show p → r, apply imp_trans1,   -- We show `p → r`. By transitivity of `→`, it suffices to prove `p → ?` and `? → r`.
    { show p → q, from h₁.1, },     -- We show `p → q` by left iff elimination on `h₁`.
    { show q → r, from h₂.1, }, },  -- We show `q → r` by left iff elimination on `h₂`.
 { show r → p, sorry  },            -- The proof of `r → p` is left to the reader.
end
-- END
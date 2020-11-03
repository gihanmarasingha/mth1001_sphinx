variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
begin
  cases h with h₂ h₃,           -- We have `h₂ : p ∧ q` and `h₃ : r` by left and right conjunction elimination on `h`.
  split,                        -- By conjunction introduction, it suffices to prove `p` and `q ∧ r`.
  { show p, from h₂.left, },    -- We show `p` by left and elimination on `h₂`.
  { show q ∧ r, split,          -- We show `q ∧ r`. By conjunction introduction, it suffices to prove `q` and `r`.
    { show q, from h₂.right, }, -- We show `q` by right and elimination on `h₂`.
    { show r, from h₃ }, } ,    -- We show `r` by reiteration on `h₃`.
end
-- END
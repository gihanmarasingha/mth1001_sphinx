variables (p : Prop)

-- BEGIN
example : p ↔ p :=
begin
  split,                   -- By iff introduction, it suffices to prove `p → p` and `p → p`
  { show p → p, from id }, -- We show `p → p` from reflexivity of implication.
  { show p → p, from id }, -- We show `p → p` from reflexivity of implication.
end
-- END
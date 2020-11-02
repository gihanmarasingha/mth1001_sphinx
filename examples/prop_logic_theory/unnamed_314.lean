variables p q : Prop
-- BEGIN
example (h : p ∧ q) : q ∧ p :=
begin
  split,                -- By and introduction, it suffices to prove both `q` and `p`.
  show q, from h.right, -- We show `q` by right and elimination on `h`.
  show p, from h.left,  -- We show `p` by left and elimination on `h`.
end
-- END
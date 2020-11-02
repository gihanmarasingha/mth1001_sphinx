variables s t u : Prop

-- BEGIN
example (h : t) : s ∨ (t ∨ u) :=
begin
  right,           -- By right or introduction, it suffices to prove `t ∨ u`.
  left,            -- By left or introduction, it suffice to prove `t`.
  show t, from h,  -- We show `t` by reiteration on `h`.
end
-- END
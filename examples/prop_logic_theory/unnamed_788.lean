variables p q : Prop
-- BEGIN
theorem and_of_and : p ∧ q → q ∧ p :=
begin
  intro h,                   -- Assume `h : p ∧ q`. It suffices to prove `q ∧ p`.
  split,                     -- By `∧` intro., it suffices to prove both `q` and `p`.
  { show q, from h.right, }, -- We show `q` from right `∧` elimination on `h`.
  { show p, from h.left, },  -- We show `p` from left `∧` elimination on `h`.
end
-- END
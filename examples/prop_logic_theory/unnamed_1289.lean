variables (p q : Prop)

-- BEGIN
example (h : p ↔ q) : q ↔ p :=
begin
  split,                    -- By iff introduction, it suffices to prove `q → p` and `p → q`.
  { show q → p, from h.2 }, -- We show `q → p` by right iff elimination on `h`.
  { show p → q, from h.1 }, -- We show `p → q` by left iff elimination on `h`.
end
-- END
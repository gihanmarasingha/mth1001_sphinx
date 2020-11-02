variables p q : Prop

-- BEGIN
example (h : p ∧ q) : q :=
begin
  have hq : q, from
    h.right, -- Term-style right and elimination.
  exact hq,
end
-- END
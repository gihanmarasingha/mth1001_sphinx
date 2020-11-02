variables p q : Prop

-- BEGIN
example (h : p → q) (k : p) : q :=
begin
  apply h, -- This is a backward proof that changes the goal to proving p.
  exact k,
end
-- END
variables p q : Prop

-- BEGIN
example (k : q) : p → q :=
begin
  intro h, -- This is equivalent to 'Assume h : p' in mathematics.
  exact k, -- We close the goal using our proof of q.
end
-- END
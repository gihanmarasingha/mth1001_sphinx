variables p : Prop

-- BEGIN
example (k : false) : ¬p :=
begin
  intro h, -- This is equivalent to 'assume h : p' in mathematics.
  exact k, -- We close the goal using our proof of `false`.
end
-- END
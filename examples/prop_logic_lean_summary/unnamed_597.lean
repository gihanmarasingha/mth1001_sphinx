variables p : Prop

-- BEGIN
example (k : false) : ¬p :=
assume h : p,
  k
-- END
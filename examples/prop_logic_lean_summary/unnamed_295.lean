variables p q : Prop

-- BEGIN
example (k : q) : p → q :=
assume h : p,
  k
-- END
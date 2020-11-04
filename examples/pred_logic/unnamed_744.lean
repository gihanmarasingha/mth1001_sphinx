def even (a : ℕ) := ∃ b, a = 2 * b

example (h : 10 = 2 * 5) : even 10 :=
begin
  exact exists.intro 5 h
end
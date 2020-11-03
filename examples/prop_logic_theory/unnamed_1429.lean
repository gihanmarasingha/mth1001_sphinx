import data.nat.basic

variables x y z : ℕ
-- BEGIN
example : x * (y + z) = x * z + y * x :=
begin
  rw mul_add,
  rw add_comm,
  rw mul_comm x y,
end
-- END
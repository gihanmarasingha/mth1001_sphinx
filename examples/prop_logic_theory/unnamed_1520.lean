import data.nat.basic

variables x y z : ℕ
-- BEGIN
example : x * y + x * z = (z + y) * x :=
begin
  rw ←mul_add,
  rw add_comm,
  rw mul_comm,
end
-- END
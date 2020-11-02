import data.nat.basic

variables x y z : ℕ
-- BEGIN
example (k : y * x = z) : x * (y + z) = z + x * z :=
begin
  rw mul_comm at k,
  rw mul_add,
  rw k,
end
-- END
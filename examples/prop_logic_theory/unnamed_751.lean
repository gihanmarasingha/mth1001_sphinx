variables {p : Prop}
namespace hidden
-- BEGIN
theorem id : p → p :=
begin
  assume h : p,   -- Assume `h : p`. It suffices to prove `p`.
  show p, from h, -- We show `p` by reiteration on `h`.
end
-- END
end hidden
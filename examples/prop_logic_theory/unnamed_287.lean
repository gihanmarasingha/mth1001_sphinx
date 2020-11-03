variables p q : Prop
-- BEGIN
example (h : p ∧ q) : q ∧ p :=
begin
  have h₂ : p, from h.left,
  have h₃ : q, from h.right,
  exact and.intro h₃ h₂,
end
-- END

Alternatively, one can use the 'anonymous constructor' notation ``⟨h₃, h₂⟩`` in place of
``and.intro h₃ h₂``. Here, ``⟨`` and ``⟩`` are written as ``\<`` and ``\>`` respectively.
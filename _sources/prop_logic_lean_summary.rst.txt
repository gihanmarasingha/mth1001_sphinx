.. _sec_prop_logic_summary:

***********************************
Propositional logic in lean summary
***********************************

.. _prop_variables:

Propositional variables and special symbols
===========================================

Before working with propositions in Lean, you must introduce their names as variables.
For example, the following statement introduces propositional variables ``p``, ``q``, and ``r``.

If you're reading this online, click *try it* below and a Lean window will open in which you can
examine and work with the Lean code.

**Note**: the first time you open the window an entire copy of Lean will be downloaded to your browser.
This may take a minute or more, depending or your internet speed.
Alternatively, you can copy and paste the text into a CoCalc window.

.. code-block:: lean

  variables p q r : Prop
  -- This is a one-line comment. In has no effect in Lean.

In :numref:`lean_symbols`, we indicate how to type common symbols in Lean. After typing each
sequence of characters, press space to ask Lean to convert the sequence into a symbol.

.. _lean_symbols:

.. list-table:: Lean Symbols
    :widths: 20 50 30
    :header-rows: 1

    * - Symbol
      - Name
      - Lean
    * - :math:`\land`
      - Conjunction (and)
      - ``\and``
    * - :math:`\lor`
      - Disjunction (or)
      - ``\or``
    * - :math:`\to`
      - Implies
      - ``\r`` or ``\to``
    * - :math:`\leftrightarrow`
      - If and only if
      - ``\iff``
    * - :math:`\bot`
      - False, contradiction
      - ``false``
    * - :math:`\forall`
      - For all
      - ``\all``
    * - :math:`\exists`
      - There exists
      - ``\ex``
    * - :math:`h_1`
      - Subscript
      - ``h\1``
    * - ``⟨`` and ``⟩``
      - French quotes
      - ``\<`` and ``\>``



Reiteration
===========

The reiteration rule states that :math:`p` follows from :math:`h : p`.

This is represented very simply in a term-style Lean proof. The first line of the proof below can be
read as 'Given ``h : p``, here follows a proof of ``p``'.

.. code-block:: lean

  example (h : p) : p :=
  h -- Application of reiteration.

Reiteration is represented in a tactic-style proof by the ``exact`` tactic.

.. code-block:: lean

  variable p : Prop
  -- BEGIN
  example (h : p) : p :=
  begin
    exact h,
  end
  -- END


Conjunction (and)
=================

Conjunction elimination
-----------------------

There are two conjunction elimination rules, left and right.
  * (**Left and elimination**) given :math:`h : p \land q`, we have a proof of :math:`p`.
  * (**Right and elimination**) given :math:`h : p \land q`, we have a proof of :math:`q`.


In a tactic-style proof, we can perform left and right and elimination simultaneously with the
``cases`` tactic. Below, ``cases h with hp hq`` introduces hypotheses ``hp : p`` and ``hq : q`` into
the context.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p ∧ q) : q :=
  begin
    cases h with hp hq, -- Equivalent to both left and right and elimination.
    exact hq, -- Closes the goal via reiteration using the proof term `hq`
  end
  -- END

Given ``h : p ∧ q``, a proof term for ``p ∧ q``, the terms ``h.left`` and ``h.right`` are proof terms
for ``p`` and ``q``, respectively.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p ∧ q) : q :=
  h.right -- Term-style right and elimination.
  -- END


We can use the ``have``, ..., ``from`` notation to insert a term-style proof into a tactic-style
proof. Below, ``h.right`` is a proof term for ``q``.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p ∧ q) : q :=
  begin
    have hq : q, from
      h.right, -- Term-style right and elimination.
    exact hq,
  end
  -- END

Conjunction introduction
------------------------

**Forward**: given :math:`h_1 : p` and :math:`h_2 : q`, we have a proof of :math:`p\land q`.

**Backward**: to prove :math:`p\land q`, it suffices to prove :math:`p` and :math:`q`.


The ``split`` tactic applies conjunction introduction backward.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p) (h₂ : q) : p ∧ q :=
  begin
    split, -- This replaces the goal p ∧ q with two new goals: 1. p and 2. q.
    { exact h₁, }, -- This closes the goal for p.
    { exact h₂, }, -- This closes the goal for q.
  end
  -- END

The ``and.intro`` function, applied to ``h₁ : p`` and ``h₂ : q``, gives a proof term for ``p ∧ q``.
This is a forward application of conjunction introduction.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p) (h₂ : q) : p ∧ q :=
  and.intro h₁ h₂
  -- END

This can also be written using French quotes (a general Lean notation for the so-called constructor
of an inductive data type).

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p) (h₂ : q) : p ∧ q :=
  ⟨h₁, h₂⟩ -- Enter these 'French quotes' with `\<` and  `\>`

This proof term can be used within a tactic block.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p) (h₂ : q) : p ∧ q :=
  begin
    exact and.intro h₁ h₂ -- Or `exact ⟨h₁, h₂⟩`.
  end
  -- END


Implication
===========

Implication elimination
-----------------------

**Forward**: given :math:`h_1 : p \to q` and :math:`h_2 : p`, we have a proof of :math:`q`.

**Backward**: given :math:`h : p \to q`, to prove :math:`q`, it suffices to prove :math:`p`.

The ``apply`` tactic uses implication elimination backward.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p → q) (k : p) : q :=
  begin
    apply h, -- This is a backward proof that changes the goal to proving p.
    exact k,
  end
  -- END

Given ``h₁ : p → q`` and ``h₂ : p``, the expression ``h₁ h₂`` is a proof term for ``q``. This is
forward implication elimination.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p → q) (h₂ : p) : q :=
  h₁ h₂ -- h₁ h₂ is the result of implication elimination on h₁ and h₂.
  -- END

As usual, this proof term can be used within a tactic block using the ``exact`` tactic.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p → q) (h₂ : p) : q :=
  begin
    exact h₁ h₂,
  end
  -- END

Implication introduction
------------------------

**Implication introduction**: to prove :math:`p \to q`, it suffices to assume :math:`h : p` and
derive :math:`q`.

Tactic-style, if the goal is to prove ``p → q``, then ``intro h`` introduces an assumption
``h : p`` into the context and replaces the goal with one of proving ``q``.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (k : q) : p → q :=
  begin
    intro h, -- This is equivalent to 'Assume h : p' in mathematics. 
    exact k, -- We close the goal using our proof of q.
  end
  -- END

The term style proof is similar, using ``assume`` instead of ``intro``.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (k : q) : p → q :=
  assume h,
    k
  -- END

If desired, you can make the type of ``h`` explicit, when giving a term-style proof.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (k : q) : p → q :=
  assume h : p,
    k
  -- END

Disjunction (or)
================

Disjunction introduction
------------------------

There are two disjunction introduction rules, left and right.

**Forward**
  * (**Left or introduction**) given :math:`h : p`, we have a proof of :math:`p \lor q`.
  * (**Right or introduction**) given :math:`h : q`, we have a proof of :math:`p \lor q`.

**Backward**
  * (**Left or introduction**) to prove :math:`p`, it suffices to prove :math:`p \lor q`.
  * (**Right or introduction**) to prove :math:`q`, it suffices to prove :math:`p \lor q`.

The ``left`` and ``right`` tactics represent backward left or introduction and right or introduction,
respectively.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p) : p ∨ q :=
  begin
    left, -- This changes the goal, by left or introduction, to proving p
    exact h,
  end
  -- END

Forward, given ``h : p``, the expression ``or.inl h`` is a proof term for ``p ∨ q``. Likewise,
if ``h : q``, the expression ``or.inr h`` is a proof term for ``p ∨ q``.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p) : p ∨ q :=
  or.inl h
  -- END

Disjunction elimination
-----------------------

**Forward**: given :math:`h_1 : p \lor q`, :math:`h_2 : p \to r`, and :math:`h_3 : q \to r`, we
have a proof of :math:`r`.

**Backward**: given :math:`h : p \lor q`, to prove :math:`r`, it suffices to (1) assume
:math:`hp : p` and deduce :math:`r` and (2) assume :math:`hq : q` and deduce :math:`r`.

Given ``h : p ∨ q``, the ``cases`` tactic applied as ``cases h with hp hq`` replaces the goal
of proving ``r`` with two subgoals: (1) to prove ``r`` with an additional assumption ``hp : p``
and (2) to prove ``r`` with an additional assumption ``hq : q``.

In the example code below, we show two different methods of closing the resulting subgoals,
corresponding, in turn, to term-style and tactic-style implication elimination.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h : p ∨ q) (h₂ : p → r) (h₃ : q → r) : r :=
  begin
    cases h with hp hq,
    { exact h₂ hp, }, -- `h₂ hp` is implication elimination to give `r`.
    { apply h₃, exact hq, }, -- A tactic-style implication elimination.
  end
  -- END

Here is a more typical example of disjunction elimination.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h₁ : (p ∧ r) ∨ (r ∧ q)) : r :=
  begin
    cases h₁ with h₂ h₂,
    { exact h₂.right, }, -- In this subproof, `h₂ : p ∧ r`. The subgoal is `r`.
    { exact h₂.left, }, -- In this subproof, `h₂ : r ∧ q`. The subgoal is `r`.
  end
  -- END


Given ``h₁ : p ∨ q``, ``h₂ : p → r``, ``h₃ : q → r``, the function ``or.elim`` applied to ``h₁``,
``h₂``, and ``h₃`` gives a proof-term for``r``.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h₁ : p ∨ q) (h₂ : p → r) (h₃ : q → r) : r :=
  or.elim h₁ h₂ h₃
  -- END

Here is a term-style proof of the previous result.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h₁ : (p ∧ r) ∨ (r ∧ q)) : r :=
  or.elim h₁
    (assume h₂ : p ∧ r, h₂.right) -- A term-style proof of `p ∧ r → r`
    (assume h₂ : r ∧ q, h₂.left) -- A term-style proof of `r ∧ q → r`
  -- END

If and only if (iff)
====================

Iff elimination
---------------
There are two iff elimination rules, left and right.
  * (**Left iff elimination**) given :math:`h : p \leftrightarrow q`, we have a proof of :math:`p \to q`.
  * (**Right iff elimination**) given :math:`h : p \leftrightarrow q`, we have a proof of :math:`q \to p`.

Note the similarity with this and conjunction elimination.

Given ``h : p ↔ q``, the ``cases`` tactic, when applied as ``cases h with h₁ h₂``, decomposes the
hypothesis ``h`` into two hypotheses, ``h₁ : p → q`` and ``h₂ : q → p``. This is the same as
left and right iff elimination simultaneously.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p ↔ q) : p → q :=
  begin
    cases h with h₁ h₂,
    exact h₁,
  end
  -- END

Likewise, given ``h : p ↔ q``, ``iff.elim_left h`` is a proof term for ``p → q`` and
``iff.elim_right h`` is a proof term for ``q → p``.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : p ↔ q) : p → q :=
  iff.elim_left h
  -- END

Iff introduction
----------------

**Forward**: given :math:`h_1 : p \to q` and  :math:`h_2 : q \to p`,  we
have a proof of :math:`p \leftrightarrow q`.

**Backward**: to prove :math:`p \leftrightarrow q`, it suffices to prove :math:`p \to q` and
:math:`q \to p`.

The ``split`` tactic applies iff introduction backward.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p → q) (h₂ : q → p) : p ↔ q :=
  begin
    split, -- This replaces the goal `p ↔ q` with 1. p → q and 2. q → p.
    { exact h₁, }, -- Closes the goal `p → q`.
    { exact h₂, }, -- Closes the goal `q → p`.
  end
  -- END

The ``iff.intro`` function, applied to ``h₁ : p → q`` and ``h₂ : q → p``, gives a proof term for
``p ∧ q``. This is a forward application of iff introduction.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h₁ : p → q) (h₂ : q → p) : p ↔ q :=
  iff.intro h₁ h₂
  -- END


False and negation
==================

False elimination
-----------------

The symbol :math:`\bot`, referred to as false or contradiction or arbitrary contradiction, is
referred to in one fundamental rule of inference, *ex falso sequitur quodlibet*, also called
*ex falso* or false elimination. This rule states that anything follows from false.

**Forward**: given :math:`h : \bot`, we have a proof of :math:`p`.

**Backward**: to prove :math:`p`, it suffices to prove :math:`\bot`.

The ``exfalso`` tactic represents backward false elimination.

.. code-block:: lean

  variables p q : Prop

  -- BEGIN
  example (h : false) : p :=
  begin
    exfalso, -- This changes the goal from `p` to `false`.
    exact h, -- We close the goal with `h`.
  end
  -- END

Given ``h : false``, the expression ``false.elim h`` is a proof term for ``p``.

.. code-block:: lean

  variables p : Prop

  -- BEGIN
  example (h : false) : p :=
  false.elim h
  -- END

False introduction
------------------

The expression :math:`\neg p` is a shorthand for :math:`p \to \bot`. The rule of false introduction
is thus merely implication elimination in another guise.

**Forward**: given :math:`h_1 : \neg p` and :math:`h_2 : p`, we have a proof of :math:`\bot`.

**Backward**: given :math:`h : \neg p`, to prove :math:`\bot`, it suffices to prove :math:`p`.


The ``apply`` tactic uses false introduction backward.

.. code-block:: lean

  variables p : Prop

  -- BEGIN
  example (h : ¬p) (k : p) : false :=
  begin
    apply h, -- This changes the goal to proving `p`.
    exact k,
  end
  -- END

Given ``h₁ : ¬p`` and ``h₂ : p``, the expression ``h₁ h₂`` is a proof term for ``false``. This is
forward false introduction.

.. code-block:: lean

  variables p : Prop

  -- BEGIN
  example (h₁ : ¬p) (h₂ : p) : false :=
  h₁ h₂
  -- END


Negation introduction
---------------------

As :math:`\neg p` is shorthand for :math:`p \to \bot`, the rule of negation introduction is really
just implication introduction.

**Negation introduction**: to prove :math:`\neg p`, it suffices to assume :math:`h : p` and
derive :math:`\bot`.

Tactic-style, if the goal is to prove ``¬p``, then ``intro h`` introduces an assumption
``h : p`` into the context and replaces the goal with one of proving ``false``.

.. code-block:: lean

  variables p : Prop

  -- BEGIN
  example (k : false) : ¬p :=
  begin
    intro h, -- This is equivalent to 'assume h : p' in mathematics.
    exact k, -- We close the goal using our proof of `false`.
  end
  -- END

The term-style proof is similar.

.. code-block:: lean

  variables p : Prop

  -- BEGIN
  example (k : false) : ¬p :=
  assume h : p,
    k
  -- END

Summary
=======

Tactic-style
------------

:numref:`tactic_style_prop` summaries the Lean tactics that represent rules of propositional logic.

.. _tactic_style_prop:

.. list-table:: Tactic-Style
  :widths: 20 20 20
  :header-rows: 1

  * - Connective
    - Introduction
    - Elimination 
  * - ``∧``, conjunction
    - ``split``
    - ``cases h with h₁ h₂``
  * - ``∨``, disjunction
    - ``left``

      ``right``
    - ``cases h with k₁ k₂``
  * - ``→``, implication
    - ``intro h``
    - ``apply h``
  * - ``↔``, iff
    - ``split``
    - ``cases h with h₁ h₂``
  * - ``false``, false
    - ``exfalso``
    - ``apply h``
  * - ``¬``, negation
    - ``intro h``
    - N/A

Term-style
----------


:numref:`term_style_prop` summaries the Lean functions that represent rules of propositional logic
and produce proof terms.


.. _term_style_prop:

.. list-table:: Term-Style
  :widths: 20 20 20
  :header-rows: 1

  * - Connective
    - Introduction
    - Elimination 
  * - ``∧``, conjunction
    - ``and.intro h₁ h₂`` or ``⟨h₁, h₂⟩``
    - ``h.left``

      ``h.right``
  * - ``∨``, disjunction
    - ``or.inl h``

      ``or.inr h``
    - ``or.elim h₁ h₂ h₃``
  * - ``→``, implication
    - ``assume h : P,`` *followed by a proof term for* ``Q``.
    - ``h₁ h₂``
  * - ``↔``, iff
    - ``iff.intro h₁ h₂``
    - ``iff.elim_left h``

      ``iff.elim_right h``
  * - ``false``, false
    - ``h₁ h₂``
    - ``false.elim h``
  * - ``¬``, negation
    - ``assume h : P,`` *followed by proof of* ``false``.
    - N/A


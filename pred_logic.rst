.. _sec_pred_logic:

***************
Predicate Logic
***************

.. _sec_types:

Types
=====

Every term in mathematics has a type. For instance, :math:`\mathbb{Z}` is the type of integers.
A statement such as :math:`5 : \mathbb Z` is called a (typing) judgment. This statement can be read
'5 has type :math:`\mathbb Z`' or '5 is an integer'.

We can work with arbitrary terms and types. The judgment :math:`x : U` is read ':math:`x` has type
:math:`U`'.

Propositional variables, as discussed in :numref:`Section %s <prop_variables>`, are terms of type
``Prop``.

Suppose we have ``P : Prop`` and ``Q : Prop``. What is meant by ``h : P ∧ Q``? When a proposition,
such as ``P ∧ Q`` is viewed as a type, it is the type of proofs of that proposition. Thus the
judgment ``h : P ∧ Q`` should be interpreted as '``h`` is a proof of ``P ∧ Q``'.

A new type can be introduced into Lean using the following syntax.

.. code-block:: lean

  variable U : Type* -- This declares `U` to be a type.

Functions and definitions
=========================

A function (also called a definition) is a mathematical object with a name,
zero or more inputs, a body, and a body type.

Below, we define three functions in Lean. The last function has name ``avg``. It 
takes two inputs, ``x`` and ``y``, both of type ``ℤ``, and has a body ``(x + y)/2``,
also of type ``ℤ`` (note that integer division automatically rounds in Lean).

.. code-block:: lean

  def double (x : ℤ) : ℤ := 2 * x
  def square (y : ℤ) : ℤ := y * y
  def avg (x y : ℤ) : ℤ := (x + y)/2

Some functions can be evaluated. For example, with the above definitions, you 
could find the average of 10 and 6 as follows.

.. code-block:: lean

  def avg (x y : ℤ) : ℤ := (x + y)/2
  -- BEGIN
  #eval avg 10 6
  -- END

Here, ``avg 10 6`` represents the result of replacing ``x`` with ``10`` and ``y``
with ``6`` in the body of the defintion of ``avg``.


One may check the type of any Lean object using the ``#check`` directive. On entering the following
commands, Lean will respond with ``double : ℤ → ℤ`` and ``avg : ℤ → ℤ → ℤ``.

.. code-block:: lean

  def double (x : ℤ) : ℤ := 2 * x
  def square (y : ℤ) : ℤ := y * y
  def avg (x y : ℤ) : ℤ := (x + y)/2
  -- BEGIN
  #check double
  #check avg
  -- END

Here, ``ℤ → ℤ`` is the type of functions that take one integer input and produce one integer output,
while ``ℤ → ℤ → ℤ`` is the type of functions that take two integer inputs and produce one integer
output. Can you guess the type of ``square``?

More generally, if ``U`` and ``V`` are types, we can declare, without defining them, functions from
``U`` to ``V``. The following declares a function ``f`` of type ``U → V``. That is, ``f`` is a
function from ``U`` to ``V``.

Here, ``f x`` denotes the result of applying ``f`` to ``x``. Naturally, the type of the result is ``V``.

.. code-block:: lean

  variables U V : Type*
  variable x : U
  variable f : U → V
  #check f
  #check f x

.. _sec_currying:

Currying functions
==================

This section is optional reading.

I lied earlier when I wrote that ``ℤ → ℤ → ℤ`` is the type of functions that take two integer
inputs and produce one integer output. To begin, we should clarify whether ``ℤ → ℤ → ℤ`` means
``ℤ → (ℤ → ℤ)`` or ``(ℤ → ℤ) → ℤ``. By convention, the former meaning, ``ℤ → (ℤ → ℤ)`` is used.
This is chosen to harmonise with the notion of function application, as we'll see at the end of
this section.

In truth, ``ℤ → (ℤ → ℤ)`` is therefore the type of functions that take one integer argument and
returns *a function* of type ``ℤ → ℤ``

Thus ``avg 5`` is a function that takes takes an input, say ``y``, and returns ``(5 + y)/2``.
This is called *partial application* of ``avg``. To make this more transparent, we define a new
function ``avg'`` to be the partial application of ``avg`` at 5.

.. code-block:: lean

  def avg (x y : ℤ) : ℤ := (x + y)/2
  --BEGIN
  def avg' := avg 5

  #eval avg' 17 -- This outputs 11.
  --END

It transpires that this is the most natural way to think of functions of several variables when
proving theorems.

Alternatively, the function ``avgu`` defined below is actually a function that takes a pair of
variables (as indicated by the input type ``ℤ × ℤ``) and returns an integer.

.. code-block:: lean

  def avgu : ℤ × ℤ → ℤ
  | (x, y) := (x + y)/2

  #eval avgu (10,6)  -- This displays 8.

Producing ``avg``, a function that produces a function, from ``avgu``, a function of many variabes,
is called *currying*, after American mathematician Haskell Curry.
The reverse process is called *uncurrying*.

One may consider functions of more than two variables.

.. code-block:: lean

  def avg_three_u : (ℤ × ℤ × ℤ) → ℤ
  | (x, y, z) := (x + y + z)/3
  #check avg_three_u -- `avg_three_u` has type `ℤ × ℤ × ℤ → ℤ`
  #eval avg_three_u (10, 5, 6) -- This is 7.

Consider the curried version of this function, which we call ``avg_three``.

.. code-block:: lean

  def avg_three (x y z : ℤ) : ℤ := (x + y + z)/2

  #check avg_three  -- `avg_three` has type `ℤ → ℤ → ℤ → ℤ`, i.e., `ℤ → (ℤ → (ℤ → ℤ))`
  #check (avg_three 10)      -- `avg_three 10` has type `ℤ → (ℤ → ℤ)`.
  #check (avg_three 10 5)    -- `avg_three 10 5` has type `ℤ → ℤ`.
  #check (avg_three 10 5 6)  -- `avg_three 10 5 6` has type `ℤ`, i.e. is an integer.

``avg_three`` has type ``ℤ → (ℤ → (ℤ → ℤ))``. That is, it takes an integer input and
outputs a term of type ``ℤ → (ℤ → ℤ)``. But a term of this type *is* a function that takes
an integer input and outputs a term of type ``ℤ → ℤ``. In its turn this is a function that takes
an integer input and outputs a term of type ``ℤ``.

We see this through successive partial applications of ``avg_three``.

Indeed, when we write something like ``avg 10 6``, we really mean ``(avg 10) 6``.
That is we take the function ``avg 10`` and apply it to ``6``.

Likeiwse, ``avg_three 10 5 6`` really means ``(((avg_three 10) 5) 6``. Note how the bracketing
convention for function application is the opposite of the convention for function types.


Predicates
==========

A predicate is a function whose body type is ``Prop``. Below, we define the predicate ``even``
so that ``even x`` is the proposition ``∃ m : ℤ, x = 2 *m``. The symbol ``∃`` is read
'there exists'. So this proposition can be interpreted as, 'there exists an integer :math:`m` such
that :math:`x = 2m`'.

.. code-block:: lean

  def even (x : ℤ) : Prop := ∃ m : ℤ, x = 2 *m
  #check even
  #check even 5

The result of ``#check`` assures us that ``even`` has type ``ℤ → Prop``. It is a function that takes
one input of type ``ℤ`` and has a body of type ``Prop``. Moreover ``even 5`` has type ``Prop``.

.. code-block:: lean

  def even (x : ℤ) : Prop := ∃ m : ℤ, x = 2 *m
  -- BEGIN
  #check even
  #check even 5
  -- END

Predicates can take more than one input. The following predicate takes two integer inputs ``a`` and
``b`` and has body ``∃ m : ℤ, b = a * m``. In familiar language, it represents the notion that ``a``
divides (i.e. is a factor of) ``b``.

.. code-block:: lean
  
  def divides (a b : ℤ) : Prop := ∃ m : ℤ, b = a * m


When working abstractly, we can declare, without definining it, a predicate on an arbitrary type.

.. code-block:: lean

  variable U : Type*       -- Declare a type, `U`.
  variable x : U           -- Declare a term `x`, of type `U`.
  variable P : U → Prop    -- Declare a predicate `P` on `U`.

  #check P x               -- `P x` has type `Prop`
  #check P                 -- `P` has type `U → Prop`


Here, ``P x`` is the result of applying ``P`` to ``x``. It has type ``Prop``, while ``P`` itself
has type ``U → Prop``.

We may define abstract predicates on more than one type.

.. code-block:: lean

  variables (U : Type*) (V : Type*) -- Declare types `U` and `V`.
  variables (x : U) (y : V)         -- Declare terms `x` of type `U` and `y` of type `V`.

  variable Q : U → V → Prop    -- Declare a predicate `Q` on `U` and `V`.

  #check Q     -- `Q` is a predicate with type `U → V → Prop`.
  #check Q x   -- `Q x` is a predicate with type `V → Prop`.
  #check Q x y -- `Q x y` has type `Prop`, i.e. is a proposition.

The next two paragraphs are technical and may be omitted if you have not read
:numref:`Section %s <sec_currying>`.

When viewed through the lens of currying functions, the predicate ``Q`` can be thought of as a
function that takes an input of type ``U`` and outputs a function of type ``V → Prop``.

The observant reader will note that this contradicts by previous definition that a predicate is a
function with body type ``Prop``. That's because I lied to keep things simple.
Really, I mean that for a function to be a predicate, its *uncurried* version should have body type
``Prop``. The uncurried version of ``Q`` has type ``U × V → Prop``, so indeed its body type is
``Prop``. 

Universal quantification
========================

The universal quantifier, written :math:`\forall` is one of the two operators of predicate logic.
It is read 'for all', 'for every', or 'for each'. Informally, :math:`\forall x, P(x)` is the
assertion that :math:`P(x)` holds for every :math:`x`.

Formally, the meaning of the universal quantifier is defined by two rules of inference.

For all elimination
-------------------

.. proof:mathsrule:: For all elimination, forward

  Let :math:`U` be a type and let :math:`P` be a predicate on :math:`U`. Given
  :math:`h : \forall x, P(x)` and given :math:`u : U`, we have :math:`P(u)`.

In Lean, if ``P : U → Prop`` is a predicate, given ``h : ∀ x, P x`` and given ``u : U``, the
expression ``h u`` is a proof term for ``P u``. Note the similarity between this and the Lean
notation for implication elimination.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)

  example (h : ∀ x, P x) : P u :=
  by exact h u

Alternatively, the ``specialize`` tactic applies to a universally quantified statement
``h : ∀ x, P x``. Writing ``specialize h u`` replaces ``h`` with ``h : P u``.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, P x) : P u :=
  begin
    specialize h u,    -- By for all elimination on `h` and `u`, we have `h : P u`
    show P u, from h,  -- We show `P u` by reiteration on `h`.
  end
  -- END

.. proof:mathsrule:: For all elimination, backward

  Let :math:`U` be a type and let :math:`P` be a predicate on :math:`U`. To prove :math:`P(u)`,
  :math:`h : \forall x, P(x)` and given :math:`u : U`, we have :math:`P(u)`.

In Lean, we invoke backward for all elimination using the ``apply`` tactic, just as we did for
backward implication elimination. Below, Lean is clever enough to close the goal immediately after
``apply h`` as ``u : U`` is in the context.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, P x) : P u :=
  by apply h
  -- END

Let's do something a little more interesting.

.. proof:example::

  Let :math:`S` and :math:`T` be prediates on a type :math:`U`. Given :math:`h_1 : \forall x, S(x)`,
  :math:`h_2 : \forall y, S(y)\to T(y)` and :math:`u : U`, we have :math:`T(u)`.

We give first a forward proof.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)

  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    have h₃ : S u, from h₁ u,  -- We have `h₃ : S u` by for all elim. on `h₁` and `u`.
    have h₄ : S u → T u, from h₂ u, -- We have `h₄ : S u → T u` by for all elim. on `h₂` and `u`
    show T u, from h₄ h₃, -- We show `T u` by implication elimination on `h₄` and `h₃`.
  end

The same proof can be written more concisely using ``specialize``.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    specialize h₁ u,  -- We have `h₁ : S u` by for all elim. on `h₁` and `u`.
    specialize h₂ u, -- We have `h₂ : S u → T u` by for all elim. on `h₂` and `u`
    show T u, from h₂ h₁, -- We show `T u` by implication elimination on `h₂` and `h₁`.
  end
  -- END

In the following backward Lean proof, ``apply h₂`` invokes for all elimination followed by
implication elimination on the hypothesis ``h₂``.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    apply h₂, -- By for all elim. on `h₂` and `u`, followed by imp. elim., it suffices to prove `S u`.
    apply h₁, -- The result follows by for all elim. on `h₁` and `u`.
  end
  -- END

In the next example, we construct a predicate using two others.

Below, we have predicates ``S`` and ``T`` on a type ``U``. The function that takes ``x : U`` to
``(S x) ∧ (T x)`` is also a predicate. We assume the universally quantified statement
``h : ∀ x, (S x) ∧ (T x)``. By for all elimination applied to ``h`` and ``u : U``, we have
``(S u) ∧ (T u)``. We can extract ``S u`` from this by left conjunction elimination.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, (S x) ∧ (T x)) : S u :=
  begin
    have h₂ : (S u) ∧ (T u), from h u, -- We have `h₂ : (S u) ∧ (T u)` by for all elimination on `h` and `u`.
    show (S u), from h₂.left, -- We show `S u` by left conjunction elimination on `h₂`.
  end
  -- END

Existential quantification
==========================

Negating quantifiers
====================

Mixing quantifiers
==================

Functions and equality
======================
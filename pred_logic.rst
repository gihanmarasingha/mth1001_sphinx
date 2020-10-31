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

Predicates
==========

A predicate is a function whose body type is ``Prop``. Below, we define the predcicate ``even``
defined so that ``even x`` is the proposition ``∃ m : ℤ, x = 2 *m``. The symbol ``∃`` is read
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

  #check P x

Here, ``P x`` is the result of applying ``P`` to ``x``. It has type ``Prop``.

Universal quantification
========================

Existential quantification
==========================

Negating quantifiers
====================

Mixing quantifiers
==================

Functions and equality
======================
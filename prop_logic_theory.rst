.. _prop_logic_tutorial:

**************************
Propositional Logic Theory
**************************


Propositions and propositional variables
========================================

From an informal perspective, propositions are statements that can be assigned
a truth value.

The formal perspective, which is more useful when you want to prove a theorem, propositions are
simply expressions that can be constructed recursively by applying connectives to other propositions.

As with any recursive definition, we must begin with a base set of propositions. These are called
*propositional variables*. Technically, we have an infinite list of propositional variables,
labelled :math:`P_1, P_2, \dots, P_n, \dots`. For practical purposes, we often refer to
propositional variables using different letters of the alphabet whether uppercase :math:`P, Q, R, \dots`
or lower case :math:`p, q, r, \dots`.

The five connectives of propositional logic are shown in
:numref:`tab_prop_connectives`, listed in decreasing order of precedence. Negation is a unary
connective, which means that it applies only to one proposition. The remaining connectives are
binary, applying to two propositions.

.. tabularcolumns:: |c|l|

.. _tab_prop_connectives:

.. table:: Connectives of propositional logic and their order of precedence
  :widths: 10 20  

  =========================  ===================
  Connective                    Name
  =========================  ===================
  :math:`\neg`               Negation
  :math:`\land`              Conjunction, And
  :math:`\lor`               Disjunction, Or
  :math:`\to`                Implication
  :math:`\leftrightarrow`    If and only if
  =========================  ===================

.. proof:definition:: Proposition

  A proposition is a propositional variable or one of :math:`(\neg \alpha)`, :math:`(\alpha\land\beta)`,
  :math:`(\alpha\lor\beta)`, :math:`(\alpha\to\beta)`, :math:`(\alpha\leftrightarrow\beta)`, where
  :math:`\alpha` and :math:`\beta` are propostions.


For example, if our propositional variables are :math:`P`, :math:`Q`, and :math:`R`, then all the
following are propositions: :math:`P`, :math:`(\neg P)`, :math:`(\neg(P\land Q))`,
:math:`((P\lor Q)\leftrightarrow(\neg R))`.

To simplify writing propositions, we may always remove the outermost parentheses and remove other
parentheses according to the order of precedence. That is, if :math:`\oplus`
and :math:`\otimes` are (generic) connectives where :math:`\oplus` has a higher order of precedence
than :math:`\otimes`, if  :math:`\alpha`, :math:`\beta`, and :math:`\gamma`
are propositions, then :math:`((\alpha\oplus\beta)\otimes\gamma)` can be replaced with
:math:`\alpha\oplus\beta\otimes\gamma`. Likewise, :math:`(\alpha\otimes(\beta\oplus\gamma))` can
be replaced with :math:`\alpha\otimes\beta\oplus\gamma`. This rule can be applied recursively.

Thus :math:`((P\land Q)\to(P\lor(Q\land(\neg R))))` can be more simply written as
:math:`P\land Q \to P \lor Q \land \neg R`.

The proposition, :math:`((P\land Q)\lor R)` can be written as :math:`(P\land Q)\lor R`, but we
cannot remove the inner parentheses as the connective :math:`\lor` has a lower order of precendence
than :math:`\land`.

Two propositions :math:`\alpha` and :math:`\beta` are considered to be equal if and only if they
are written *identically*, with the exception of parenthesis dropping as described in the previous
paragraph.

Thus :math:`P\land Q` is *not* equal to :math:`Q\land P`. However, :math:`((P\land Q)\lor R)` is
equal to :math:`(P\land Q)\lor R` and to :math:`P\land Q \lor R`.

In :numref:`Section %s <prop_variables>`, we discuss how to represent propositions in Lean.

Derivations and rules of inference
==================================

Propositional logic is concerned with making derivations, based on *premises*, using
*rules of inference*.

Each premise takes the form :math:`h : \alpha`, where :math:`h` is any symbol (usually a lowercase
letter, with or without a subscript) and :math:`\alpha` is a proposition.

Intuitively, the judgment :math:`h : \alpha` is to be read ':math:`h` is a proof of :math:`\alpha`'.
We will give a more rigorous interpretation of this judgment in :numref:`Section %s <sec_types>`.

Here is an example of a rule of inference. This rule is called left conjunction elimination.

  Given :math:`h : P\land Q`, we have a proof of :math:`P`.

In essence, a rule of inference is a black box that takes certain inputs (the premises) and
produces an output. In this case, the output is a proof of :math:`P`. Here, and in every
statement of a rule of interfence, the names of propostions that appear are to be treated as 
generic. Thus :math:`P` and :math:`Q` can be replaced with any propositions.

As an example application of this rule of inference, suppose we have a premise
:math:`h : (P\to Q)\land R`. Left conjunction elimination, applied to :math:`h`, produces a 
proof of :math:`P\to Q`.

Rules of inference can be applied in sequence. Suppose we have a premise
:math:`k_1 : (Q \land P) \land R`. Applling left conjunction elimination to :math:`k_1` gives a proof
of :math:`Q\land P`. Let us denote by :math:`k_2` the proof of :math:`Q\land P` that results from
the application of left conjunction elimination to :math:`k_1`. By applying left conjunction elimination
to the hypothesis :math:`k_2`, we have a proof of :math:`Q`.

We use the word *hypothesis* to denote either a premise or a result derived by a rule of inference during
the course of a proof. At any stage in a proof, the entire set of hypotheses developed or introduced
up to that point, together with any variables, is called the *context*. In the above proof, the context initially consists of the
premise :math:`k_1` and the varialbles :math:`P`, :math:`Q`, and :math:`R`. After the first
application of left conjunction elimination, the context will also include the hypotheses :math:`k_2`.

Conjunction 
===========

Conjunction Elimination
-----------------------

There are two conjunction elimination rules, left and right.

.. proof:mathsrule:: Conjunction elimination

  .. raw:: latex

    \ 

  * (*Left and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`P`.
  * (*Right and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`Q`.

As an example, we will deduce :math:`Q` from the premise :math:`h : (P \land Q)\land R`.

  We have :math:`h_2 : P\land Q` by left conjunction elimination on :math:`h`. The result follows
  by right conjunction elimination on :math:`h_2`.

Conjunction Elimination in Lean
-------------------------------

This is expressed in Lean as follows.

.. code-block:: lean

  variables p q r : Prop

  example (h : (p ∧ q) ∧ r ) : q :=
  begin
    have h₂ : p ∧ q, from h.left,
    exact h₂.right 
  end

The ``exact`` tactic is a 'finishing command' that closes the goal with the supplied proof term.
Here, ``h.left`` is the proof term that results from applying left conjunction elimination to ``h``.
The ``have`` tactic introduces a new goal, in this case ``h₂ : p ∧ q``. It should be followed by
a tactic that closes the goal. Here, ``from h.left`` is a synonym for ``exact h.left``.

In the above proof, ``h₂.right`` is the proof term that results from applying conjunction elimination to ``h₂``.
As ``h₂`` is a proof of ``p ∧ q``, we have that ``h₂.right`` is a proof of ``q``.

Tactic-style Lean proofs are designed to be worked with *interactively*, not to be read. If you are
reading this online, click *try it* above to open the code snippet in a browser window. Note that
the first time you press *try it!*, a copy of Lean will be downloaded to your browser. This may take a 
few minutes.

At each point in the proof, Lean displays the *goal* (that which you are trying to prove) and the *context*
in a separate pane of your window.

At the start of the proof above, Lean will display the following, indicating that the context
consists of three propositional variables, ``p`, ``q``, and ``r``, together with the premise
``h : (p ∧ q) ∧ r``. The goal (indicated with the *turnstile* symbol ``⊢``) is that of proving ``q``.

.. code-block:: lean

  p q r : Prop,
  h : (p ∧ q) ∧ r
  ⊢ q

If you place your cursor after the line with the ``have`` statement, the context changes to the
following, in which ``h₂ : p ∧ q`` has been added.

.. code-block:: lean

  p q r : Prop,
  h : (p ∧ q) ∧ r,
  h₂ : p ∧ q
  ⊢ q

To make the proof more readable, you can use the ``show`` tactic. This tactic announces what
remains to be prove. Below, we follow ``show q,`` with ``from h₂.right``, which is a synonym
for ``exact h₂.right``.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r ) : q :=
  begin
    have h₂ : p ∧ q, from h.left,
    show q, from h₂.right,
  end
  -- END

The above is a Lean representation of the following matheamtical proof.

  We have :math:`h_2 : P\land Q` by left conjunction elimination on :math:`h`. We show :math:`q`
  by right conjunction elimination on :math:`h_2`.

Rather than introducing an intermediate hypothesis ``h₂``, the proof can be carried out in one line.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : q :=
  begin
    show q, from (h.left).right
  end
  -- END

This can be written mathematically as follows.

  We show :math:`q` by right conjunction elimination applied to the result of left conjunction
  elimination applied to :math:`h`.

Alternatively, we can use the ``cases`` tactic, which performs left and right and elimination
simultaneously.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : q :=
  begin
    cases h with h₂ h₃, -- We have `h₂ : p` and `h₃ : q` by left and right conjunction elimination on `h`.
    exact h₂.right      -- The result follows by right conjunction elimination on `h₂`.
  end
  -- END

A mathematical statement of this proof would be:

This can be written mathematically as follows.

  We have :math:`h_2 : p \land q` and :math:`h_3 : r` by left and right conjunction elimination,
  respectively, on :math:`h`. The result follows by right conjunction elimination on :math:`h_2`.

Conjunction Introduction
------------------------

The rule of conjunction introduction can be expressed in two forms, forward and backward.

.. proof:mathsrule:: Conjunction introduction, forward

  Given :math:`h_1 : P` and :math:`h_2 : Q`, we have a proof of :math:`P\land Q`.

.. proof:mathsrule:: Conjunction introduction, backward

  To prove :math:`P\land Q`, it suffices to prove :math:`P` and :math:`Q`.

.. proof:example:: Commutativity of conjunction

  Given :math:`h : P \land Q`, we have a proof of :math:`Q \land P`.

We'll give both a forward and a backward proof.

.. proof:proof:: Forward Proof

  We have :math:`h_2 : P` and :math:`h_3 : Q` by left and right conjunction elimination on :math:`h`.
  The result follows by conjunction introduction on :math:`h_3` and :math:`h_2`.

Lean uses ``and.intro`` to represent forward conjunction introduction.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    have h₂ : p, from h.left,
    have h₃ : q, from h.right,
    exact and.intro h₃ h₂,
  end
  -- END

.. proof:proof:: Backward Proof

  By conjunction introduction, it suffices to prove 1. :math:`Q` and 2. :math:`P`.

  #. We show :math:`Q` from right conjunction introduction on :math:`h`.
  #. We show :math:`P` from left conjunction elimination on :math:`h`

Lean uses ``split`` to represent backward conjunction introduction. As used below, the ``split``
tactic replaces the goal of proving ``q ∧ p`` with two goals 1. to prove ``q`` and 2. to prove ``p``.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    split,
    show q, from h.right, 
    show p, from h.left,
  end
  -- END

If a rule of inference introduces multiple goals, it is good practice (though not required)
to enclose the proof of each new goal in braces. 

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    split,
    { show q, from h.right, },
    { show p, from h.left, },  
  end
  -- END

Associativity of conjunction, in parts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _example_and_comm1:

.. proof:example::
  
  Given :math:`h : (P \land Q)\land R`, we have a proof of :math:`P \land (Q\land R)`.

Here's a forward proof.

.. proof:proof::

  - We have :math:`h_2 : P\land Q` and :math:`h_3 : R` by left and right conjunction elimination on :math:`h`.

  - We have :math:`h_4 : P` and :math:`h_5 : Q` by left and right conjunction elimination on :math:`h_2`.

  - We have :math:`h_6 : Q \land R` by conjunction introduction on :math:`h_5` and :math:`h_3`.

  - The result follows by conjunction introduction on :math:`h_4` and :math:`h_6`.

The same proof can be represented in Lean.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
  begin
    cases h with h₂ h₃,     -- h₂ : (p ∧ q), h₃ : r
    cases h₂ with h₄ h₅,    -- h₄ : p, h₅ : q
    have h₆ : q ∧ r, from and.intro h₅ h₃,
    exact and.intro h₄ h₆,
  end
  -- END

Here's a proof of :numref:`Example %s <example_and_comm1>` that combines forward and backward reasoning.
reasoning.

.. proof:proof::

  - We have :math:`h_2 : P\land Q` and :math:`h_3 : R` by left and right conjunction elimination on :math:`h`.

  - By conjunction introduction, it suffices to prove 1. :math:`P` and 2. :math:`Q \land R`.

    #. We show :math:`P` from left conjunction elimination on :math:`h_2`.

    #. We show :math:`Q\land R`. By conjunction introduction, it suffices to show 1. :math:`Q` and 2. :math:`R`.

      #. We show :math:`Q` from right conjunction elimination on :math:`h_2`.

      #. We show :math:`R` from :math:`h_3`.

This proof can also be represented in Lean.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
  begin
    cases h with h₂ h₃,   -- h₂ : (p ∧ q), h₃ : r
    split,                -- Conjunction introduction
    { show p, from h₂.left, },
    { show q ∧ r, split,  -- Conjunction introduction
      { show q, from h₂.right, },
      { show r, from h₃ }, } , 
  end
  -- END


Of course, associativity also works in the other direction.

.. _example_and_comm2:

.. proof:example::
  
  Given :math:`h : P \land (Q\land R)`, we have a proof of :math:`(P \land Q)\land R`.

Here is an (incomplete) forward proof. Fill in each 'sorry' to complete the proof.

.. proof:proof::

  - We have :math:`h_2 : P` and :math:`h_3 : \text{sorry}` by sorry on :math:`h`.

  - We have :math:`h_4 : \text{sorry}` and :math:`h_5 : R` by left and right conjunction elimination on :math:`h_3`.

  - We have :math:`h_6 : P \land Q` by sorry.

  - The result follows by sorry.

Likewise, fill in each ``sorry`` to complete the forward Lean proof below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
  begin
    cases h with h₂ h₃,
    cases h₃ with h₄ h₅,
    have h₆ : p ∧ q, from sorry,
    sorry,
  end
  -- END

As an exercise, replace each sorry below to give a mixed forward and backward proof of
:numref:`Example %s <example_and_comm2>`.

.. proof:proof::

  - We have :math:`h_2 : P` and :math:`h_3 : \text{sorry}` by sorry on :math:`h`.

  - By conjunction introduction, it suffices to prove 1. sorry and 2. sorry.

    #. sorry

    #. sorry

Likewise, fill in each ``sorry`` to complete the forward and backward Lean proof below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
  begin
    cases h with h₂ h₃,
    split,
    { split,
      { sorry, },
      { sorry, }, },
    { sorry, },
  end
  -- END

Implication
===========

Theorems
========

If and only if
==============

Rewriting and implicit theorems
===============================

An introduction to existential quantification
=============================================

Disjunction
===========

False and negation
==================

Classical reasoning
===================





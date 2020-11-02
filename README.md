MTH1001 in Lean
---------------

Built using Sphinx and restructured text. Based on the documents *Theorem Proving in Lean* and *Mathematics in Lean* by Jeremy Avigad, et al.

# How to build

The project requires a Lean installation to test the snippets. Install the project with
```
leanproject new mathematics_in_lean
```
and use
```
leanproject up
```
to update.

The build requires python 3 (install `python3-venv` on ubuntu).

```
make install-deps
make html
make latexpdf
```

The call to `make install-deps` is only required the first time, and only if you want to use the bundled version of Sphinx and Pygments with improved syntax highlighting for Lean.

If you have trouble building the pdf file, see <https://github.com/sphinx-doc/sphinx/issues/5823>. In particular, on Ubuntu, you may need to install the package `fonts-freefont-otf`.


# How to test the Lean code snippets

```
make leantest
```

# How to deploy

```
./deploy.sh gihanmarasingha mth1001_sphinx
```

# Practical Deductive Verification of OCaml Programs

A tutorial on the use of the Cameleer tool and the Gospel
specification language to reason about programs written in the OCaml
language.

We show how to deductively verify the correctness of OCaml programs,
ranging from simple purely-functional implementations to imperative
programs mixing mutable effects and exceptions. In particular, this
tutorial includes the following examples/exercises:

  1. A merge routine for functional lists.
  2. Finding an element within an array.
  3. A functional implementation of the *same fringe* problem.
  4. The Boyre-Moore MJRTY algorithm.

## Organization of This Repository

This repository is organized as follows:

  - The `exercises/` folder contains the OCaml implementation of every
    selected example. On each file, you will find a set of challenges
    which normally amount to complete the specification of some
    function or to provide loop invariants.
  - The `solutions/` folder contains a complete solution for every
    exercise from the `exercises/` folder. This means you can find the
    full Gospel specification that allows you to completely verify an
    OCaml program using Cameleer.

## Installation Procedures

This tutorial has been extensively tested under a Linux machine. In
principle, it should be possible to install and run the same tools
under a MacOS environment (I have no idea what to expect for M
processors).

For Windows users, I suggest you to use the Windows Subsystem for
Linux (WSL). It is fairly easy to install a Linux distribution and
then you should be able to work normally.

### Prerequisites

The only software you should have already installed in your machine
is `opam`, the OCaml packages manager.

If you do not have `opam` already installed, please follow these
[instructions](https://opam.ocaml.org/doc/Install.html).

### Fresh opam Switch

To better follow this tutorial, we suggest you to install a fresh
`opam` switch. This will avoid any conflicts between pre-installed
OCaml packages.

Use the following command:

```
  opam switch create cameleer-tutorial ocaml-base-compiler.4.14.0
```

This might take a while. After the installation procedure succeeds,
`opam` might ask to update your current environment. This is as
follows:

```
  eval $(opam env)
```

### The Cameleer Tool

First, you should clone the `master` branch from the Cameleer Github
repository. Proceed as follows:

```
  git clone git@github.com:ocaml-gospel/cameleer.git
```

This will create a `cameleer` folder in your machine. Change to that
folder

```
  cd cameleer
```

and then install the package using

```
  opam pin add . -y
```

Not only this will install Cameleer as it will also install all the
needed dependencies, namely

  - the `gospel` specification language compiler and standard library
  - `why3`, the Why3 verification framework and toolset
  - `why3ide`, the interactive graphical user interface.

Use `opam` to install, as well, some SMT solvers that we will be using
during the tutorial:

```
  opam install alt-ergo z3 -y
```

I also recommend you to install the CVC5 solver. The easiest way is
to download one of the pre-built binaries from the [GitHub release
page](https://github.com/cvc5/cvc5/releases/). I will be using the
release `cvc5-1.0.6` so this might also be a good choice for you. Move
the downloaded binary to a common Linux folder. For instance,
`usr/local/bin` is a very good choice.

### Running Cameleer

Before actually running Cameleer on some proof, we need to register
the installed solvers on Why3 configuration database. Proceed as
follows:

```
  why3 config detect
```

The output of this command is the list of all the supported SMT
solvers, together with their versions, that Why3 was able to find in
you machine. These are the solvers that you can use during a proof.

**Note 1**: for now, just ignore any warning that Why3 might issue about
unsupported versions of the solvers.

**Note 2**: if you do not see CVC5 solver among those detected by
Why3, it might be the case you need to fix something about the
downloaded `cvc5` binary. Try the following:

  1. change the name of the file from `cvc5-Linux` to simply `cvc5`
  2. make it executable: `chmod +x cvc5`

Run `why3 config detect` again and check whether CVC5 is now on your
list of detected solvers.

Now, to actually test your Cameleer installation, write the following
OCaml program

```
  let next x =
    x + 1
  (*@ r = next x
        ensures r > x *)
```

and save it on file `next.ml`. Now, run

```
  cameleer next.ml
```

This should immediately bring up the Why3 IDE, where you can start
your proof (please ignore any warnings Why3 might issue about
"Unrecognized source format `ocaml`"). On the IDE, can select the
`next` function node, on the left-hand side of the window, and then
choose the solver you want to use to verify this function. Do that
either by right-clicking on the node, and then selecting the solver
from the drop-down menu; or type the name of solver on the interactive
bar (right-hand side of the window, on the middle). Any solver should
easily discharge the generated Verification Conditions for the `next`
function.

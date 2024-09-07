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

### Fresh opam switch

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
folder:

```
  cd cameleer
```

```
  opam pin add . -y
```

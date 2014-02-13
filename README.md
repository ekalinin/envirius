envirius
========

``envirius`` — universal virtual environments manager.

Features
========

Usually this kind of tools narrowly specialized for a  particular
programming language. For example:

  * [virtualenv](https://github.com/pypa/virtualenv/) for python
  * [rvm](https://github.com/wayneeseguin/rvm/) for ruby
  * [kerl](https://github.com/spawngrid/kerl/) for erlang
  * [nvm](https://github.com/creationix/nvm)/[nodeenv](https://github.com/ekalinin/nodeenv/) for node.js
  * and so on

But there are many cases when in one and the same environment you must have more
than one programming language. For example, to create an environment with
``python2.6`` and ``node.js 0.10.24``. This idea underlies ``envirius``.

Support for new programming languages are implemented as plug-ins.

Installation
============

At first:

```bash
$ git clone git@github.com:ekalinin/envirius.git
$ cd envirius
$ make install
```

Then youd need to add into your ``.bashrc`` the following:

```bash
# activate envirius itself
# (mandatory part)
if [ -e "~/.envirius/nv" ] ; then
    . ~/.envirius/nv
fi

# auto environment activation
# when navigate to folder with '.envirius' file
# (optional part)
if [ -e ".envirius" ] ; then
    nv on `cat .envirius`
fi
```

Usage
=====

To check available plugins:

```bash
➥ nv plugins
erlang
rust
```

To check available versions for each plugin:

```bash
➥ nv versions --rust --erlang
* rust:
0.1         0.2         0.3         0.4         0.5
0.6         0.7         0.8         0.9
* erlang:
R10B-0    R10B-10   R10B-1a   R10B-2    R10B-3    R10B-4
R10B-5    R10B-6    R10B-7    R10B-8    R10B-9    R11B-0
R11B-1    R11B-2    R11B-3    R11B-4    R11B-5    R12B-0
R12B-1    R12B-2    R12B-3    R12B-4    R12B-5    R13A
R13B      R13B01    R13B02-1  R13B02    R13B03    R13B04
R14A      R14B      R14B01    R14B02    R14B03    R14B04
R15B      R15B01    R15B02    R15B02    R15B03-1  R15B03
R16A      R16B      R16B01    R16B02    R16B03-1  R16B03
17.0-rc1
```

To create an environment:

```bash
➥ nv mk mixed-rust-erlang --rust=0.9 --erlang=17.0-rc1
Creating environment: mixed-rust-erlang ...
 * installing rust==0.9 ...
 * done (in 5 secs.)
 * installing erlang==17.0-rc1 ...
 * done (in 11 secs.)
```

Get list of the environments:

```bash
➥ nv ls
Available environment(s):
mixed-rust-erlang
rust-0.9
erl-17-rc1
```

To activate environment:

```bash
➥ mem on mixed-rust-erlang
Environment mixed-rust-erlang activated.
```

To check if environment activated:

```bash
➥ nv current
mixed-rust-erlang
```

To deactivate environment:

```bash
➥ nv off
Environment mixed-rust-erlang was deactivated.
```

How to add a plugin?
====================

All plugins are in the directory ``nv-plugins``.

Mandatory elements
-------------------

Every plugin must contain at least the following functions:

* *plug_list_versions*
* *plug_install* 

Optional elements
-----------------

* *plug_list_versions_columns_count*
* *plug_list_versions_columns_size*
* *plug_state*

Dependencies
============

* bash
* curl / wget
* tar
* gcc
* bats

Tests
=====

Most of the code is covered by tests. For testing
[bats](https://github.com/sstephenson/bats) was used.

Version History
===============

See [CHANGELOG.md](https://github.com/ekalinin/envirius/blob/master/CHANGELOG.md).

License
=======

See [LICENSE](https://github.com/ekalinin/envirius/blob/master/LICENSE).

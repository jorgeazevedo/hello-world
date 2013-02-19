# Hello, world!

This is version 1.0 of a simple hello world program whose purpose is not to
illustrate how to program, but what to do after the program is finished.
Namely, how to publish a piece of software under the GPL and package it for
distribution in Debian systems.

## Dependencies

Most of this package's dependencies are fullfilled by `build-essentials`. In
addition to this, you need `git` and `help2man`.

## Installation

See INSTALL file for building and installation instructions.

## Usage

Running

    $ hello-world

Should yield the message

    Hello, world!

## Source tree

The source tree purposely borders on the trivial. It contains a `main.c` - the
entry point for the application -  and the respective `Makefile` in the root
directory. 

## Copyright and license

Copyright (C) 2013 Jorge Azevedo

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see http://www.gnu.org/licenses/.

See the file COPYING for copying conditions.

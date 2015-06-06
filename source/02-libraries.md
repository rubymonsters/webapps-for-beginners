# Using Libraries

Being able to stand on the shoulders of giants is one of the great advantages
when we pick a programming language that has a great ecosystem, and an even
more awesome community:

Being faced with a certain task that we want to accomplish we can often look
for other peoples' solutions, and simply re-use and build on their code.

In the chapter <a href="http://ruby-for-beginners.rubymonstas.org/bonus_2/libraries.html">Using Libraries</a>
you have learned that Ruby comes with lots of things available as soon as your
program starts, but others need to be loaded using the method `require`. For
example we did `require "digest"` and from then on there's a class
`Digest::SHA2` defined, which provides some handy tools (methods) that we
really wouldn't want to write ourselves.

But how exactly does that work?

In order to understand how external code is loaded in maybe 99% of all Ruby
applications out there nowadays you'll need to understand the following concepts
which we'll walk through:

* The Ruby Standard Library
* Rubygems and Bundler
* The Ruby load path


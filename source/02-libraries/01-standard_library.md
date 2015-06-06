# Ruby Standard Library

*Batteries included*

Basically every programming language that you'll use in practice has some kind
of standard library that is shipped with the language itself.

When you install Ruby on your computer this will also install the <a
href="http://ruby-doc.org/stdlib-2.2.2/">Ruby Standard Library</a>. This means
you can simply `require` and use the things it includes.

Its documentation isn't the most pretty website on earth, but if you look at
the "package" (library) names on the left you see things mentioned like:

* `benchmark`: tools to test how performant your code is
* `debug`: tools to make debugging code easier
* `digest`, `openssl`, `securerandom`: tools for encryption and security
* `erb`: Ruby's standard templating system
* `net/imap`, `net/pop`, `net/smtp`: stuff for sending and receiving emails
* `zlib`: tools for compressing files (you know `zip` files, don't you?)

And a lot of other things. These are fairly low-level tools, of course. You do
not see a library for "logging in via Twitter or Google". They're more like
nuts and bolts, rather than bicycles or cars, but they're super useful
nonetheless.

In order to make one of these libraries available in your code you don't have
to do anything else other than use `require`. E.g. `require "zlib"` would make the
<a href="http://ruby-doc.org/stdlib-2.2.2/libdoc/zlib/rdoc/Zlib.html">zlib
library</a> available, which means you could now use the methods `deflate` and
`inflate` in order to compress and decompress files.


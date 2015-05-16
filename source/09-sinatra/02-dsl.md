# Domain specific languages

Sinatra, on its homepage, does not call itself a framework. Instead it calls
itself a DSL, so let's talk about that, too.

DSL is short for "Domain specific language", and you might find that term used
in the Ruby world once in a while. "Domain" in this case refers to the "problem
at hand", or rather the context of the problem. What does that mean?

Consider a book shop application, such as Amazon, back when it still sold
nothing but books.  The domain of this application would be the entirety of
concepts that their users have in mind, and that they care about when they use
it. In this example this would include things like: books, categories, a
shopping cart, payment methods, delivery addresses, and so on.

A domain specific language is a language that includes terms to speak about
these concepts. In the context of a library that means, there are classes
and methods that allow to "speak about them", or implement them, in the form
of code.

Ruby makes it very easy to implement a DSL. In the case of Sinatra this means
that it supports methods like `get`, `post`, `put`, and `delete`. It also
has methods like `headers`, `session`, `cookies`, and other things that
relate to concepts from HTTP.

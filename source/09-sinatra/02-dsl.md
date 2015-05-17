# Domain specific languages

Sinatra, on its homepage, does not call itself a framework. Instead it calls
itself a DSL, which is quite a common term in the Ruby world.

So let's talk about that for a moment, too.

DSL is short for <a href="http://en.wikipedia.org/wiki/Domain-specific_language">"Domain specific language"</a>.
"Domain" in this case refers to the "problem domain", i.e. the "problem at
hand", or rather the context of the problem. The domain where a solution or
tool can be applied.

What does that mean?

When you think about a hammer as a concept, then the domain the is relevant to
is "building physical things". In contrast, it is completely irrelevant to the
domain of mathmatics. Likewise, the concept of an operating system, is
something that is relevant in the domain of using computers, while it is
entirely irrelevant in the domain of baking pizza.

Applications are built to solve problems in a certain domain. In a commercial
context the domain often is what a business' customers care about.

Consider a book shop application, such as Amazon, back when it still did
nothing else but selling books. The domain of this application is the entirety
of concepts that their users have in mind, and that they care about when they
use it. In our example the domain would include concepts like: books,
categories, a shopping cart, orders, payment methods, delivery addresses, and
so on.

A domain specific language is a language that includes terms to speak about
these concepts: *"Books can be placed into a shopping cart."* or *"A shopping cart
can be checked out, which will place an order."*

In the context of Ruby code the term "domain specific language" is used to
describe a piece of code or library that provides classes and methods that
allow to "speak about them", or implement them, in the form of code.

The problem domain that Sinatra lives in is building web applications, which
speak HTTP:

It has methods like `get`, `post`, `put`, and `delete`, which you can use in
order to describe how your application responds to HTTP requests. It also has
methods like `headers`, `session`, `cookies`, and other things that relate to
concepts from HTTP.

Does that make sense?

In short, the term DSL is used for libraries that allow you to write very
descriptive, narrative Ruby code that "speaks" about the solution to the
problem in this domain.

# Domain specific languages

On its homepage Sinatra does not call itself a framework. It calls itself a DSL, which is quite a common term in the Ruby world.

So let's talk about that for a moment.

DSL is short for <a href="http://en.wikipedia.org/wiki/Domain-specific_language">"Domain specific language"</a>. "Domain" in this case refers to the "problem domain", i.e. the problem your code is trying to solve. Or rather, the context of the problem. The domain where a solution or tool is applied.

What does that mean?

When you think about a hammer, its domain is building physical things. But it is irrelevant to the domain of mathematics. Likewise, an operating system's domain is the management of a computer's resources. But it is entirely irrelevant to the domain of baking pizza.

Applications are built to solve problems in a certain domain. In a commercial context the domain is typically what a business' customers care about when they use it.

Consider a book shop application, such as Amazon. (Back when all it did was sell books!) Amazon's domain included concepts like: books, categories, shopping, orders, payments, deliveries, and so on.

A domain specific language is a language that includes terms to speak about the concepts in its domain. e.g.: *"Books can be placed into a shopping cart"*, or *"A shopping cart can be checked out, which will place an order"*.

In the context of Ruby code, a "domain specific language" is a piece of code or a library that provides classes and methods that allow us to speak about a domain in the form of code.

The problem domain that Sinatra lives in is building web applications – web applications that _speak_ to browsers using HTTP.

It therefore has methods like `get`, `post`, `put` and `delete`. You can use these methods in order to describe how your application responds to HTTP requests. It also has methods like `headers`, `session`, `cookies`, which relate to HTTP concepts.

So instead of writing verbose code like this:

```ruby
def handle_request(method, path)
  if method == "GET"
    [200, { "Content-Type" => "text/html" }, ["You have requested the path #{path}, using GET"]]
  else
    [405, {}, ["Method not allowed: #{method}"]]
  end
end
```

Sinatra lets us write:

```ruby
get "/some/path" do
  "You have requested the path /some/path"
end

post "*" do
  status 405
end
```

As you can see this code uses a "language" (i.e. methods provided by Sinatra) that is specific to the domain HTTP.

<p class="hint">
The term DSL is used for libraries that allow you to write descriptive, narrative Ruby code that "speaks" about the solution to a problem using terms that are specific to the problem domain.
</p>

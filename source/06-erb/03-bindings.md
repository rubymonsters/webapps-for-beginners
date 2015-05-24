# Bindings

Now, what's this `binding` thing used in our code?

```ruby
html = ERB.new(template).result(binding)
```

Obviously we do not define a local variable, so it needs to be a method. Let's
google that: <a href="http://www.google.com/?q=Ruby+binding">Ruby binding</a>

The first result goes to the <a href="http://ruby-doc.org/core-2.2.0/Binding.html">Ruby documentation</a>,
saying (some rather cryptic stuff stripped for our purpose):

*"Objects of class Binding encapsulate the execution context at some particular
place in the code and retain this context for future use. The variables,
methods, [...] that can be accessed in this context are all retained. Binding
objects can be created using Kernel#binding [...]. These binding objects can be
passed [around]."*

Hmmmmm, let's re-read that, and think about it.

First of all, <a href="http://ruby-doc.org/core-2.2.2/Kernel.html">Kernel</a>
is something we have never mentioned so far. It is a
<a href="http://ruby-for-beginners.rubymonstas.org/bonus_2/modules">Ruby module</a>
that is included into the class `Object`. That means that, whenever you create
any object, this module, and thus all of its methods, will be included.  Since
Ruby's top level scope is also an object, `binding` is defined there too. This
is also, by the way, the secret reason why methods like `p`, `puts`, and so
on are available everywhere: they're defined in `Kernel`.

Now, what's this execution context the documentation is talking about?

Remember when we talked about <a href="http://ruby-for-beginners.rubymonstas.org/methods/scopes.html">scopes</a>
in the context of methods? That's the same as the Ruby documentation means by
"execution context".  It is that empty room or space that Ruby enters whenever
it starts your program, or enters a method. If you define a *local* variable,
then this variable will be visible within this scope, or room, or "execution
context", but not outside of it.

Now the `binding` keeps exactly *this knowledge*: what variables are defined,
and what objects they are referring to. And the `binding` itself is an object
that can be passed around.

If you find this confusing don't worry:

All of this is knowledge that many Ruby programmers don't need, or at least
very rarely use themselves. Advanced programming techniques aside (like "meta
programming") rendering ERB templates is the one single situation where you'd
ever need it. And, on top of this, as a Sinatra or Rails developer you also
never need it because both Sinatra and Rails ship tools that hide this weird
stuff from you.

For now, the one thing you can remember is that by calling `binding` and
passing the result to the ERB instance, you simply pass *access* to the two
local variables `name` and `messages`, so they can be used inside your ERB
template.

Does this make sense?

Then maybe it's a good time for an
<a href="/exercises/mailbox_erb.html">exercise on ERB</a>.

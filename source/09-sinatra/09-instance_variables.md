# Using instance variables

So far we've passed data to our templates using the `:locals` option key which
holds a hash.

Sinatra supports a second way of passing data, which uses instance variables.
We mention this mostly because this is also the "Rails way" of passing data to
your templates (views).

Let's change our template to use an instance variable `@name`, like so:

```erb
<h1>Hello <%= @name %></h1>
```

If we now assign the same instance variable in our route, then Sinatra will
make it available to the template, too:

```ruby
get '/monstas/:name' do
  @name = params["name"]
  erb :monstas
end
```

This also is a little bit more concise, and spares a few keystrokes.

So, which way is the better one?

On one hand there's an argument that using the `:locals` way is the cleaner,
and "right" way of doing it: These two objects (our route, and the template)
should be separated clearly, and not simply share things.  On the other hand
using instance variables is much more common due to the fact that Rails
encourages it.

As always, you should just use whatever feels better to you, and maybe ask your
friends and fellow developers for their opinions and reasons.


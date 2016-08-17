# Rendering templates

So far, our application does not actually return HTML, it returns just plain
text.

Let's fix that.

For this we'll want to re-use what we've learned about rendering ERB templates.
In order to use ERB we need to require it, define an ERB template, and make any
variables used in the template known as local variables in our route:

```ruby
require "sinatra"
require "erb"

get '/monstas/:name' do
  ERB.new("<h1>Hello <%= params[:name] %></h1>").result(binding)
end
```

This code is familiar to you, isn't it?

We get use `params[:name]` in the template because `params` is "known" in the
scope that is passed as part of the `binding`. The rest is just the same
as in our examples in the chapters about <a href="/erb.html">ERB</a>

If you restart the server, and reload the page in your browser, it should now
look like this:

<img src="/assets/images/09-sinatra_2.png">

Awesome, we're now serving HTML, not just plain text.

However, Sinatra also has built-in support for ERB templates ("views"). We can
achieve exactly the same thing without spelling out the
`ERB.new(...).result(binding)` noise:

```ruby
get '/monstas/:name' do
  erb "<h1>Hello <%= name %></h1>", { :locals => { :name => params[:name] } }
end
```

I.e. Sinatra has a method `erb` that hides all the details of rendering the
template from us, and also accepts a template.

On top of this, it also accepts a hash that allows us to specify various
options. If we specify a key `:locals` and give it another hash, then Sinatra
will make each key/value pair on this hash available as *local* variables (thus
"locals") in our ERB template.

Of course, since `params` already is a hash, and it already has the key `name`
defined, we can also just say:

```ruby
get '/monstas/:name' do
  erb "<h1>Hello <%= name %></h1>", { :locals => params }
end
```

Nice, isn't it.

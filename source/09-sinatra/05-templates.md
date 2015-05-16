# Rendering templates

So far, our application does not actually return HTML, it returns just plain
text. Let's fix that. For this we'll want to re-use what we've learned about
rendering ERB templates.

In order to use ERB we need to require it, we need to define a ERB template,
and make any variables used in the template known as local variables in our
route:

```ruby
require "erb"

get '/hello/:name' do
  name = params[:name]
  ERB.new("<h1>Hello <%= name %></h1>").result(binding)
end
```

This code is familiar to you, isn't it? We get the name out of the params hash
and stick it into a local variable `name` because that's the variable name we're
using in our template, too.

If you restart the server, and reload the page in your browser, it should now
look like this:

<img src="/assets/images/09-sinatra_2.png">

Awesome.

However, Sinatra also has built-in support for ERB templates ("views"), and
allows us to achieve exactly the same thing like this:

```ruby
get '/hello/:name' do
  erb "<h1>Hello <%= name %></h1>", { :locals => { :name => params[:name] } }
end
```

I.e. Sinatra has a method `erb`, that hides all the details of rendering the
template from us, and also accepts a template. On top of this, it also accepts
a hash that allows us to specify options. If we specify a key `:locals` and
give it another hash, then Sinatra will make each key/value pair on this hash
available as *local* variables (thus "locals") in our ERB template.

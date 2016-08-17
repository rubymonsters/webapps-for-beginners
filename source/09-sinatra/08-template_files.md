# Template files

So far we've defined our templates as strings right inside our route. That
worked well because our templates were ridiculously small. Of course, any
real application will have much bigger templates. Managing these inside
our routes would get pretty messy pretty quickly.

It is, therefore, better to store them in separate files. And again, Sinatra
has built-in support for that: when we call the method `erb` with a symbol
instead of a string, then Sinatra assumes this is part of a filename, and
it will look for a template file in a directory `views`.

Let's create a new directory `views`, and add a file `monstas.erb`, containing
our template:

```erb
<h1>Hello <%= name %></h1>
```

Also, add a file `layout.erb` with our layout template:

```erb
<html><body><%= yield %></body></html>
```

Now we are ready to change our route as follows:

```ruby
get '/monstas/:name' do
  erb :monstas, { :locals => params, :layout => :layout }
end
```

Restart your application, and reload the page. You should see the same result.

But our code looks much better this way, doesn't it?

Interestingly, we don't even need the name the layout. Sinatra looks for
this filename by default (we could specify a different name though, in case
we need different layout templates in different contexts):

```ruby
get '/monstas/:name' do
  erb :monstas, { :locals => params, :layout => true }
end
```

And finally, we can also even totally omit the option, because Sinatra
assumes we want a layout and finds one in the `views` directory:

```ruby
get '/monstas/:name' do
  erb :monstas, { :locals => params }
end
```

If we don't want a layout, for some reason, then we can pass `:layout => false`
instead.

Neat.

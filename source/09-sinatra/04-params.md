# Params

Sinatra allows specifying patterns for paths. It will match the pattern
against the path, and see if it applies. Let's try that out.

Add the following route (request handler) to your program, at the end of the
file:

```ruby
get "/hello/:name" do
  "Hello #{params["name"]}!"
end
```

... and restart your Sinatra application, then point your browser to
<a href="http://localhost:4567/hello/monstas">http://localhost:4567/hello/monstas</a>.

How does this work?

`params` is a hash that Sinatra makes available for you in your route blocks, and
it will automatically include relevant data from the request.

In our case our route specifies a path that is a pattern: the last part of the
path starts with a colon `:`. This tells Sinatra that we'd like to accept any
string here, and that we'd like to call this string `name`. Sinatra therefore
adds the key `"name"` to the `params` hash, and sets the given string from the
path (i.e. from the URL) to it.

When you point your browser to the URL
<a href="http://localhost:4567/hello/Elizabeth">http://localhost:4567/hello/Elizabeth</a>
your application will say *"Hello Elizabeth!"*, when you go to
<a href="http://localhost:4567/hello/Juliane">http://localhost:4567/hello/Juliane</a>
your application will say *"Hello Juliane!"*, and so on.

Let's inspect the params hash, and return this string as the response body:

```ruby
get "/hello/:name" do
  params.inspect
end
```

If you restart your application, and reload the page in your browser, then it
should display something like this:

```
{"splat"=>[], "captures"=>["monstas"], "name"=>"monstas"}
```

So this confirms that `params` is a hash, and the key `"name"` has the value
`"monstas"` set.  `splat` and `captures` are for building more complicated
routes, and we can ignore these for now.

This is pretty cool.

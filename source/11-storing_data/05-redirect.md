# Using Redirects

After handling a `POST` (or `PUT` or `DELETE`) request, in today's web
applications it is common to redirect the browser to the page that displays the
changed state:

Our application would respond: *"Alright, I've done this! Go here, check it out!"*

The way of expressing this in terms of HTTP is returning the status code `303
See Other`, and adding a `location` header to the response that tells the
browser where to go (what to `GET`) next.

```http
HTTP/1.1 303 See Other
Location: http://localhost:4567/monstas
```

Hmm, ok. But how do we achieve that in Sinatra?

Remember Sinatra calls itself a DSL? It has a method `redirect` for that:

```ruby
post "/monstas" do
  @name = params[:name]
  store_name("names.txt", @name)
  redirect "/monstas"
end
```

The `redirect` method will make sure our application responds with the status
code `303` and add a `location` header to the response with the value
`http://localhost:4567/monstas` (since we have passed the path `/monstas`, but the
`location` header needs a full URL).

We also want to see the the Welcome message when we post a new name. For that to
work, we can redirect to `"/monstas?name=#{@name}"`. Our `GET` route will then
include ("render") the name into the HTML page:

```ruby
post "/monstas" do
  @name = params[:name]
  store_name("names.txt", @name)
  redirect "/monstas?name=#{@name}"
end
```

If you restart the server, go to <a href="http://localhost:4567/monstas">http://localhost:4567/monstas</a>,
and submit the form you'll see that your browser will be redirected, and make
a new `GET` request to the same URL.

So this is pretty cool. We now have two routes: One for displaying (`GET`ing)
the current state of our application, and one for storing (`POST`ing) new data.

Awesome!

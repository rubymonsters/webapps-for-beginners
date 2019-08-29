# Routes

In Sinatra, calls to methods like `get`, `post`, `put` and `delete` are called
*routes*. They take a path, and a block that handles a request.

What's up with the term "route"?

The request is being picked up by the webserver, and then *routed* to a piece
of code that handles the request, and specifies the response. They're like the
info desk at a shopping mall: You (as an HTTP request) walk up to them, and
tell them `GET /something`. They'll route (direct) you to a certain shop on a
certain floor where you can find what you're after.

So, here are three Sinatra routes:

```ruby
get "/" do
  "OMG, hello Ruby Monstas!"
end

get "/signup" do
  "Here you can sign up for the next beginners course."
end

post "/signin" do
  # do something to sign in the user
end
```

When a request comes in Sinatra will look at the request method and path, and:

* Try to match it with the first route.
* If it does not match, Sinatra will try the next route, and so on.
* Once Sinatra matches the request to a route, it will call the block under the route and return a response to the browser. Sinatra won't try any subsequent routes.
* If no route matches, Sinatra responds with a `404 Not Found`.


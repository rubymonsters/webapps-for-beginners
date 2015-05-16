# Using POST

Ok, that's pretty cool. However, there's one big problem with our application
that we definitely want to fix.

The HTTP specification says that `GET` requests should be safe, and idempotent.
What does that mean? <a href="http://en.wikipedia.org/wiki/Idempotence">Wikipedia says</a>:

*"Idempotence is the property of certain operations in mathematics and computer
science, that can be applied multiple times without changing the result beyond
the initial application."*

Obviously, whenever we reload the URL our application adds the name again, and
again, and again. Since we do this in response to a `GET` request we do not
comply with the HTTP specification.

When we store, modify, or delete data in our application we also say that we
"change the state" of the application: It goes from "3 names stored" to "4
names stored".

`GET` requests should not modify the state of our application though. They
should only "get" what's already there. So what do we do?

The appropriate HTTP verb (request method) to use for this kind of request
is `POST`. The result of a `POST` request does not need to be idempotent,
and it's basically up to the application to decide what to do with it.

In order to tell the browser to send a `POST` request instead of a `GET`
request we add this as an attribute to the `<form>` tag like so:

```html
<form action="/monstas" method="post">
  <input type="text" name="name" value="<%= @name %>">
  <input type="submit">
</form>
```

When you reload the page, and try to submit the form again, you'll get
Sinatra's 404 (Not Found) page though: "Sinatra doesn’t know this ditty."

Of course, we do not have a route for `POST` requests, yet. So let's add
one, and more the logic for storing the name to it:

```ruby
get "/monstas" do
  @names = read_names
  erb :monstas
end

post "/monstas" do
  store_name("names.txt", params[:name])
end
```

Cool, our `get` route is now idempotent (it does not change any state), and we
also have a `post` route for the same path, and we store the name if there is
one. However, what should we now send back to the browser in response?

For starters, we could just send a little confirmation:

```ruby
post "/monstas" do
  store_name("names.txt", params[:name])
  "Ok!"
end
```

<img src="/assets/images/11-storing_data_2.png">

Hmmmm. Ok, this isn't too bad, we could make this a proper HTML template.

However, in today's web applications it is more common to redirect the browser
to the page that displays the changed state: The web application would respond
to the `POST` request by saying *"Alright, I've done this. Go here to check it
out."*

The way of expressing this in terms of HTTP is by the way of returning the
status code `303` ("See Other"), and adding a `location` header to the response
that tells the browser where to go (what to `GET`) next.

Sinatra lets us do this like so:

```ruby
post "/monstas" do
  name = params[:name]
  store_name("names.txt", name)
  redirect "/monstas"
end
```

The `redirect` method will make sure our application responds with the status
code `303` and add a `location` header to the response with the value
`http://localhost:4567/monstas` (since we have passed the path `/monstas`, but the
`location` header needs a full URL).

If you restart the server, go to <a href="http://localhost:4567/monstas">http://localhost:4567/monstas</a>,
and submit the form you'll see that your browser will be redirected, and make
a new `GET` request to the same URL.

So this is pretty cool. We now have two routes. One for displaying (`GET`ing)
the current state of our application, and one for storing (`POST`ing) new data.

Awesome!

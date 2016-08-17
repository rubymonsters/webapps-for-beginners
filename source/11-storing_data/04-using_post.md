# Using POST

Ok, our little application is already pretty cool, isn't it?

However, there's one big problem that we definitely want to fix: The HTTP
specification says that `GET` requests should be safe, and idempotent.

What does that mean? <a href="http://en.wikipedia.org/wiki/Idempotence">Wikipedia says</a>:

*"Idempotence is the property of certain operations in mathematics and computer
science, that can be applied multiple times without changing the result beyond
the initial application."*

Obviously, whenever we reload the URL our application adds the name again, and
again, and again. Since we do this in response to a `GET` request we do not
comply with the HTTP specification: we do change the result, the HTML that
is returned.

When we store, modify, or delete data in our application we also say that we
"change the state" of the application: It goes from "3 names stored" to "4
names stored".

`GET` requests should not modify the state of our application according to the
HTTP specification. They should only "get" what's already there, and not change
it. So what do we do?

The appropriate HTTP verb (request method) to use for this kind of request is
`POST`. The result of a `POST` request does not need to be idempotent, and it's
basically up to the application to decide what to do with it.  In modern
applications `POST` usually means "add this thing to the collection", where
"the collection" is defined by the path: In our case we want to add a name to
the collection `monstas`.

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

Of course!

We do not have a route for `POST` requests, yet. Remember how the HTTP verb is
a key part of the HTTP request? And Sinatra wants us to use these verbs in
order to define our route.

So let's add one, and move the logic for storing the name to the new
route:

```ruby
get "/monstas" do
  @name = params["name"]
  @names = read_names
  erb :monstas
end

post "/monstas" do
  @name = params["name"]
  store_name("names.txt", @name)
end
```

Cool!

Our `get` route is now idempotent (it does not change any state), and we also
have a `post` route for the same path, and we store the name if there is one.

However, what should we now send back to the browser in response?

For starters, we could just send a little confirmation:

```ruby
post "/monstas" do
  @name = params["name"]
  store_name("names.txt", @name)
  "Ok!"
end
```

<img src="/assets/images/11-storing_data_2.png">

Hmmmm. Ok, this isn't too bad, we could make this a proper HTML template.

However, where would the user go next? Shouldn't we display the updated
list of all the names next?


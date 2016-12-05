# Sessions in Sinatra

Building on top of cookies, even though HTTP itself does not have a concept of a
"session" (or conversation), Sinatra, like basically any web application
tool or framework, supports sessions.

A session is a way for a web application to set a cookie that persists
an identifier across multiple HTTP requests, and then relate these requests
to each other: If you've signed in before the web application will be able to
know that you're still the same user you've identified as a couple requests
earlier. If you've done something else before, and something has been stored
to your session, then the web application will be able to use it later.

In our example we'll persist (store) a short confirmation message across two
requests: The `POST` request will store the message, and redirect the browser
to another URL. The browser will make that `GET` request, and we'll display
the confirmation message.

Let's have a look how this works.

Say the message we'd like to pass from our `POST` route to the next request is
*"Successfully stored the name [name]"*. I.e. after storing the name to the
file, we'd like to pass a message to the `GET` request that the browser is
going to be redirected to later.

In order to make this work we first need to enable the `:sessions` feature in
Sinatra. You can do that by adding this line above of your routes:

```ruby
enable :sessions
```

Now, we want to store the message in our `post` route:

```ruby
post "/monstas" do
  @name = params["name"]
  store_name("names.txt", @name)
  session[:message] = "Successfully stored the name #{@name}."
  redirect "/monstas?name=#{@name}"
end
```

Ok, cool.

The `session` looks like a simple Ruby hash, but if we store something to it
then Sinatra will set a cookie for us. It does so by sending a `Set-Cookie`
header along the reponse. This header will have a long, messy looking,
encoded string as a value.

In my browser it looks like this:

```
Set-Cookie: rack.session=BAh7CUkiD3Nlc3Npb25faWQGOgZFVEkiRWI4OTdhMDJlNDBkMDFlNjcxNWUw%0AZGI1ZWU5MzQ0YTQyMjAzYjFiZTE2YzYxNzgwMWQxYjI3NzhiOWNhYTQ4YzUG%0AOwBGSSIJY3NyZgY7AEZJIiU2ZjdjN2Y0ZmM0MTdmMGJkNjBkNmY5MmQ1NDEx%0ANGQ4ZgY7AEZJIg10cmFja2luZwY7AEZ7B0kiFEhUVFBfVVNFUl9BR0VOVAY7%0AAFRJIi03NGNlNDIxYTczNjMwZDY3MWViNTlkYzIzN2YyN2M5NGU3ZWU4NTRm%0ABjsARkkiGUhUVFBfQUNDRVBUX0xBTkdVQUdFBjsAVEkiLTA3NjBhNDRjMzU0%0AODIxMzJjZjIyNDQyYTBkODhjMDhiYjg1NTYyNTAGOwBGSSIIZm9vBjsARkki%0ACGJhcgY7AFQ%3D%0A; path=/; HttpOnly
```

Wow. Ok, the name of the cookie gives us a hint that this is a session, and it
is managed by Rack, which is what Sinatra uses under the hood to persist the
session.

Luckily we do not need to understand how exactly it does this. All we need to
know is that we can now use this data in the next request (the `GET` request)
like so:

```ruby
get "/monstas" do
  @message = session[:message]
  @name = params["name"]
  @names = read_names
  erb :monstas
end
```

I.e. we grab `:message` from our session, and stuff it into the instance variable `@message`.
Doing so we can then disply it in our view:

```erb
<% if @message %>
  <p><%= @message %></p>
<% end %>
```

Let's try it out. Restart your application, and go to <a href="http://localhost:4567/monstas">http://localhost:4567/monstas</a>.
If you enter a name, and click submit you should then see something like this:

<img src="/assets/images/12-sessions_1.png">

How does this work?

In our `post` route we store the message to the session hash. This is
something Sinatra provides to us as developers. When we enable this
feature Sinatra will, after every request, store this hash to a cookie
with the name `rack.session`, in the encoded form that you saw above.

We say the hash is being <a href="http://en.wikipedia.org/wiki/Serialization">serialized</a>,
which is a fancy way of saying it is turned into some kind of format that
can be stored in text form. Sinatra (actually, Rack, under the hood) then also
encrypts and signs this data, so it is safe to send it over the internet (in
case we keep any sensitive data in it). Thus hackers cannot easily tamper
with it, it is a shared secret between our web application (Sinatra) and us
(our browser).

Ok, so the `post` route includes the `Set-Cookie` header with this session
cookie in its response, and sends it to the browser. The browser will, from
now on, pass this cookie back to our application as part of every subsequent
request. That's how cookies work: once set, they'll be included into every
request that is being made from now on ... and our web application can use
it.

When our browser is now redirected to `GET` the same URL again, it passes the
cookie, and Sinatra will, because we have the `:sessions` feature enabled,
*deserialize* (i.e. decrypt and read) the data, and put it back into the
hash that is returned by the method `session`, so we can work with it.

In our `get` route, if we find something in `session[:message]` we will display
it in the view. If nothing is stored on that key in the session then the view
won't display anything either.

Does that make sense?

Awesome :)

## Transient state

However, there's a little problem with our approach. Have you noticed?

Let's recap what our application does:

* On the `GET /monstas` route we render a view that includes a form.
* This form, when submitted, makes a `POST` request to the same path `/monstas`, and includes the `name` variable.
* On the `POST /monstas` route we find the `name` data in the `params` hash.
* We store it to the file.
* We set the confirmation message to `session[:message]`.
* We redirect the browser to `GET /monstas`.
* The browser requests `GET /monstas`.
* We find the confirmation message on `session[:message]`.
* We display the message.

This works great.

However, the message is now stored in our session cookie. And that means that
from now on, whenever you browse (make a `GET` request) to the path `/monstas`
the browser will always include the same cookie (data) to the request. And our
application will always find it, and always display the same confirmation
message ... even though we haven't actually added any new names this time.

Instead, what we really want to do is display the confirmation message only
once: on the `GET` request that is made right after the `POST` request
redirected to `/monstas`. When we then reload the page (or close and reopen
the browser and go to `/monstas` tomorrow) the confirmation message should
be gone.

Right?

This is called "transient state": State that is only there for a brief moment,
and then goes away. And a session is a great place to keep it.

So how can we fix that?

All we have to do is delete the message from the session right before we
display it:

```ruby
get "/monstas" do
  @message = session.delete(:message)
  @name = params["name"]
  @names = read_names
  erb :monstas
end
```

Deleting it from the `session` will return the value that was stored on this
key, and we assign it to the instance variable `@message`, which makes it
available to our template.

In other words, if anything is stored on this key it will be assigned to the
`@message` instance variable, and the view will display it. If nothing's stored
on the key, then deleting the key will simply return nil, and nothing will be
displayed in the view.

Problem solved :)

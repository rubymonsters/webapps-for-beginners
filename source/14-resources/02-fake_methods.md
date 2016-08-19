# Faking HTTP verbs

Remember how we said that in an HTML form we can specify the HTTP verb that
is supposed to be used for making the request like so:

```html
<form action="/monstas" method="post">
  ...
</form>
```

This makes the form `POST` to `/monstas`, instead of the default `GET`.

Now, it's probably fair to say that every sane person in the world would expect
that it is also possible to make that a `PUT`, or `DELETE` request. Like so:

```html
<form action="/monstas" method="put">
  ...
</form>
```

Except that ... it's not. Today's browsers still do not allow sending HTTP
requests using any other verb than `GET` and `POST`.

The reasons for why that still is the case in 2015 are either fascinating or
sad, depending how you look at it <a href=#footnote-1">[1]</a>
But for now we'll just need to accept that, and work around it.

Sinatra (as well as Rails, and other frameworks) therefore support "faking"
requests to look as if they were `PUT` or `DELETE` requests on the application
side, even though in reality they're all `POST` requests.

This works by adding a hidden form input tag to the form, like so:

```html
<input name="_method" type="hidden" value="put" />
```

A hidden input tag is just that, it is hidden, meaning that it is not displayed
to the user. However, it is there, and it will be sent to the application as
part of the request just like any other input tag.

In order to make this work we also need to tell Sinatra that we want this
kind of behaviour. Developers say we need to "opt in" to it. Like so:

```ruby
use Rack::MethodOverride
```

Now, whenever Sinatra receives a `POST` request that has a parameter with the
name `_method` it will treat this request as if it was a request with the HTTP
method (verb) given by this parameter. This way one can add data to the form
that isn't relevant to the user, but relevant to the application.

Sinatra will treat any `POST` request that has the parameter `_method` set to
`put` as a `PUT` HTTP request: it will use a route that was defined with `put`.
Likewise, it will treat a `POST` request that has the paramter set to `delete`
as a `DELETE` HTTP request, and use the respective route.

This way we can write our application code *as if* browsers support
sending forms as `PUT` or `DELETE` requests, even though they don't. The only
thing we need to do is add that little hidden input form field.

The parameter name `_method`, with an underscore in front, has been chosen to
indicate that it's a "private" concern: it is something that Sinatra manages
for us. Also, by choosing an unusual name like this it won't clash with our own
form input fields, in case we ever need to add a form field named `method`,
e.g. for, maybe, a payment method, or a shipping method, or whatever else.


## Footnotes

<a name=footnote-1">[1]</a> You can read more about this, for example,
<a href="http://programmers.stackexchange.com/questions/114156/why-are-there-are-no-put-and-delete-methods-on-html-forms">here</a>.

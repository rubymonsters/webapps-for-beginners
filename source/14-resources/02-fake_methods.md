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
But for now we'll need to accept and work around it.

Sinatra (as well as Rails, and other frameworks) therefore support "faking"
requests to look as if they were `PUT` or `DELETE` requests on the application
side, even though in reality they're all `POST` requests.

This works by adding a hidden form input tag to the form, like so:

```html
<input name="_method" type="hidden" value="put" />
```

A hidden input tag is just that, it is hidden, meaning that it is not displayed
to the user. However, it is there, and it will be send to the application as
part of the request just like any other input tag.

Now, whenever Sinatra receives a `POST` request that has a parameter with the
name `_method` it will treat this request as if it was a request with the HTTP
method (verb) given by this parameter.

That means it will treat any `POST` request that has the parameter `_method`
set to `put` as a `PUT` HTTP request: it will use a route that was defined with
`put`.  Likewise, it will treat a `POST` requests that has the paramter set to
`delete` as a `DELETE` HTTP request, and use the respective routes.


<a name=footnote-1">[1]</a> You can read more about this, for example,
<a href="http://programmers.stackexchange.com/questions/114156/why-are-there-are-no-put-and-delete-methods-on-html-forms">here</a>.

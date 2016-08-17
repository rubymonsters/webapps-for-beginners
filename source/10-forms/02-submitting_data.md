# Submitting Data

When you click a button that is a "submit" input element then your browser will
submit the form that this button is part of.

But to where? If we do not specify anything else the browser will submit it to
the same URL that we are currently looking at, which is, in our case the path
`/monstas`.

We might as well specify it: this helps make clear what's going on.
Curiously, the attribute is called `action` (and not `target` or `url` as one
might expect):

```html
<form action="/monstas">
  <input type="text">
  <input type="submit">
</form>
```

Now, what does "submit" mean, exactly, in this context?

We said browsers speak HTTP when they talk to a web server (our Sinatra
application), so "submitting" a form means making another HTTP request. Again,
if we do not specify anything else, the default method will be `GET`.

So our browser makes another `GET` request with the path `/monstas`. This
basically just reloads the page, and displays the same form again, served from
our `get "/monstas"` route. This also explains why the text in the input field
goes away.

Ok, where does the question mark come from though?

When the browser submits the form it collects all the data from the form input
elements, and sends it along with the HTTP request. In the case of a `GET`
request <a href="#footnote-1">[1]</a> it will append it to the URL, after a
question mark, as name/value pairs. These are called "query parameters" in
HTTP.

However, our form input text element does not have a name, and so the browser cannot
pass it in a meaningful way.

So let's change that, and specify a name for our text input. Since we want
the user to input their name, the name of our input should be `name`:

```html
  <input type="text" name="name">
```

If you restart the application, reload the page, and again enter some text and
click submit ... you should see that the URL changes to something like
`http://localhost:4567/monstas?name=Monstas`.

Aha!

So that's how the browser passes our input to the application. It just appends
it to the URL as query parameters (name/value pairs).

Now, how can we make use of this form data in our application?


## Footnotes:

<a name="#footnote-1">[1]</a> You'll see later that form data is passed as part
of the request body in case of `POST` requests. The request body is able to
hold much more data than the URL, which is limited in its length.

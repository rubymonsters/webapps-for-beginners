# HTML Form Tags

HTML defines a couple tags for describing forms that are part of a document
(web page).

Here's how a simple form looks in HTML:

```html
<form>
  <input type="text">
  <input type="submit">
</form>
```

If you copy this HTML code to a file, and open the file in your browser it will
look similar to this:

<img src="/assets/images/10-forms_1.png">

Nice.

You can see that the two `<input>` tags are rendered (displayed) in different
ways because they have two different types: `text` and `submit`. One is a text
input field, and one is a button to submit the form. In modern HTML there are
lots of other input element types. You can find a
<a href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input">full list here</a>.

Let's make our little Sinatra application serve this form.

Make a new template file `monstas.erb` in your `view` directory and add the the
HTML above. Then replace your `get '/monstas/:name'` route with the following:

```ruby
get "/monstas" do
  erb :monstas
end
```

Restart the server and go to <a href="http://localhost:4567/monstas">http://localhost:4567/monstas</a>.
You should see something similar to our screenshot above.

Now, this form isn't very useful, yet. If you submit it (enter something, and
click "Submit") nothing much will happen. It clears the input element, and
appends a question mark to the URL for some reason, but that's it.

What's happening here?


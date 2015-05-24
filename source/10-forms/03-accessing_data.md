# Accessing Form Data

We mentioned earlier that form data will be available in the `params` hash.

Let's check that by outputting the `params` in our route:

```ruby
get "/monstas" do
  p params
  erb :monstas
end
```

Again, restart the application, and load the URL
<a href="http://localhost:4567/monstas?name=Monstas">http://localhost:4567/monstas?name=Monstas</a>.
In your terminal you should then see something like:

```
{"name"=>"Monstas"}
```

So this is how we can access the data that has been passed from the browser as
part of the HTTP request, when it submitted the form.

Let's do something with it!

Change your route like so:

```ruby
get "/monstas" do
  @name = params["name"]
  erb :monstas
end
```

And add this code at the top of your `monstas.erb` view:

```erb
<% if @name %>
  <h1>Hello <%= @name %>!</h1>
<% end %>
```

When you restart the server, and reload the page you should see something like
this:

<img src="/assets/images/10-forms_2.png">

Awesome!

So this is how you can pass (submit) data from the brower to your application,
and use it in some way.

Let's make one more improvement to our form. It currently always wipes out the
text that has been submitted. Let's make sure we preseve it in the input element.

We can do that by specifying the `value` attribute on the `input` tag, like so:

```html
<form action="/monstas">
  <input type="text" name="name" value="<%= @name %>">
  <input type="submit">
</form>
```

When you restart your application, and reload the page, it should now put the
name to the input element:

<img src="/assets/images/10-forms_3.png">

Perfect.

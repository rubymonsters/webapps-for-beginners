# Validations

Our little application now already makes use of a bunch of things that you will
regularly find in web applications.

We have a form that posts data to another route. The `post` route picks up the
data, and stores it, then redirects to another route, which displays the data.
We also use a session, and a query parameter to pass data from one route to
another.

Pretty cool. You'll see a lot of these very same concepts in use when you start
building your first Rails application. All of these things will work pretty
much the same way in Rails. Except, you've now built them manually yourself,
so you know how this stuff works under the hood.

Let's look at one other concept that Rails helps with, too: Validating user
input.

If you look at our little application we still are a little naive in accepting
whatever data comes in to our `post` route: We simply store whatever the user
sends, whenever they send it.

Do we really want to store duplicate names? What if the same name is being
submitted over and over again? And what if there's no name submitted at all?

What we really want to do is validate the incoming data (in our case the name),
and only accept and store it when we find it's valid. If it's not, then we want
to display a message to the user, and ask them to submit the form again.

We could change our `post` route like so:

```ruby
post "/monstas" do
  @name = params["name"]

  if @name.nil? or @name.empty?
    session[:message] = "You need to enter a name."
  elsif read_names.include?(@name)
    session[:message] = "#{@name} is already included in our list."
  else
    store_name("names.txt", @name)
    session[:message] = "Successfully stored the name #{@name}."
  end

  redirect "/monstas?name=#{@name}"
end
```

This is a valid implementation, and if you restart your application you
can try it out.

The `if` statement first checks if the `@name` is empty. If it is we simply
store a message to the session, and then redirect.

Note the duplicate condition `@name.nil? or @name.empty?`. The name parameter
could either be missing (and thus, be `nil`), or it could be an empty string,
so we need to check both cases.

This could be simplified to one condition like so:

```ruby
  if @name.to_s.empty?
```

If it's `nil`, then `nil.to_s` would return an empty string. If it's an empty
string, then `"".to_s` returns the same empty string again.

The `if` statement then also checks if the given `@name` already is included in
the names in our file: the array returned by `read_names`. If we already have
the name, then, again, we just add a message to the session, and redirect.

Only in the last case, when the name is not empty, and not already known,
we do store it, and add the respective message to the session, and redirect.

Alright, this works.

However, it's worth considering that this adds quite a bit of stuff to our
route. And if we have a lot of routes then that's a lot of code to add.

So what if we extract this to a separate class?

Extracting code to a class (or method) is a useful technique to keep your
code clean and readable. The routes can focus on their job (passing data
from the request to the view, reading data from our file, storing new
data to the file etc), and the new class can focus on a different task:
Finding out if the passed data is valid.

So let's try that, and implement a little Ruby class that hides some of the
logic from the route. Here's how we could do it:

```ruby
class NameValidator
  def initialize(name, names)
    @name = name.to_s
    @names = names
  end

  def valid?
    validate
    @message.nil?
  end

  def message
    @message
  end

  private

    def validate
      if @name.empty?
        @message = "You need to enter a name."
      elsif @names.include?(@name)
        @message = "#{@name} is already included in our list."
      end
    end
end

post "/monstas" do
  @name = params["name"]
  validator = NameValidator.new(@name, read_names)

  if validator.valid?
    store_name("names.txt", @name)
    session[:message] = "Successfully stored the name #{@name}."
  else
    session[:message] = validator.message
  end

  redirect "/monstas?name=#{@name}"
end
```

This adds quite a bit of code that we need to figure out, and type. But it
seems worth it: Our route is now much shorter, and way easier to understand
from just a quick look at it. We could move the `NameValidator` to a separate
file.

Cool, this works great.

## Rerendering the form

However, imagine we'd now have a much bigger form, with lots of fields. And
we'd validate each of these fields and have several validation messages.
Imagine we'd have like 20 form fields, and the user has made mistakes on 5 of
them.

We'd want our application to display the same form again, and display the
validation messages alongside with it. The original data should be, again,
prefilled to the form, so the user does not have to type it all again.

In order to preserve the form data that had been entered by the user we'd
need to append it all to the URL (as we do with the name in `"/monstas?name=#{@name}"`).
And we'd need to store all the validation messages to the session.

This is a lot of stuff. And it actually also might break because URLs cannot be
very long.

For this reason modern web applications usually follow a different pattern:

If the submitted data is invalid, instead of redirecting the user, we would
simply re-render the same template right there, with the same data.

Here's how we could do that:

```ruby
post "/monstas" do
  @name = params["name"]
  @names = read_names
  validator = NameValidator.new(@name, @names)

  if validator.valid?
    store_name("names.txt", @name)
    session[:message] = "Successfully stored the name #{@name}."
    redirect "/monstas?name=#{@name}"
  else
    @message = validator.message
    erb :monstas
  end
end
```

As you can see we now only store a message to the session, and redirect, only
if the given data is valid. If it's not then we store the validation message to
the `@message` instance variable and render our template again.

Cool. If you restart your application you can try how it works.

However, this now displays an empty "Hello" at the top. Why's that?

We assign `params["name"]` to the instance variable `@name` which we then check
in our template: `<% if @name %>`. However, since this has been submitted by a
form, with an input element called `name`, what we get is an empty string, not
`nil`.

We can fix this by changing our view like so:

```erb
<% unless @name.to_s.empty? %>
  <h1>Hello <%= @name %></h1>
<% end %>
```

Awesome.

With this completed you have now walked through an important pattern for web
applications, which is also used in Rails applications by default:

* There is an HTML form which is being retrieved via a `GET` request.
* This form posts to another route, which validates the submitted data.
* If the data is valid, it does something with it (in our case we store it) and
  redirects, passing a message via the session.
* If it's not valid, it renders an error message, as well as the form,
  with the form fields populated with the given data.

Make sure to remember this pattern. Maybe write it down to a cheatsheet,
formulate it in your own words. Maybe try turning it into a comic.

Next, let's take this a step further and have a look at something that Rails
calls "resources".

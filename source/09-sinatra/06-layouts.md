# Layouts

Our HTML still isn't quite valid: '<html>' and '<body>' tags are mandatory,
even though browsers still render our HTML happily without them.

We could add these wrapping tags to each and every one of our templates,
every time we create a new one. However, that's quite some repitition, and
should we ever want to change anything about them (which is likely) we'd
have to change all of our templates.

For building web applications it is handy to have "wrapping" templates. And
that's something Sinatra supports, too. They're called "layout" templates.

Here's how it works:

```ruby
get '/hello/:name' do
  template = "<h1>Hello <%= name %></h1>"
  options = {
    :locals => { :name => params[:name] },
    :layout => "<html><body><%= yield %></body></html>"
  }
  erb template, options
end
```

Don't forget to restart your application, and refresh the page. If you inspect
the source code of the web page (right click on the page, and select "View Page
Source", or whatever that's called in your browser) you'll see that it now has
the `<html>` and `<body>` tags from our layout template.

What about that `yield` thing in the ERB tag in our layout template though?

`yield` is a keyword in Ruby that calls a block that was given to a method.
Hmmm.  Well, that's how it works under the hood, that is correct. However, in
this context, all you need to remember is that, in a layout template, `<%=
yield %>` needs to be place where the other template (the one that is being
wrapped) is supposed to be inserted.

Imagine you have an application with, say, 10 `get` routes. Each of them
renders a different template. Say, there's one for the homepage, one for
a user signup page, one for a user profile page, and so on. Each of these
templates is supposed to be wrapped into the same layout, which has the
enclosing `<html>`, `<body>`, and other tags, which are all common to each
of these pages.

Each route will then render its own template, and specify the layout template
to be used, which will replace the `<%= yield %>` tag with the template, and
wrap it.

Does that make sense?

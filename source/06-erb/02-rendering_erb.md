# Rendering ERB

The Ruby code embedded in our template uses two local variables (or methods)
with the names `name` and `messages`. Also, `each` is called on `messages`, so
this should probably be an array:

```ruby
puts name

messages.each do |message|
  puts message
end
```

So how do we provide these objects to the ERB template? And how do we execute
the whole thing?

It's probably best to look at an example:

```ruby
require "erb"

template = %(
  <html>
    <body>
      <h1>Messages for <%= name %></h1>
      <ul>
        <% messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </body>
  </html>
)

name = "Ruby Monstas"
messages = [
  "We meet every Monday night at 7pm",
  "We've almost completed the beginners course!",
  "Feel free to come by and join us!"
]

html = ERB.new(template).result(binding)
puts html
```

Does this code make sense to you?

Let's walk through it:

* On the first line we require the erb from the
  <a href="http://ruby-doc.org/stdlib-2.2.2/libdoc/erb/rdoc/ERB.html">Ruby Standard Library</a>.
* As you've learned in <a href="http://ruby-for-beginners.rubymonstas.org/bonus_1/alternative-syntax.html">this chapter</a>
  the syntax `%(something)` defines a string. So, `template` is just one, long
  string that contains our ERB template.
* Next we define two local variables `name` and `messages`, which hold a simple
  string, as well as an array with 3 strings.
* On the next line we create an instace of the class `ERB` and pass our
  `template` (the string defined earlier) to it.
* On this instance we then call the method `result` with something that is
  called `binding`.
* This method call to `result` returns something that we assign to the variable
  `html`, so, as you might guess, this should be the HTML we were after.
* We'll then just output the result to the terminal on the last line, using `puts`.

If you run this code it will output something like this:

```html
<html>
  <body>
    <h1>Messages for Ruby Monstas</h1>
    <ul>
      <li>We meet every Monday night at 7pm</li>
      <li>We've almost completed the beginners course!</li>
      <li>Feel free to come by and join us!</li>
    </ul>
  </body>
</html>
```

... which is a valid HTML document that a browser would render (display) like
this:

<img src="/assets/images/06-erb_1.png">

Looks good?

To recap, all that our code above does is the following:

* Define a template with some HTML and some embedded ERB tags.
* Define a couple of variables that contain things that our template wants (`name` and `messages`).
* Create an instance of the class ERB, passing this template.
* On this instance, call the method `result`.

In other words, it executes (we say "renders") the ERB template using the
`name` and `messages` objects, and returns the HTML as a result.

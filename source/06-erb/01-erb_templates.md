# ERB Templates

The main idea behind ERB is to embed some Ruby code *into* an HTML document
(also called a template). <a href="#footnote-1">[1]</a>

Here's an example:

```erb
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
```

Can you guess what this means?

Everything inside the so called ERB tags `<% ... %>` is considered Ruby code.
Everything outside of them is just some static text, in our case HTML code,
into which the results of the Ruby code will be embedded whenever the ERB tag
also has an equals sign, as in `<%= ... %>`.

Imagine stripping everything outside the ERB tags, and the opening and closing
tags themselves from the code above. And imagine replacing the `=` equals sign
with `puts` statements. You'd then end up with this code:

```ruby
puts name

messages.each do |message|
  puts message
end
```

That's some code you understand, right?

ERB, when executed, does exactly this, except that `=` as part of the ERB tag
`<%= ... %>` will not output things to the terminal, but capture it, and insert
it to the surounding text (HTML code, in our case) in place of this tag.

Ruby code in ERB tags that do not have an equal sign, such as `<% ... %>` will
be executed, but any return values won't be captured, and just discarded.


## Footnotes:

<a name="footnote-1">[1]</a>
*This idea actually predates Ruby's ERB library and
became popular with PHP, a language that originally was meant to be used
exactly this way: by embedding some code into an HTML template file.*

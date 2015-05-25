# Writing to a file

How do you append a string to a file in Ruby?

If you google for <a href="http://google.com?q=Ruby+file+append">"Ruby file append"</a>
you'll find a bunch of answers that all basically look like this:

```ruby
File.open(filename, "a+") do |file|
  file.puts(string)
end
```

This uses two local variables `filename` and `string`, which in our case would
be `names.txt` and the name passed as the param.

The slightly weird looking second argument `"a+"` tells the `open` method that
we want to use the file for appending something (thus `a`), and that we'd like
it to create a new file unless it already exists (thus `+`).

Also, `File.open` takes a block, and passes an object, an instance of the class
<a href="http://ruby-doc.org/core-2.2.0/File.html">File</a> to it.

It does this because the file needs to be closed once we're done with it. The
`open` method makes sure we don't forget this, and closes the file once it has
run our block.  Pretty handy.

Inside of the block we simply call `puts` on the file object, which will append
the string that we pass, and also add a newline (just like `puts` does when you
output a string to the terminal).

Alright. Ready to go?

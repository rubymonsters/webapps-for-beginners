# Ruby Load Path

Ruby is software, and software stores things somewhere on your file system.
In order to define places on your computer, where interesting stuff is stored
software often has the concept of a "load path".

If you are using a Unix based operating system, such as Linux or Mac OSX you
may have seen the environment variable `$PATH` in installation instructions.
This variable defines all the directories where executable files are stored.

Ruby has a load path, too. Inside your Ruby program you can print it out using:

```ruby
puts $LOAD_PATH
```

This will print out the array that is defined as the `$LOAD_PATH` when Ruby
starts your program. `puts` is smart enough to put each string in that array
on a separate line.

Each of these lines represents a directory on your computer where Ruby files
are stored. If you use `require` anywhere in your application (e.g. `ruby
"digest"`) then Ruby will look for a Ruby file with the same name (e.g.
`digest.rb`) in each of these directories. It will load the first file with
this name that it can find.

Would now be a good time to do a few exercises on
<a href="/exercises/rubygems.html">Rubygems</a> and
<a href="/exercises/bundler.html">Bundler</a>?

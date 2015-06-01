# Ruby load path

*Where to look for all the things*

Ruby is software, and software stores things somewhere on your file system.
In order to define places on your computer where interesting stuff is stored,
software often has the concept of a "load path".

If you are using a Unix based operating system such as Linux or Mac OS X, you
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
are stored. If you use `require` anywhere in your application (e.g. `require
"digest"`) then Ruby will look for a Ruby file with the same name (e.g.
`digest.rb`) in each of these directories. It will load the first file with
this name that it can find.

If you are curious, you can quickly check the default load path of your
Ruby installation like this:

```
ruby -e 'puts $LOAD_PATH'
```

The `-e` flag is a way to run some Ruby code without having to store it in
a file.

For me, this prints:

```
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/site_ruby/2.2.0
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/site_ruby/2.2.0/x86_64-darwin14
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/site_ruby
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/vendor_ruby/2.2.0
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/vendor_ruby/2.2.0/x86_64-darwin14
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/vendor_ruby
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/2.2.0
/Users/sven/.rbenv/versions/2.2.1/lib/ruby/2.2.0/x86_64-darwin14
```

From this you can see that I am using <a href="https://github.com/sstephenson/rbenv">rbenv</a>
to manage my Ruby versions, that my currently active Ruby version is `2.2.1`,
and that I am running this on Mac OS X ("darwin").  All these paths are
directories somewhere in the directory where Ruby 2.2.1 is installed on my
computer.

Whenever there's a `require "something"` statement in some Ruby code that I run
on my computer, Ruby will check all these directories for a file
`something.rb`.

Now let's do a few exercises on
<a href="/exercises/using_rubygems.html">Rubygems</a> and
<a href="/exercises/using_bundler.html">Bundler</a>.

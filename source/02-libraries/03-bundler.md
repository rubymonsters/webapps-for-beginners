# Bundler

*Sandboxes of Gems*

Consider an application that relies on lots and lots of gems:

For example, a newly generated Rails application comes with a whopping 42 gems,
and this number usually grows pretty quickly with typical Rails applications.
The application <a href="http://speakerinnen.org/">Speakerinnen Liste</a>, at the time of this writing, installs no less than 138 gems. Only 40 of these
are defined in the Speakerinnen <a href="https://github.com/rubymonsters/speakerinnen_liste/blob/master/Gemfile">Gemfile</a>,
which are the ones that provide certain features used by the application.
The other 98 gems are dependencies that these 40 gems have.

Now, imagine working on an application like this over years. There are new
versions of gems being published all the time. Often they'll update the version
numbers of their dependencies when new versions come out, or add new gems as
dependencies, and remove old ones.

How likely do you think it is that any of the version number ranges specified
for all of these gems would conflict with any other version number range? In
practice it is very likely. Rubygems itself (the library `rubygems` that is part
of your Ruby installation) is not very smart at figuring out which versions
of certain gems play well with each other.

On top of this, with plain Ruby and Rubygems, when you `require` any gem in your
code, you'll simply get the latest version of this gem that is already installed
on your computer. Assuming these versions do not conflict with each other, you
still don't know if these are the exact same versions as the ones your
co-workers have installed. Again, in practice this is pretty unlikely.

All of this means that maintaining the right versions of the right gems on
your system manually would be a sheer nightmare. And if you get it wrong then
that can be a source of many, often subtle bugs that you don't really want to
deal with.

And that's where Bundler comes to the rescue:

Bundler allows you to define which gems your application depends on (in a file
called `Gemfile`. Here's the one we're using for
<a href="https://github.com/rubymonsters/ruby-for-beginners/blob/main/Gemfile">this book</a>).
When we run `bundle install`, this will figure out which
gem versions work well with each other (a task that Bundler is *great* at), and
store the solution to this riddle to a separate file (called `Gemfile.lock`).

The `Gemfile` and `Gemfile.lock` files are part of your code, and can be shared
with other developers. When they download your code, and run `bundle install`
themselves, they'll get exactly the same gem versions that you also have.

You can think of Rubygems as a tool to install gems on your computer. Over time
this may result in a collection of lots and lots of gems in various versions
that all sit somewhere on your filesystem.

Bundler on the other hand is a tool for picking *some* of these gem versions,
and restricting access to only these. You can think of it as a sandbox of the
few gems that your application really should use. Like a looking glass that
restricts the vision of your application to only see these few gem versions,
even though there maybe tons of other gem versions installed on your computer.

In order to use your application with Bundler, you'd prepend the command `bundle
exec` to whatever other command you execute in your terminal. Imagine you'd
normally execute your program like this:

```
ruby my_amazing_app.rb
```

In order to use it with Bundler and restrict the visible gem versions to the
ones defined in your `Gemfile.lock` file, you would run this instead:

```
bundle exec ruby my_amazing_app.rb
```

<p class="hint">
For Rails applications you do not have to prepend <code>bundle exec</code>, as
Rails does this itself, under the hood.
</p>

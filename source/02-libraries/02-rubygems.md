# Rubygems

Rubygems is Ruby's package manager. A gem is a library that has been prepared
in a way so it can be distributed (published and downloaded) via the internet.
Such libraries are commonly refered to as "packages", and there are many different
package managers for different purposes. You can think of it as an app store
that can be used to download specific versions of libraries, which you can then
use.

Gems are libraries, often quite small, sometimes big (such as Rails), that
provide certain tools for solving certain problems, just like the libraries
contained in the Ruby Standard Library. If you found the example of a library
that helps with signing in to a web application via Google hilarious, there's
actually a <a href="https://rubygems.org/gems/google-oauth/versions/0.0.2">gem for that</a> :)

Ruby has a built-in command line tool `gem`, which also is installed alongside
your Ruby installation, and it allows you to manage gems on your computer.

When you run `gem --list` in your terminal you should see a list of all the
gems that are installed on your computer (for the currently selected Ruby
version if you use a Ruby version manager, such as RVM).

In order to install a certain gem you can type `gem install [the-gem-name]`.
E.g. `gem install middleman` would install the
<a href="https://middlemanapp.com/">Middleman</a> library, which is a super
handy tool for generating static web pages. This book is published using
Middleman.

Where does `gem` fetch all these gems (packages) from though?

Ruby gems are centrally hosted on <a href="https://rubygems.org">RubyGems.org</a>,
and Middleman, for example, has
<a href="https://rubygems.org/gems/middleman">entry on this site</a>, too.
You can see the latest version number of this gem (which is `4.0.0.beta.2` as
of this writing), who the authors are, useful links to their homepage, source
code, documentation, and so on.

You can also see that the gem middleman depends on a variety of other gems,
such as coffee-script, compass, execjs, and haml. This means that the authors
of Middleman themselves make use of code which in turn is packaged as gems,
too. This is very common. We say "Middleman's dependencies are coffee-script,
compass, ...".

When you run `gem install middleman` you'll see that this not only installs
the Middleman gem, but also all of its dependencies, and all dependencies
that any of the dependencies might have. This means, when you install one
gem you'll get all the other stuff that this gem needs, too.

Also, each of these dependencies comes with a specification of a version number
or range of version numbers. For example `~> 2.2.0` means "allow any version
of this gem that starts with 2.2".

Once installed on your computer you can use a gem in your code in just the same
way as you use something from the Ruby Standard Library: You `require` it.

For example, in order to configure Middleman to generate this book we require
a gem called `middleman-toc`
<a href="https://github.com/rubymonsters/ruby-for-beginners/blob/master/config.rb#L1">here</a>.
This is an extension to Middleman that allows to add a table of contents, and
we need to `require` it before Middleman can use it.

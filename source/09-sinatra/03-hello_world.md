# Your first Sinatra app

Let's get started looking at Sinatra.

Make sure you have the Sinatra gem installed. Use `gem list sinatra` to
check if it's there. If it's not install it using `gem install sinatra`.

Now, let's steal the intro example from their homepage, and adopt it. Make a
new directory `sinatra`, `cd` into it, create a file `monstas.rb` and add this
code:

```ruby
require "sinatra"

get "/" do
  "OMG, hello Ruby Monstas!"
end
```

Now you can run your little app using `ruby monstas.rb`. You should see
something like this:

```
$ ruby monstas.rb
[2015-05-15 21:37:41] INFO  WEBrick 1.3.1
[2015-05-15 21:37:41] INFO  ruby 2.2.1 (2015-02-26) [x86_64-darwin14]
== Sinatra (v1.4.6) has taken the stage on 4567 for development with backup from WEBrick
[2015-05-15 21:37:41] INFO  WEBrick::HTTPServer#start: pid=27182 port=4567
```

Again, there are lots of version numbers, that we can ignore, and it
also tells us the port that it's running on. This time it's `4567`. For some
reason Sinatra finds it important to use a different port number `¯\_(ツ)_/¯`

So let's point the browser to <a href="http://localhost:4567">http://localhost:4567</a>.

You should see something like this:

<img src="/assets/images/09-sinatra_1.png">

That was easy, wasn't it.

If you've read the chapters about [Rack](/rack.html) it is interesting to know
that Sinatra uses Rack under the hood, but it deals with the nitty gritty
details of looking at the `REQUEST_METHOD` and `REQUEST_PATH` for you.

It allows you to use the methods `get`, `post`, `put`, and `delete`
with a path argument, and simply specify a block that will be called whenever a
request matches the request method (verb) and path.

The Ruby code that makes up our little Sinatra application reads very well,
and it only focusses on the bits and pieces we care about (as opposed to our
Rack application, which had to include the knowledge about the `env` etc.)

Sinatra also allows you to simply return a string from this block, which will
then be used as the response body, and sets things like the status code and
headers for you (when it returns the Rack style response array to Rack). Since
the vast majority of requests will want to return 200 as a status code Sinatra
just assumes you want that too, unless you specify something else.


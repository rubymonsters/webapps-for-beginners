# Bonus: Your first Rack app

Let's jump right in.

In a new directory `rack` create a file `config.ru` with the following content:

```ruby
class Application
  def call(env)
    [200, { "Content-Type" => "text/html" }, ["Yay, your first web application! <3"]]
  end
end

run Application.new
```

Now, make sure you have the gem Rack installed: In your terminal check `gem
list rack`. Does that show something like `rack (1.6.1)` (or any other version
number)? If it doesn't, install Rack with the command `gem install rack`.

This gem comes with a little executable (command line program) called `rackup`.
This command looks for a file `config.ru` in the current directory, and starts
a web server using it, on your local computer.

Make sure you have `cd`ed to your `rack` directory, and then run `rackup`. You
should see something like:

```
$ rackup
[2015-05-15 18:37:42] INFO  WEBrick 1.3.1
[2015-05-15 18:37:42] INFO  ruby 2.2.1 (2015-02-26) [x86_64-darwin14]
[2015-05-15 18:37:42] INFO  WEBrick::HTTPServer#start: pid=17588 port=9292
```

Of course the version numbers may be different, but the important bit that
you want to look for is the port.

Now your web application has started you can point your browser to
<a href="http://localhost:9292">http://localhost:9292</a>. You should see
something like this:

<img src="/assets/images/08-rack_1.png">

Pretty cool, isn't it? With just a few lines of plain Ruby code you have
just written an actual web application.

Now, let's have a closer look at the code.

We define a class `Application`, and, on the last line, create an instance
of it, which we pass to the method `run`. The method `run` is defined by
Rack, and expects to be passed *something* that responds to the method `call`.
<a href="#footnote-1">[1]</a>

That's why we defined a method `call` on our class. This method takes one
argument `env`. It does not use the `env` (whatever that is), yet, but instead
just returns the same static array whenever it is called.

This array contains 3 things:

* The number 200, which represents the status code,
* a hash that contains a single header (the content type), and
* an array containing a single string, which is the body.

So the method `call` returns something that represents an HTTP response in Rack!

Rack makes it so that whenever there's a request coming in (on the computer
that is `localhost`, i.e. your own, local computer, and on the port 9292),
it will turn this request into a hash `env` that is passed to the method `call`.
I.e. the argument `env` contains the request information. We'll have a look
at that in a minute.

Rack then expects that you return an array containing those three elements:

* The HTTP response code
* A hash of headers
* The response body, which must respond to each (i.e. we can just use an array)

<p class="hint">
A Rack application implements a method <code>call</code> that takes a hash
representing the request, and is supposed to return an array containing the
status code, a hash containing the headers, and an array containing the request
body.
</p>

Once it got these three things back from our method `call` it will create
the respective response (text) message out of it, and send it back to the
browser.

Great!


Footnotes:

<a name="footnote-1">[1]</a> Most examples for Rack applications will use
a `Proc` or `lambda`, which can be called using their method `call`. Here's an
example, using a lambda:

```ruby
application = lambda do |env|
  [200, { "Content-Type" => "text/html" }, ["Yay, your first web application! <3"]]
end

run application
```

This is why the author of Rack picked `call` as the main method: Our web
application will be "called" by Rack, and so it can be just an anonymous `Proc`
or `lambda`. Pretty slick.

However, in our example we use a class, so we can add more methods to it later.



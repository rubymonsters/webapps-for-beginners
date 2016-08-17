# Method and Path

We saw that the `env` hash that Rack passes to the method `call` contains the
keys `REQUEST_METHOD` and `PATH_INFO`.

Let's modify our app a little so we can make use of it:

```ruby
class Application
  def call(env)
    handle_request(env['REQUEST_METHOD'], env['PATH_INFO'])
  end

  private

    def handle_request(method, path)
      if method == "GET"
        get(path)
      else
        method_not_allowed(method)
      end
    end

    def get(path)
      [200, { "Content-Type" => "text/html" }, ["You have requested the path #{path}, using GET"]]
    end

    def method_not_allowed(method)
      [405, {}, ["Method not allowed: #{method}"]]
    end
end
```

Reading the code closely, do you understand what it does, and why?

We have changed the method `call` to extract the values for the keys
`REQUEST_METHOD` and `PATH_INFO`. And we then pass these two values to a new
method `handle_request`, which checks the request `method`. Keep in mind that
`method` here is just a variable name that refers to the HTTP concept of a
"request method".  This, of course, is not the same as a Ruby method, it's just
a variable that will hold a string such as `GET`, `POST` depending on the HTTP
request.

* If `method` is `GET`, then we call another method `get`, passing the `path`.
  The method `get` complies with Rack's convention for returning a response: It
  returns an array that has the response status, headers, and a body. We've
  changed the body a little bit so it displays the `path` that was requested.

* If `method` is not `GET`, then we call another method `method_not_allowed`.
  This method also complies with Rack's convention, but returns a different
  response. This time we use the status code `405` which means exactly this:
  *"Method Not Allowed"*. Our little application just does not support any other
  methods.

Because these response arrays are the return values of these two methods,
they'll also be the return value of the method `handle_request`, and it turn
the method `call`. So they'll be passed back to Rack, and turned into the
actual HTTP response that is returned to your browser.

If you restart your server, and point your browser to
[http://localhost:9292/ruby/monstas](http://localhost:9292/ruby/monstas)
you should now see something like this:

<img src="/assets/images/08-rack_2.png">


Congratulations!

You have just written your first web application that responds to different
requests with (albeit only slightly) different responses.

Imagine working on this application more, and returning different HTML pages
based on the `path` that is part of the request: You could use the ERB
rendering method from the [previous chapters about ERB](/erb.html) in order to
render different ERB templates.

And guess what, this is exactly what [Sinatra](/sinatra.html) makes super easy :)

In case you are wondering how to test the response for request methods other
than `GET`, that's not so easy without knowing more about [HTML forms](/forms.html).
However, if your computer has `curl` installed (a commandline tool to execute
HTTP requests) you can try this:

```
curl -i -X POST http://localhost:9292
```

For me this outputs:

```
HTTP/1.1 405 Method Not Allowed
```

As well as a bunch of other response headers.

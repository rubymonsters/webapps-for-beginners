# The Rack Env

Let's have a look at the `env` data that is passed along with the request.
Let's just print it out to the terminal as follows:

```ruby
  def call(env)
    p env
    [200, { "Content-Type" => "text/html" }, ["Yay, your first web application! <3"]]
  end
```

In order for the server to pick up this change we need to restart it. Go to
your terminal window where `rackup` (WEBrick) is running our app, and hit
`ctrl-c`.  Then hit `cursor-up` to get the last command back (or type
`rackup`), and hit `return`.

If you now refresh the page in your browser (hit `cmd-r` or `ctrl-r` depending
on your operating system) you should then see ... wow, quite a bit of messy
output in the logs in your terminal. For me it looks like this (some less
interesting bits removed):

```
{"GATEWAY_INTERFACE"=>"CGI/1.1", "PATH_INFO"=>"/", "QUERY_STRING"=>"", "REMOTE_ADDR"=>"127.0.0.1", "REM
OTE_HOST"=>"localhost", "REQUEST_METHOD"=>"GET", "REQUEST_URI"=>"http://localhost:9292/", "SCRIPT_NAME"
=>"", "SERVER_NAME"=>"localhost", "SERVER_PORT"=>"9292", "SERVER_PROTOCOL"=>"HTTP/1.1", "SERVER_SOFTWAR
E"=>"WEBrick/1.3.1 (Ruby/2.2.1/2015-02-26)", "HTTP_HOST"=>"localhost:9292", "HTTP_ACCEPT_LANGUAGE"=>"en
-US,en;q=0.8,de;q=0.6", "HTTP_CACHE_CONTROL"=>"max-age=0", "HTTP_ACCEPT_ENCODING"=>"gzip", "HTTP_ACCEPT
"=>"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "HTTP_USER_AGENT"=>"Mo
zilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.1
35 Safari/537.36", "rack.version"=>[1, 3], "rack.url_scheme"=>"http", "HTTP_VERSION"=>"HTTP/1.1", "REQU
EST_PATH"=>"/"}
```

Woha! What does all of this stuff mean?

First of all, you can see that it's a Ruby hash with lots of keys that are all
strings. Then, most of these strings are all upper case with an underscore `_`
as a word separator. Some of these start with `HTTP_`, while others don't.
However, there also are some keys that start with `rack`, and are all
lowercase.

Rack uses a simple convention for these keys:

* All headers that have been part of the actual HTTP request are prefixed with
  `HTTP` and uppercased. For example the request header `host: localhost:9292`
  will be translated to the hash key `HTTP_HOST` with the value `localhost:9292`.
  I.e. these are the actual HTTP headers that our browser has sent.
* All other uppercase keys represent additional information that has been
  passed (added) from the webserver that has received the request (in this case
  WEBrick, which runs our little Rack application). For example, WEBrick adds
  the key `PATH_INFO` with the resource (path), as well as the key
  `REQUEST_METHOD` with the verb (method) from the HTTP request. These weren't
  headers in the request, but obvioulsy part of it. On top of this, WEBrick
  also adds other things, such as the `SERVER_SOFTWARE` key (telling us which
  WEBrick and Ruby version we are using), and so on.
* All keys that are prefixed with `rack.` represent internal additions that
  Rack adds.

Let's write a little bit of code to make this easier for us to inspect:

```ruby
class Application
  def call(env)
    puts inspect_env(env)
    [200, { "Content-Type" => "text/html" }, ["Yay, your first web application! <3"]]
  end

  def inspect_env(env)
    puts format('Request headers', request_headers(env))
    puts format('Server info', server_info(env))
    puts format('Rack info', rack_info(env))
  end

  def request_headers(env)
    env.select { |key, value| key.include?('HTTP_') }
  end

  def server_info(env)
    env.reject { |key, value| key.include?('HTTP_') or key.include?('rack.') }
  end

  def rack_info(env)
    env.select { |key, value| key.include?('rack.') }
  end

  def format(heading, pairs)
    [heading, "", format_pairs(pairs), "\n"].join("\n")
  end

  def format_pairs(pairs)
    pairs.map { |key, value| '  ' + [key, value.inspect].join(': ') }
  end
end
```

Again, after changing your code, you'll need to restart your server application.

For me this outputs the following (again, stripping some of the less interesting bits):

```
Request headers

  HTTP_HOST: "localhost:9292"
  HTTP_REFERER: "http://localhost:9292/"
  HTTP_ACCEPT_LANGUAGE: "en-US,en;q=0.8,de;q=0.6"
  HTTP_ACCEPT_ENCODING: "gzip"
  HTTP_USER_AGENT: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36"
  HTTP_ACCEPT: "*/*"
  HTTP_VERSION: "HTTP/1.1"

Server info

  GATEWAY_INTERFACE: "CGI/1.1"
  PATH_INFO: "/"
  QUERY_STRING: ""
  REMOTE_ADDR: "127.0.0.1"
  REMOTE_HOST: "localhost"
  REQUEST_METHOD: "GET"
  REQUEST_URI: "http://localhost:9292/"
  SCRIPT_NAME: ""
  SERVER_NAME: "localhost"
  SERVER_PORT: "9292"
  SERVER_PROTOCOL: "HTTP/1.1"
  SERVER_SOFTWARE: "WEBrick/1.3.1 (Ruby/2.2.1/2015-02-26)"
  REQUEST_PATH: "/"

Rack info

  rack.version: [1, 3]
  rack.url_scheme: "http"
```

Now, that's way easier to read, right?

Luckily, we can just ignore most of these things.

At the moment, the only interesting keys for us are `REQUEST_METHOD` and
`PATH_INFO`: They're the relevant bits from the HTTP request.

<p class="hint">
The most interesting bits in the <code>env</code> hash are the
<code>REQUEST_METHOD</code>, and <code>PATH_INFO</code>.
</p>

Ok, let's do something with them.

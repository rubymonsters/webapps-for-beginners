# Storing the name

Now that we know how to append something to a file, let's use that in our
application and store all those names to a file.

We could change our route like so:

```ruby
get "/monstas" do
  @name = params["name"]

  File.open("names.txt", "a+") do |file|
    file.puts(@name)
  end

  erb :monstas
end
```

However, that stuffs a lot of clutter into our route, and we'd like to keep
these readable.

So let's extract that to method right away:

```ruby
def store_name(filename, string)
  File.open(filename, "a+") do |file|
    file.puts(string)
  end
end

get "/monstas" do
  @name = params["name"]
  store_name("names.txt", @name)
  erb :monstas
end
```

Better. Our route now describes what it does, instead of telling how exactly
it is done.

If you restart your Sinatra application, and reload the page, you should see
a file `names.txt` created in the same directory, and it should contain the
name from the form.

You can check this using command line tools like this:

```
# check if the file is there
$ ls names.txt
names.txt

# look at the content of the file
$ cat names.txt
Monstas
```

Of course you can also just look at the file in your editor :)

# Listing all names

Let's make it so that we can look at the list of the names in the browser
though. This is a web application, right.

For this we'll need to read the names from the file. Again, if you ask Google
for "Ruby read file" you'll find it's as simple as this:

```ruby
File.read(filename)
```

This returns a single, long string, which represents the content of the entire
file. Because we store every name on a new line we can split this string with
the newline character `"\n"` in order to get our names as an array:

```ruby
def read_names
  File.read("names.txt").split("\n")
end
```

However, this would break if there's no file with this name, yet. So let's
a little safeguard, and return an empty array if the file does not exist:

```ruby
def read_names
  return [] unless File.exist?("names.txt")
  File.read("names.txt").split("\n")
end
```

Does this make sense? If the file does not exist we return an empty array `[]`.
If it exists we read it, and split the content into lines.

Also, let's store the names on an instance variable in our route, so we can
then use it in the template later:

```ruby
get "/hello" do
  @names = read_names
  store_name("names.txt", params["name"])
  erb :hello
end
```
Now we can output the names as an unordered list (`<ul>`) in our `hello.erb`.

So let's replace this (we now want to display the full list):

```erb
<% if @message %>
  <p><%= @message %></p>
<% end %>
```
With this:

```erb
<ul>
  <% @names.each do |name| %>
    <li><%= name %></li>
  <% end %>
<ul>
```

<img src="/assets/images/11-storing_data_1.png">

Wheeeee! Pretty cool.


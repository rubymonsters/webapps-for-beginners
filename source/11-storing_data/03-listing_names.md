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

However, this would break if no file with this name exists yet. So let's add
a little safeguard, and return an empty array if the file does not exist:

```ruby
def read_names
  return [] unless File.exist?("names.txt")
  File.read("names.txt").split("\n")
end
```

Does this make sense? If the file does not exist we return an empty array `[]`.
If it exists we read it, and split the content into lines. Even if the file
exists, but it is empty, we'll still get an array.

Also, let's store the names on an instance variable in our route, so we can
then use it in the template later:

```ruby
get "/monstas" do
  @name = params["name"]
  @names = read_names
  store_name("names.txt", @name)
  erb :monstas
end
```
Now we can output the names as an unordered list (`<ul>`) in our `monstas.erb`.

So let's add this at the end of your file (we now want to display the full list):

```erb
<ul>
  <% @names.each do |name| %>
    <li><%= name %></li>
  <% end %>
<ul>
```

<img src="/assets/images/11-storing_data_1.png">

Wheeeee! Pretty cool.

The tag `ul` means "unordered list", and it is supposed to have one or many
`li` tags, which means "list item". Yeah, HTML tag names are a little weird,
their naming dates back a while.

# Migrations

*Persist executable changes to the database structure*

In programming, when we store something to a medium that survives when the
program terminates (or when the computer is shut down, and rebooted), we use
the term [persistence](http://en.wikipedia.org/wiki/Persistence_(computer_science))
for that.

Databases are probably the most common way to persist data in webapplications.
Your web application would read data from the database, and store data to it.
E.g. our application could read members, and store them. We use the term
*runtime* for this: Our application does all of this "at runtime", meaning:
after it has been started, and while it is running.

This data is stored as rows in our database tables. What about the structure
though?

The database structure normally does not change at runtime. The users of
your application do not get to add more columns to the `members` table,
right? That's something you, as a developer, want to define, basically
while you write your code.

So even though the database structure itself is not exactly part of your code,
it highly relates to your code: Your Ruby code makes assumptions about what
tables exist, and what columns each of the tables has. In other words, your
code would not work unless the database has a certain structure.

E.g. this Ruby code from our previous example makes the assumption that there
is a table `members` and it has at least the columns `id`, `name`, and
`joined_on`:

```ruby
member = Member.find(id: 1)
puts "#{member.name} has joined on #{member.joined_on}."
```

Because defining the database structure is a task that is separate from running
the actual application (starting your web server), there usually is some tool
to create a database, and apply the exact structure that your application (Ruby
code) requires.

One could, of course, create the database, and its structure manually, just
like you've just defined a table in the interactive SQLite shell.  However that
obviously is tedious, makes it difficult to collaborate with others, and
install your application in different environments: People would have to create
the database manually over and over, so that's not really a practical option.

Instead web applications use a concept called "database migrations", and we'll
explore it here because it's going to be a big topid in Rails, too.

# Migrations

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
member = Member.where(id: 1)
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

One way to share, and programmatically load a database schema is to store the
respective SQL commands to a file, and make the database load it.

For example, for our `members` database we could have a file `schema.sql` that
contains the following SQL command (we only have one table, so a single command
is sufficient):

```
CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

We could then import this structure definition into a new database named
`members-2` using a command like this:

```
cat schema.sql | sqlite3 members-2
```

We could share this file with other developers, and they could create the same
database with the same command, making sure they'd always end up with the same
database that we have, and that our our application (Ruby code) requires.

However, there's another problem with this.

Imagine we're all working on this shared Ruby Monstas members app. Someone
starts by defining a first, simple version of the `members`, much like the
one that we currently have. Then later, someone else picks up work, and adds
another column. Maybe someone else will then also rename one of the columns,
or drop it, because it's no longer required.

Everytime we'd export a new version of our database schema to the file `schema.sql`
and share it with each other. However, since the database schema only describes
the database structure in its final state, we could not just run it: Our local
database already has a certain table structure defined, and (e.g.) the `CREATE
TABLE` command would fail. The only solution to this would be to delete our
local database, and re-create it using the new schema. This would work fine
in development. However, what if we already have this application running
publicly, and people are already using it? We'd then loose all the data that
has been stored previously. Obviously that wouldn't be an acceptable solution.

The solution to this is a concept that is referred to as *database migrations*.

## Incremental changes

Instead of sharing the final database structure, as defined in our `schema.sql`
file, we would share many files where each of them defines a single change to
our database structure. We also somehow number these files so we can run each
change one after another in the precise same order.

Imagine our first step is to define the table members. So "change 1" would
contain our SQL code from above. We'd store this in a file `db-change-1.sql`:

```
CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

Now, the next person adds another change to the database structure, which adds
the table `messages` from our example above. They store this in a file
`db-change-2.sql`:

```
CREATE TABLE messages (id INTEGER PRIMARY KEY, member_id INTEGER, message TEXT);
```

And then, a couple days later, another person figures we should also keep track
of a timestamp which tells us when a message has been sent. We store this change
in a file `db-change-3.sql`

```
ALTER TABLE messages ADD COLUMN sent_at DATETIME;
```

Now we have 3 changes, stored in 3 separate files. We also know the order in
which these changes have been created: we can defer this from their filenames.
If we keep track of changes that we already have applied to our database
structure, then we can easily run the ones our collaborators have added just
recently, and continue working on our code.

This concept is called *database migrations*: We migrate the database structure
from one state to the next one, by applying one change after another.

Sounds useful?

There's more to this. What if we make a change to our database structure, apply
it to our "production" application (i.e. the one that is publicly running on
the internet, and actively used by our users), and then notice we've made a
mistake? We'd then need a way to quickly roll back our change. How would we do
that?

## Incremental rollbacks

This is why we would, per change (or per "migration"), not only define a way
to *apply* a certain change. We would also define a way to roll it back, i.e.
undo it.

With our naive, homegrown example migrations system, where we store plain
SQL in files, we could do this by using file names like `db-change-1-up.sql`
and `db-change-2-down.sql`.

In the terminology of migrations the terms `up` and `down` are used to describe
changes that are *applied* and *undone*: Migrating *up* means applying a
change, and migrating *down* means undoing a change (rolling it back).

This is because traditionally migrations (changes) have been numbered sequentially,
just as we do this in our example. That means applying a new change migrates
the database "up" to a higher verion (change) number. E.g. if we'd apply our
change `db-change-up-3.sql` we'd "migrate up to version 3". If we then undo it
we "migrate down from version 3".

Does this make sense?

## Migration tools

Of course, all of this is a little tedius so far, since we need to deal with
plain SQL. On top of this we do not even have a good way to keep track of
the change (version) number that has been applied to the database structure
last.

For that reason ORM tools usually come with a way to not only automatically
track changes that still need to be applied to the database structure (and
skip the ones that already were applied in the past). They also allow us
to define the database structure in a Ruby [DSL](/sinatra/dsl.html), so
we do not have to deal with the gory details of SQL, but can use some nice,
readable Ruby code instead.

Here's an example of a migration written for Sequel:

```ruby
Sequel.migration do
  up do
    create_table(:members) do
      primary_key :id
      string :name
      datetime :joined_at
    end
  end

  down do
    drop_table(:members)
  end
end
```

And here's an example of a migration in ActiveRecord:

```ruby
class CreateMembers < ActiveRecord::Migration
  def up
    create_table(:members) do |table|
      table.string :name
      table.datetime :joined_at
    end
  end
end
```

As you can see the Ruby code looks quite a bit different. That's because Sequel
and ActiveRecord define different DSLs for applying changes to your database
structure. You'll just need to learn whatever tool you're using, and look things
up from the documentation.

However, they both have in common that there's a bit of code for applying the
change (and they both use the method name `up` for describing it), and a bit of
code for reverting the change (undoing it, using the method name `down`).
And they have in common that you can use Ruby code, instead of plain SQL.

One other advantage of this is that the SQL that we need to run actually sometimes
looks a tiny bit different depending what database system we use (e.g. SQLite,
Postgres, MySQL). ORMs abstract these changes away from us, meaning that they
take care of generating different SQL depending what database system we use,
and let us describe changes in the same Ruby code no matter what.

If you find some of this confusing then don't worry. All of this will start
making sense as soon as you use migrations in praxis, in order to create
tables, and then apply more changes to them later.

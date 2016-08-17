## Database structure

A better way to share, and programmatically load a database schema is to store
the respective SQL commands to a file, and then make the database execute it.

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

This already works much better than asking our fellow developers setup their
database manually.

We could share this file with them, check it into our version control system
(e.g. Git), and they could create the same database with the same command,
making sure they'd always end up with the same database that we have, and that
our application (Ruby code) requires.

However, there's another problem with this.

Imagine we're all working on this shared Ruby Monstas members app. Someone
starts by defining a first, simple version of the `members`, much like the
one that we currently have. Then later, someone else picks up work, and adds
another column. Maybe someone else will then also rename one of the columns,
or drop it, because it's no longer required.

Everytime we'd export a new version of our database schema to the file `schema.sql`
and share it with each other.

However, since the database schema only describes the database structure in its
final state, we could not just run it: Our local database already has a certain
table structure defined, and (e.g.) the `CREATE TABLE` command would fail.

The only solution to this would be to delete our local database, and re-create
it using the new schema. This would work fine in development. However, what if
we already have this application running publicly, and people are already using
it? We'd then loose all the data that has been stored previously.

Obviously that wouldn't be an acceptable solution.

The solution to this is a concept that is referred to as *database migrations*.

Let's have a look.


# SQLite

[SQLite](http://en.wikipedia.org/wiki/SQLite) is a minimalistic implementation
of a relational database that supports most of SQL, although not all of it. It
is less powerful than, for example, [PostgreSQL](http://en.wikipedia.org/wiki/PostgreSQL) and
[MySQL](http://en.wikipedia.org/wiki/MySQL), but it's also super lightweight,
and great for learning, experiments, and getting started quickly.

We are going to use the database SQLite in our examples, because it's the least
hassle to set it up. So you want to make sure you have it installed, many
operating systems have it preinstalled.

Check if it's installed by running this in your terminal:

```
$ sqlite3 --version
```

If that outputs a version string then SQLite is installed. If it's not then
you'll see something like `command not found: sqlite3`. In that case Mislav has
written up some nice instructions [over here](http://mislav.uniqpath.com/rails/install-sqlite3/).

SQLite comes with a handy command line tool that one can use to create
databases and interact with them. It also has an interactive
[shell](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop):
Just like with [IRB](http://ruby-for-beginners.rubymonstas.org/your_tools/irb.html)
(where we can execute Ruby code interactively) we can log into the SQLite
database, and execute [SQL](/databases/sql.html) statements interactively.

Let's try it:

```
$ sqlite3 members
```

This should put you into the interactive SQLite shell, and look something
like this:

```
SQLite version 3.8.5 2014-08-15 22:37:57
Enter ".help" for usage hints.
sqlite>
```

The prompt `sqlite>` waits for your input. If you type an SQL command and hit
return it will execute it.

Let's create our `members` table:

```
sqlite> CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

If this does not output an error, then the command was successful.

The command says that we'd like to create a table `member` with 3 columns `id`,
`name`, and `joined_on`. The column `id` is supposed to be an integer column,
and we'd like to use it as our primary key (meaning that it will be unique, and
it will autoincrement the id for us). The column `name` is a string column, and
values can be 255 characters long. And `joined_at` is a date column.

Cool. So we've just created a table in our database.

We can list our tables like so:

```
sqlite> .tables
members
```

And we can check the structure (schema) of our `members` table like so:

```
sqlite> .schema members
CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

Nice.

Now let's insert a row to the table:


```
sqlite> INSERT INTO members(name, joined_on) VALUES('Anja', '2013-06-24');
```

Again, if this does not output anything, that means our command was successful.

We can now retrieve the data using a `SELECT` statement like so:

```
sqlite> SELECT * FROM members;
1|Anja|2013-06-24
```

So this displays on row.

Now should be a good time to do some [exercises on SQL](/exercises/sql.html).





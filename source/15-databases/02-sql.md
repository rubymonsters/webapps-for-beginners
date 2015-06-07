# SQL

*Talk to databases*

Using SQL (Structured Query Language) we can talk to (relational) databases.

For example we can ask (query) the database to retrieve certain bits of
information from tables, or we can insert, update or delete data. And SQL is
also the language that is used to define the database structure in the first
place.

SQL was invented in the 1970s, and it's quite ugly to look at. However, lots
of database systems support it, and so it's quite common to use SQL in web
applications in some way.

For example, we could retrieve all fields in the first row from our `members`
table like this:

```sql
SELECT * FROM members WHERE id = 1;
```

The statement `SELECT` tells the database that we'd like to *retrieve* data (as
opposed to, for example, `INSERT` which inserts a new row, or `UPDATE` which
updates an existing row). The star `*` means "all fields". `FROM` specifies the
table that we want to look at, and `WHERE` specifies a condition that this row
needs to match: We'd like to retrieve the row where the value in the `id`
column equals `1`.

So our query above would return a result containing one row:

```
1 | Anja | 2013-06-24
```

However, when we ask for all rows that have the `joined_on` date `2013-06-24`
we'd get back two rows:

```sql
SELECT * FROM members WHERE joined_on = '2013-06-24';
```

This would return:

```
1 | Anja  | 2013-06-24
2 | Carla | 2013-06-24
```

Instead of asking for all fields per row, we could also just ask for a certain
column that we are interested in:

```sql
SELECT name FROM members WHERE joined_on = '2013-06-24';
```

This would return just the names:

```
Anja
Carla
```

In order to insert a new row to the table we could use an SQL statement like
this (assumning our `id` column auto-increments, i.e. automatically assigns
the next number to the new row):

```sql
INSERT INTO members (name, joined_at) VALUES('Maren', '2013-06-24');
```

Updating looks like this:

```sql
UPDATE members SET joined_on = '2013-06-24' WHERE id = 3;
```

And deleting like this:

```sql
DELETE FROM members WHERE id = 3;
```

As you can see these statements all look somewhat similar, starting with a certain
command, naming the table, and ending with a semicolon. However, they also don't
really look very consistent. For example, why does the `INSERT` statement separate
the column names and inserted values, while the `UPDATE` statement pairs them?

On the other hand, even though it's a little weird, it's also a very powerful
language, and being able to figure out some SQL and manually writing it can be
very useful when you have access to a database, and you want to find out some
bits of information that cannot be retrieved with the application that is using
the database: You'd just directly talk to the database, and ask it for the
information you need.

Of course there are tools for this. We'll look at libraries that make it easy
to talk to databases in the chapter about [ORMs](/databases/orm.html).

Let's play with a real database, and run some SQL statements next.

# SQL

SQL (Structured Query Language) is a language that (relational) databases
support, and that allows us to ask (query) the database to retrieve certain
information from tables.

SQL was invented in the 1970s, and it's quite ugly to look at. However, lots
of database systems support it, and so it's quite common to use SQL in web
applications in some way.

For example, we could retrieve all fields the first row from our `members`
table like this:

```sql
SELECT * FROM members WHERE id = 1;
```

The statement `SELECT` tells the database that we'd like to retrieve data (as
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

In order to insert a new row to the table we could use an SQL statement like
this:

```sql
INSERT INTO members (id, name, joined_at) VALUES(4, 'Maren', '2013-06-24');
```

Updating looks like this:

```sql
UPDATE members SET joined_on = '2013-06-24' WHERE id = 3;
```

And deleting like this:

```sql
DELETE FROM members WHERE id = 3;
```

As you can see these statemets all look somewhat similar, starting with a certain
command, naming the table, and ending with a semicolon. However, they also don't
really look very consistent. For example, why does the `INSERT` statement separate
the column names and inserted values, while the `UPDATE` statement pairs them?

There are lots of reasons, most of them historical, for why SQL reads weird, and
it's quite unlikely that any of this will change anytime soon.

For this reason there are tools (libraries) that make talking to the database
a little bit more easy: they generate SQL code for you, and let your code be more
readable, using some kind of [DSL](/sinatra/dsl.html).

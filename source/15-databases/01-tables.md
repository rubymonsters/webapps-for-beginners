# Tables

At its core, you can imagine a database as a bunch of spreadsheets. Except
they're called "tables", and they can be huge, containing tons and tons of
rows. More than any spreadsheet ever could handle.

Each table has a bunch of columns, and can have an arbitrary number of rows
(also referred to as "records"). Columns (also referred to as "fields") have a
name and a type. Their type specifies which kind of data can be stored. Each
row has a number of cells , and each one of the cells can hold some value with
the type defined by the column.

Let's have a look at an example.

Imagine we have a table called `members`, and it contains our member data. So
it could look like this:

| id | name    | joined_on  |
|----|---------|------------|
| 1  | Anja    | 2013-06-24 |
| 2  | Carla   | 2013-06-24 |
| 3  | Rebecca | 2013-06-31 |

The `id` column would be a running number, so it would have the type `integer`.
The `name` column is a `string` (databases call it this type a `varchar`), and
the `joined_on` column is a `date`.

For a table like this, the columns (with their name and type) are referred to
as the database *structure*, whereas the rows represent the *data* that we
store.  Rows change all the time: new members sign up, existing members change
their details, or remove their profile etc. The structure remains the same,
unless we, as developers, need another column, or table in order to store more
data.

Databases usually contain many tables. And often data from one table relates
to data in other tables.

For example, we could add the ability to post status updates to our members
application. Maybe we would have a table `statuses`:

| id | member_id | message                                          |
|----|-----------|--------------------------------------------------|
| 1  | 1         | Finished the search feature for speakerinnen.org |
| 2  | 1         | Working on the CSS cleanup with Maren next       |
| 3  | 3         | Created some new designs for our stickers!       |

The `id` column, again, contains a running number that allows to identify a
single status update. The column `message` obviously contains the status update
message.

What about the `member_id` column though?

It references a row in a different table: our `members` table. This means that,
in this example, Anja has posted two status updates, Rebecca one, and Carla
hasn't posted yet.

If you look at the two columns `id` and `member_id` you notice that the column
`id` is special: It must never contain duplicate values, because we want to use
the `id` to identify a certain message (or member). This is called a *primary
key*, and the column is called a "unique" one. Also, it usually auto-increments
the id for us: Whenever we store a new row to this table then the database will
assign an id, make sure we get the next number, and never get duplicate values.

These "features", or special properties of the `id` column also are considered
part of the structure, alongside with the column name and type: we define
these things when we create or modify the database structure.

The column `member_id` on the other hand should not be unique: We want to be
able to store many messages that all belong to the same member row, in the
`members` table. Therefor we need to be able to have multiple rows with the
same `member_id` in the `messages` table.

Does that make sense? This is how we can store data in a database, give it a
certain structure, and relate a piece of data (a row) in one table to data
(rows) in other tables.

Now, how can we talk to a database like this? How can we actually add data to a
table, or retrieve it?

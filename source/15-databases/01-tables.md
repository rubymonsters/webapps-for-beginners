# Tables

At it's core, you can imagine a  database as a bunch of spreadsheets, except
they're called "tables".

Each table has a bunch of columns, and can have an arbitrary number of rows
(also referred to as "records").  Columns have a name and a type. Their type
specifies which kind of data can be stored. Each row has a number of cells
(referred to as "fields"), and each one of the cells can hold some value
with the type defined by the column.

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
hasn't posted, yet.

Now, how can we add data to a table, or retrieve it?

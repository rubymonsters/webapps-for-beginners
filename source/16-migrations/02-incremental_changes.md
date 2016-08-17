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


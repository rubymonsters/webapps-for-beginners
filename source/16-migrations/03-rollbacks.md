## Incremental rollbacks

So far you've learned how to, on a conceptual level, keep track of incremental
changes to your database structure. You learned how to store such changes in
files that can be shared, and, when executed will change the database structure
one step after another.

That's pretty useful.

However, there's more to migrations.

What if we make a change to our database structure, apply it to our
"production" application (i.e. the one that is publicly running on the
internet, and actively used by our users), and then notice we've made a
mistake? We'd then need a way to quickly roll back our change. How would we do
that?

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


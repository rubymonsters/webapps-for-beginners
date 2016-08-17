## Migration tools

Of course, managing all of this manually is a little tedius so far:

* We need to deal with plain SQL.
* We need to execute individual SQL (migration) files with a manual command on the command line.
* We do not have a good way of keeping track of the change (version) number that has been applied to the database structure last.

For that reason ORM tools usually come with a way to not only automatically
track changes that still need to be applied to the database structure (and
skip the ones that already were applied in the past).

They also allow us to define the database structure in a Ruby
[DSL](/sinatra/dsl.html), so we do not have to deal with the gory details of
SQL, but can use some nice, readable Ruby code instead.

Here's an example of a migration written for Sequel:

```ruby
Sequel.migration do
  up do
    create_table(:members) do
      primary_key :id
      string :name
      datetime :joined_on
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
      table.datetime :joined_on
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

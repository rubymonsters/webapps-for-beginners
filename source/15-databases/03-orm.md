# Object Relational Mappers

There are lots of reasons, most of them historical, why SQL reads weird, and
it's quite unlikely that SQL will be come a more pleasant language, or replaced
anytime soon.

For this reason programmers have written lots, and lots of tools (libraries)
that make talking to, and working with the database a little bit more easy.

One class of such tools is called ORM: [Object Relational Mappers](http://en.wikipedia.org/wiki/Object-relational_mapping).

An ORM is a library that "maps" data, stored in a database, to objects, and
usually has methods such as `save`, in order to save an object, `create`,
`update`, and so on. In other words, they often also provide a
[DSL](/sinatra/dsl.html) for working with the database.

Two widely used ORMs in Ruby are [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord),
which is part of Rails, and [Sequel](https://github.com/jeremyevans/sequel),
which is more modern, slick, and performant.

Since you'll get to know ActiveRecord when you learn Rails anyway we'll
introduce Sequel first so you get to know two libraries, and can compare them.

Install the Sequel gem like so:

```
$ gem install sequel
```


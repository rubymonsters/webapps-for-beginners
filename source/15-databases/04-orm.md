# Object Relational Mappers

*Map database contents to Ruby objects*


There are lots of reasons, most of them historical, why SQL reads weird, and
it's quite unlikely that SQL will become a more pleasant language, or replaced
anytime soon.

For this reason programmers have written lots and lots of tools (libraries),
which make talking to, and working with relations databases a little bit
easier.

One class of such tools is called ORM: [Object Relational Mappers](http://en.wikipedia.org/wiki/Object-relational_mapping).

An ORM is a library that "maps" data, stored in a database, to objects, and
usually has methods such as `save`, in order to save an object as a database
row, `create` to insert new data, `update` to change it, and so on. In other
words, they usually provide a [DSL](/sinatra/dsl.html) for working with the
database.

Your data is stored in the database as rows, because that's what databases
do. However in your Ruby application (or whatever language you use for this)
you would see, and use this data as objects: because that's what Ruby is
great at. The ORM is a tool that transforms your database data to Ruby
objects and vice versa.

Does that make sense?

Let's look at an example.

If we have a database table `members` like this:

| id | name    | joined_on  |
|----|---------|------------|
| 1  | Anja    | 2013-06-23 |
| 2  | Carla   | 2013-06-24 |
| 3  | Rebecca | 2013-06-31 |

Then in our Ruby code, using an ORM, we could communicate with it like so:

```ruby
class Member # we'd need to somehow include the ORM functionality
end

# Find one member

member = Member.find(id: 1)
puts "#{member.name} has joined on #{member.joined_on}."

# Change the member's joined_on date:

member.joined_on = '2013-06-24'
member.save

puts
puts "Correction!"
member = Member.find(id: 1)
puts "#{member.name} has joined on #{member.joined_on}."

# Find several members based on their joined_on date:

puts
puts "Who joined on 2013-06-24?"
members = Member.where(joined_on: '2013-06-24')
members.each do |member|
  puts "#{member.name} has joined on #{member.joined_on}."
end
```

And this would output:

```
Anja has joined on 2013-06-23.

Correction!
Anja has joined on 2013-06-24.

Who joined on 2013-06-24?
Anja has joined on 2013-06-24.
Carla has joined on 2013-06-24.
```

Of course the details of this Ruby code might vary, depending on the concrete
ORM tool that we are using.

But the basic idea is that we can use Ruby classes and objects to retrieve some
data from the database (as in `Member.find(id: 1)`), which would then appear in
our application as a normal Ruby object. We can call methods to look up fields
(such as in `member.name`, which returns the value from the `name` column).
And we can use the same object to modify, and save the data back to the
database.

Two widely used ORMs in Ruby are [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord),
which is part of Rails, and [Sequel](https://github.com/jeremyevans/sequel),
which is more modern, slick, and performant.

Since you will anyway get to know ActiveRecord later when you learn Rails, we
will introduce Sequel first. This way you will get to know two libraries and
can later compare them.

You can install the Sequel gem like so:

```
$ gem install sequel
```


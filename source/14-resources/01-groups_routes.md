# Groups of routes

Imagine we are building an application that allows managing the members of our
study group. There's a way to

* list all the members
* look at a member's details
* add a new member
* update a member's details
* remove a member

That's exactly what a *lot* of web applications do, with certain variations.

Almost all web applications that you use on a daily basis will, in some way or
the other, have lists of things. Amazon has lists of goods, and so has Ebay.
Facebook has lists of posts, and so has Twitter. Gmail obviously has lists of
emails, and so on, and so on. Usually there's a way to display details for
these things, to create new instances (e.g. by publishing a post on Facebook),
editing, and deleting them.

Because this is such a common scheme, Rails has added a first class concept for
this. And, as we do, we are going to re-implement it in Sinatra. This way you'll
have a great understanding of what a "resource" is in Rails once you get started
with that framework.

Also, for our purposes we'll deviate from Rails just a little bit. And we'll
explain that later.

In a nutshell, Rails defines a `resource` as a collection of routes that deal
with the same "thing". In our example we deal with "members", so our resource
will be `members`.

Here's what the routes that make up our resouce look like:

* `GET /members` displays a list of all members
* `GET /members/:id` displays the details for a single member
* `GET /members/new` displays a form for creating a new member
* `POST /members` creates a new member from that form
* `GET /members/:id/edit` displays a form for editing a member's details
* `PUT /members/:id` updates a member's details from that form
* `GET /members/:id/delete` asks for confirmation to delete the member
* `DELETE /members/:id` deletes the member

Here's the same information as a table. Note that we also give names to these
routes [1]:

| Name    | Method | Path                | Function                            |
| ------- | ------ | ------------------- | ----------------------------------- |
| index   | GET    | /members            | Display all members                 |
| show    | GET    | /members/:id        | Display a single member             |
| new     | GET    | /members/new        | Display a form for a new member     |
| create  | POST   | /members            | Create that new member              |
| edit    | GET    | /members/:id/edit   | Display a form for editing a member |
| update  | PUT    | /members/:id        | Update that member                  |
| delete  | GET    | /members/:id/delete | Ask for a confirmation to delete    |
| destroy | DELETE | /members/:id        | Delete a member                     |

These names are the same as the ones that Rails uses, too. We'll use these
names for our templates, in case we need a template. Naming them the same for
every resource that we write, ever, helps others to understand what we're
talking about in an instant.

So lets look at the routes more. If you look at the purpose of our routes,
there are 4 groups:

* `index` and `show` are used to display existing data.
* `new` and `create` are used to create a new member.
* `edit` and `update` are used to update a member.
* `delete` and `destroy` are used to delete a member

The two pairs `new` and `create` as well as `edit` and `update` would follow
the same pattern that we've discussed in the chapter about
<a href="/validations">Validations</a>:

* The first one request `GET`s an HTML form for the user to enter some data.
* This form is then submitted as another request, using `POST` or `PUT`, to the
  second route.
* The second route validates the data.
* If the data is valid it creates/updates the member, and redirects to the show
  view, passing a confirmation message.
* If the data is not valid it re-renders the form with an error message.

For the last pair there's no validation, of course. Instead we just delete the
object and redirect to the index view.

However there's a problem with all this:

Today's browsers still do not allow sending HTTP requests using any other verb
than `GET` and `POST`.

Ouch.

So what do we do?

We fake that. Let's see ...


## Footnotes

[1] For our purposes here we have deviated from Rails a little, and added an
8th route: `GET /members/:id/delete`. This route displays a page that asks for
a confirmation to delete. In Rails this is solved with a little Javascript box
that pops up and asks this question. However, we don't want to get into
Javascript too much just yet, and adding this route is a just as valid
solution, too. In fact, some web applications out there prefer this over
the Javascript solution.

# Groups of routes

Imagine we are building an application that allows managing the members of our
study group. There's a way to

* list all of them
* look at a member's details
* add new members
* update a member's details
* remove members

That's exactly what a *lot* of web applications do, with maybe certain
variations.

Because it's such a common scheme, Rails has added a first class concept for
that, which we are going to re-implement in Sinatra. This way you'll have a
great understanding of what a "resource" is in Rails once we get started with
that framework.

Also, for our purposes we'll deviate from Rails a little bit, and add an 8th
route, which displays a page that asks for a confirmation to delete. In Rails
this is solved with a little Javascript box that pops up and asks this
question.  However, we don't want to get into Javascript too much just yet, and
adding this route is a just as valid solution, too.

Here's how these routes look like. We'll use the path `/members` in our
example.

* `GET /members` displays a list of all members
* `GET /members/:id` displays the details for a single member
* `GET /members/new` displays a form for creating a new member
* `POST /members` creates a new member from that form
* `GET `/members/:id/edit` displays a form for editing a member's details
* `PUT /members/:id` updates a member's details from that form
* `GET /members/:id/delete` asks for a confirmation to delete the member
* `DELETE /members/:id` deletes the member

Here's the same information as a table. Note that the names are the ones that Rails
uses for them. We'll use these names for our templates, in case we need a template.


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

So there are 4 groups of routes:

* `index` and `show` are used to display data.
* `new` and `create` are used to create a new member.
* `edit` and `update` are used to update a member.
* `delete` and `destroy` are used to delete a member

The two pairs `new` and `edit` as well as `edit` and `update` follow the same
pattern that we've discussed in the chapter about <a href="/validations">Validations</a>:

* The first request `GET`s an HTML form for the user to enter some data.
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


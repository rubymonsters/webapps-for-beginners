# Sessions

HTTP is a so called <a href="http://en.wikipedia.org/wiki/Stateless_protocol">stateless protocol</a>.
Wikipedia says:

*"In computing, a stateless protocol is a communications protocol that treats
each request as an independent transaction that is unrelated to any previous
request so that the communication consists of independent pairs of request and
response."*

Imagine talking to a person with a very shortlived memory:

* Hey, who are you? - *I'm a web application.*
* Hey, who are you? - *I'm a web application.*
* Hey, who are you? - *I'm a web application.*
* How often have I just asked you who you are? - *I don't know, I don't keep track.*

That's what's meant by HTTP being stateless: The web application just responds
to the request at hand, but has no way to identify how these requests relate to
each other.

Imagine thousands of users clicking around and using your web application. The
application would just respond to each of these requests individually, but does
not know from the protocol where these requests are coming from, or how many
people (browsers) it is talking to: There is no concept of a conversation, or
"session" in HTTP.

Basically.

However, of course there are ways to identify your users. We all know that we
can sign in to a web application, and it would recognize who we are. Right?

When you sign into Gmail it will display *your* emails, not anyone else's
emails.  Obviously it needs to know who you are, so it can find *your* emails.
The same happens for basically every useful, modern web application.

In order to identfy who is making a request web applications often use cookies
for this. There are other techniques, but using cookies is by far the most
common one.

So let's check that out.


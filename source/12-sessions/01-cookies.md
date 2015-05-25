# Cookies

A cookie is a little piece of information that a web application can send along
with a response that will be stored by the browser. From then on, when the
browser makes another request to the same application, it will include the cookie
to the request, sending it back to the application.

For example, an HTTP response that sets a cookie for a user's prefered visual
theme could look like this:

```
HTTP/1.0 200 OK
Content-type: text/html
Set-Cookie: theme=light
```

From now on, the browser would then include the cookie to subsequent requests:

```
GET /blog.html HTTP/1.1
Host: rubymonstas.org
Cookie: theme=light
```

This way the application could apply the "light" theme to the blog, because the
user has selected it in some previous request.

<p class="hint">
Cookies are a way to persist (keep) state (data) across multiple HTTP requests.
</p>


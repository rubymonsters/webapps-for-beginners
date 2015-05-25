# Storing data

So far our little application doesn't do anything with the data that we submit,
except for displaying it on the same page right away. Once you go to another
URL that previous data is gone.

Instead, let's store it to a file. Normally, web applications would use some
kind of database for storing data, but for our purpose using a file will be
good enough.

What we want to achive is that every name ever submitted to our application
is appended to a file, let's say `names.txt`. So we'll keep a long running
list of all these names.

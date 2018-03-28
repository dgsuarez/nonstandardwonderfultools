ag
==

[ag](https://geoff.greer.fm/ag/) is a regex based file finder, a more user
friendly version of `grep -r ...` or `find ... | grep ...`

In `emoji-search` we have a full react app where we'll be doing the search, to
make it more interesting, let's make sure we have `node_modules` fully loaded:

```{.sh}
sh -c 'cd emoji-search && npm install'
```

The most basic usage is searching for a regex:

```{.sh}
ag '<\w+' emoji-search
```

This will search for all opening tags in files in the emoji-search folder (a
React app) and all its descendants, it's pretty similar to `grep -r`, however:

* It'll ignore files in `.gitignore` and in `.git` (or other SCMs). For
  example, there are no results from `node_modules`.
* Regexes are Perl-style (that is, like in most modern programming languages),
  not POSIX-style, things like `\d`, `\w` work as you expect them to (you can
  use `grep -P` for similar results in this regard though).

We can actually compare the results with what we'd get from `grep -Pr`, to see
how all the content from `node_modules` is searched:

```{.sh}
grep '<\w+' -Pr emoji-search
```

You can also limit your search by giving a list of folders or files, using a
file type switch, or a regex for the path:

```{.sh}
ag '<\w+' emoji-search/src/ emoji-search/public/
ag --js --html '<\w+'
ag '<\w+' -G App
```

A lot of the options available in grep are also available here, for example you
can `-l` to only list files, and `-0` to use zero separated
output, so it plays nicely in pipes, for example with xargs + sed:

```{.sh}
ag --js -0 -l Emoji | xargs -0 sed 's/Emoji/Smili/g'
```

[Emoji search](https://github.com/ahfarmer/emoji-search) is a project by
@ahfarmer.


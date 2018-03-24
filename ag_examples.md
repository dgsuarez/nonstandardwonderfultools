ag
==

[ag](https://geoff.greer.fm/ag/) is a regex based file finder, a more user
friendly version of `grep -r ...` or `find ... | grep ...`

The most basic usage is searching for a regex:

```{.sh}
ag 'm\d+\.medium'
```

This will search for `m\d+\.medium` in files in the current folder and all its
descendants, it's pretty similar to `grep -r`, however:

* It'll ignore files in `.gitignore` and in `.git` (or other SCMs)
* Regexes are Perl-style (that is, like in most modern programming languages),
  not Unix style, things like `\d`, `\w` work as you expect them to.

You can also limit your search by giving a list of folders, using a file type
switch, or a regex for the path:

```{.sh}
ag 'm\d+\.medium' lib/ test/'
ag 'm\d+\.medium' --json
ag 'm\d+\.medium' -G 'ec2.*json'

ag 'm\d+\.medium' -G 'ec2' --json lib/ test/
```

A lot of the options available in grep are also available here, for example you
can `-l` to only list files, and `-0` to use zero separated
output, so it plays nicely piping to xargs:

`ag -l -0 'm\d+\.medium' | xargs -0 sed -i 's/medium/small/g'`


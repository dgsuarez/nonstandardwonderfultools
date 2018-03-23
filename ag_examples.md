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

You can also limit your search, to a list of folders:

```{.sh}
ag 'm\d+\.medium' lib/ test/'
```

A regex that the full file path must match:

```{.sh}
ag 'm\d+\.medium' -G 'ec2.*json'
```

Or a file type switch:

```{.sh}
ag 'm\d+\.medium' --json
```

A lot of the options available in grep are also available here, you can `-l` to
only list files, `-v` to do reverse matching, or `-0` to use zero separated
output.



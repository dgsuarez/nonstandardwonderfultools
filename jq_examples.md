jq
==

[jq](https://stedolan.github.io) is a JSON processor, it uses a small language
reminescent of sed, awk, and xpath to work with JSON files.

The simplest feature of jq is that since by default it formats and colorizes
output, it works as a json formatter / highlighter:

```{.sh}
jq ec2-describe-instances.json
```

But it's so much more. We can provide a jq _program_ (remember to always use
single quotes around it to avoid nasty substitution issues!). The most
straightforward ones simply use `.key` and `[index]` to navigate a JSON
document:

```{.sh}
cat ec2-describe-instances.json | jq '.data'
cat ec2-describe-instances.json | jq '.data.Reservations[0].Instances[0]'
```

(For ease of read we'll be using `cat file | jq program`, but you can simplify
by doing `jq program file`)

One key feature is `[]`, instead of accessing a single index, this will map over every index:

```{.sh}
cat ec2-describe-instances.json | jq '.data.Reservations[].Instances[].InstanceType'
```

In jq everything is a filter (understood in the classic UNIX sense of the word,
like a pure function that does `in > filter > out`). As in UNIX we can combine
filters by piping. For example, jq comes with some prebuilt functions, such as
`keys`, which returns... the keys of an object. By using piping, we can get
where we want in the document using a filter with access expressions, and then
pipe that to the `keys` function.

```{.sh}
cat ec2-describe-instances.json | jq '.data.Reservations[0] | keys'
```

So far we've seen how to get somewhere in the document, but using jq you can
also build new documents. The next example returns a json stream with only the
values for instance id and architecture of the instances in an array

```{.sh}
cat ec2-describe-instances.json | jq '.data.Reservations[].Instances[] | [.InstanceType, .Architecture]'
```

Same, but this time it returns objects:

```{.sh}
cat ec2-describe-instances.json | jq '.data.Reservations[].Instances[] | {instance: .InstanceType, arch: .Architecture}'
```

(If you want you use the same key names as the original, you can shorten the
last filter to `{InstanceType, Architecture}`)

Or, using the next one, you can return an array with the objects inside:

```{.sh}
cat ec2-describe-instances.json | jq '[.data.Reservations[].Instances[] | {InstanceType, Architecture}]'
```


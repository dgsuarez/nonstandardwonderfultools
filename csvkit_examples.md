csvkit
======

[csvkit](http://csvkit.rtfd.org/) is a collection of CLI utilities that help
when working with CSVs, or more generally, tabular data.

The first command we'll see is `in2csv`, this turns XLSX and some other formats
into CSV.

For XLSX, the `-n` flag will give a list of the sheets in the file, then we can
use `--sheet` to get the data from the sheet we want (by default it gets the
first one).

```{.sh}
in2csv -n air-pollutant.xlsx
in2csv --sheet NO2_station_statistics air-pollutant.xlsx | head -n 20
```

The file we are using has some explanation data before the actual content,
csvkit doesn't offer any command to deal with this as far as I know, but we can
use tail for a quick workaround:

```{.sh}
in2csv --sheet NO2_station_statistics air-pollutant.xlsx | tail -n +12 > no2-air-pollutant.csv
head no2-air-pollutant.csv
```

Now that we have the data in csv, we can start playing around with it. Using
`csvcut` we can limit the output to only certain columns, so, if we want to see
the countries and cities in the dataset we can do the following:

```{.sh}
csvcut -c 'country_iso_code,city_name' no2-air-pollutant.csv | head
```

`csvgrep` is a filtering tool, similar to regular grep, but we can specify the
columns we want to be searched. For example, here is how we can get Spanish
cities in the dataset:

```{.sh}
csvgrep  -c 'country_iso_code' -m 'ES' no2-air-pollutant.csv
```

Remember that since we are working on a UNIX shell, we can combine these
commands together with pipes, for example, to get only the city name for
Spanish cities:

```{.sh}
csvgrep  -c 'country_iso_code' -m 'ES' no2-air-pollutant.csv | csvcut -c 'city_name'
```

For "heavier" analysis we can actually use SQL. While it can do more than this,
`csvsql` can create an in memory SQLite db that where it will run the query
(the name of the table comes from the name of the file). The output is in CSV
(of course!):

```{.sh}
csvsql --query 'SELECT city_name, COUNT(*) FROM "no2-air-pollutant" GROUP BY city_name' no2-air-pollutant.csv
```

Speaking about SQL, `sql2csv` works as a generic db client that outputs CSV:

```{.sh}
sql2csv --db 'mysql://rfamro@mysql-rfam-public.ebi.ac.uk:4497/Rfam' \
        --query "SELECT kingdom,common_name FROM genome WHERE common_name IS NOT NULL LIMIT 10"
```

Keep in mind that these are only some of the commands in csvkit, check out
their [reference](https://csvkit.readthedocs.io/en/1.0.3/cli.html) for a full
list.

(Air pollutant data from [EU Open Data
Portal](https://data.europa.eu/euodp/en/data/dataset/data_air-pollutant-concentrations-at-station))

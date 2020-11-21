# Advent of code 2020

This is my advent of code for the year 2020


## Use

In order to make execution of exercises faster, I have made a little tool:

```bin/aoc```

To view the commands available, open a shell and type `bin/aoc`.

This program expects that for exercise *n*, there exists a function `main` under
the file `src/n/main.rb`, wich will be executed when called with the next
command:

```
bin/aoc --execute n
```

This option can be shortened:

```
bin/aoc -e n
```

If a debugger is needed, byebug will be provided when the flags `--debug` or `-d`
is passed to the script:

```
bin/aoc -e n -d
```

To list all the available exercises to this tool, use the flags `--list` or
`-l`:

```
bin/aoc --list
```

## Exercises

To be done!


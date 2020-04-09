# Smart Pension dev test

Write a script that parses given log file (see [webserver.log](webserver.log)
for formatting example) and outputs two lists:

* Pages by total views ordered in descendance of views.
  Format: `<page> <views> visits`
* Pages by unique views ordered in descendance of views.
  Format: `<page> <views> unique views`


# Usage

```
exe/script.rb webserver.log
```


# Limitations

- Input validation almost doesn't exist. The only flexibility is the fact that
  whitespaces are ignored. Path is not validated, neither is IP.
- Depending on a use case the code should be further optimized:
  - `PageViewsCounter` groups views by path AND ip so it will make slower and
    more memory consuming if unique page views stops being a thing.
  - The main entry point is the executable script which makes it impossible to
    just "plug and play" into a project. For that, entry point can be moved to
    another class. Main reason why counter is being used directly in the script
    is that it's more optimal for large inputs without the need to process files
    manually (I <3 `$<`)

# Testing

```
bundle exec rspec
```

There's no functional test for the script itself

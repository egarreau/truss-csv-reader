# Truss Software Engineering Interview

## Setup

In the root directory, run the following commands:
```
bundle install
rake install
```

## Run the code

CSV Reader takes input from `stdin`. Here are the options for running the gem:

`csv_reader < filename.csv`
`csv_reader`

If your run the gem with no arguments, you can enter one CSV row per line and use `command+d` to exit. The gem will output a normalized CSV on `stdout`.

## Run the tests

Run `bundle exec rspec` from the root directory to execute the test suite.

## CSV normalization

CSV reader applies the following normalizations to a given CSV: 

* The `Timestamp` column is converted from US/Pacific time to US/Eastern and formatted in ISO-8601 format.
* All ZIP codes with fewer than 5 digits are prefixed with 0.
* The `FullName` column is converted to uppercase.
* The columns `FooDuration` and `BarDuration` are converted to floating point seconds format.
* The column `TotalDuration` is replaced with a sum of `FooDuration` and `BarDuration`

I intended to include UTF-8 validation on the entire file, but I ran out of time.

## Prereqs

1. HBase 0.94.7
2. system package `protobuf` 2.4.X
2. JRuby (tested on 1.4.7)

## Run test
`rake test`

## Summary
When using the byte array conversion utils that hbase-jruby uses, it corrupts
the data such that the boundary of the first number leaks into the second one
(or something?). One of the numbers ends up being much larger than it should
be. The first test in `test.rb` does some byte array conversion that seems to
work.

The output I see is:

```
Run options: --seed 34108

# Running tests:

F.

Finished tests in 0.024000s, 83.3333 tests/s, 166.6667 assertions/s.

  1) Failure:
test_completes_roundtrip_with_util_serialization(TestSerializationBug) [test.rb:33]:
Expected: 1370561408
  Actual: 367907499836137455

2 tests, 4 assertions, 1 failures, 0 errors, 0 skips
```

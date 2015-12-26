# toself - pet project for micro-journaling & time tracking

## Disclaimer

This is just a bit of fun to revive my ruby skills and allow me to do some time tracking.

## Synopsis
```
toself start videoblog today we decided to write a videoblog # starts the clock for the videoblog
toself log videoblog something I did # journal entry for the videolog task
toself stop videoblog final post, now I am switching to 3d # stop work on the videoblog task
toself elapsed videoblog # displays the time spent on videoblog
```

## Design goals

- very quick, terse logging
- arbitrary tree-like structure for tags
- ability to start and finish tasks
- ability to log tasks and present an overview

## Notes

Running tests
```
bundle install --binstubs
bin/testrb lib/test.rb
```
Running as a binfile
```
#!/usr/bin/env ruby
# -*- mode: ruby -*-
require "toself/runner"
Toself::Runner.start
```
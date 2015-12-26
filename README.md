# toself - micro journaling for geeks

## Synopsis
```
self start videoblog today we decided to write a videoblog # starts the clock for the videoblog
self log videoblog something I did # journal entry for the videolog task
self stop videoblog final post, now I am switching to 3d # stop work on the videoblog task
self elapsed videoblog # displays the time spent on videoblog

self log videoblog
xyz123 started videoblog
self edit <id>
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
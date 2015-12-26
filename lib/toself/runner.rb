require 'rubygems'
require 'thor'
require 'toself/service'
require 'toself/params'
require 'toself/store/local'

class Toself
  class Runner < Thor 
    desc "start", "start a task"
    def start(key, *msg)
      puts "start #{key} #{msg}"
      toself = Toself::Service.new(Toself::Store::Local.new)
      toself.start(Toself::Params.new(key: key, msg: msg.join(' ')))
    end

    desc "stop", "stop a task (temporarily)"
    def stop(key, *msg) 
      puts "stop #{key} #{msg}"
      toself = Toself::Service.new(Toself::Store::Local.new)
      toself.stop(Toself::Params.new(key: key, msg: msg.join(' ')))
    end

    desc "stop", "stop a task (temporarily)"
    def log(key, *msg) 
      puts "stop #{key} #{msg}"
      toself = Toself::Service.new(Toself::Store::Local.new)
      toself.log(Toself::Params.new(key: key, msg: msg.join(' ')))
    end

    desc "elapsed", "echo minutes spent on task"
    def elapsed(key)
      toself = Toself::Service.new(Toself::Store::Local.new)
      elapsed = toself.elapsed(Toself::Params.new(key: key))
      puts "elapsed #{key} #{elapsed} min (#{(elapsed / 60)} hours}"
    end
  end
end
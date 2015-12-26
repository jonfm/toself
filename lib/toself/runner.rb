require 'rubygems'
require 'thor'
require 'toself/service'
require 'toself/params'
require 'toself/store/local'

class Toself
  class Runner < Thor
    @toself = Toself::Service.new(Toself::Store::Local.new('data.json'))
    
    desc "start", "start a task"
    def start(key, *msg)
      puts "start #{key} #{msg}"
      @toself.start(ToSelf)
    end

    desc "stop", "stop a task (temporarily)"
    def stop(key, *msg) 
      puts "stop #{key} #{msg}"
    end

    desc "finish", "finish a task (finally)"
    def finish(key, *msg)
      puts "finish #{key} #{msg}"
    end
  end
end
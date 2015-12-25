require 'rubygems'
require 'thor'
require 'toself'

class ToselfCli < Thor
  @toself = ToSelfService.from_dir("./data")

  desc "start", "start a task"
  def start(key, *msg)
    puts "start #{key} #{msg}"
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

ToselfCli.start
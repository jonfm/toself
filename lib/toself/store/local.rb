require 'json'
require 'date'

class Toself
  class Store
    class Local
      DEFAULT_FILESTORE = "#{ENV['HOME']}/.toself.log.json"

      def initialize(file = DEFAULT_FILESTORE)
        @file = file
        if File.exist?(@file) 
          @log = JSON.parse(File.read(@file))
        end
        @log ||= structure
      end
      def structure
        Hash.new { |h, k| h[k] = [[]] }
      end
      def reset!
        @log = structure
        persist!
      end
      def persist!
        File.open(@file, 'w') {|f| f.write JSON.pretty_generate(@log) } 
      end
      def start(params)
        log(params)
      end
      def stop(params)
        log(params)
        @log[params.key].push([])
      end
      def periods(key)
        periods = []
        @log[key].each { |p| p.length > 0 && periods.push(p)}
        periods
      end
      def events(key)
        events = []
        periods(key).each do |period|
          if period.length > 0
            period.each { |e| events.push(e) }
          end
        end
        events
      end
      def log(params)
        @log[params.key] ||= []
        @log[params.key][0] ||= []
        @log[params.key].last.push({"at" =>  params.at, msg: params.msg })
      end
      def elapsed(key)
        log = @log[key]
        elapsed = 0
        log.each do |period|
          if period.length > 0
            elapsed += DateTime.parse(period.last["at"].to_s) - DateTime.parse(period.first["at"].to_s)
          end
        end
        elapsed
      end
    end
  end
end
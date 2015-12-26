require 'date'
require 'json'

class ToselfServiceParams
  attr_reader :key, :msg, :at
  def initialize(key: "/", msg: "", at: DateTime.now)
    @key = key.respond_to?(:to_sym) ? key : raise("key must support to_sym")
    @msg = msg.respond_to?(:to_str) ? msg : raise("msg must support to_str")
    if at.is_a? DateTime 
      @at =at
    else
      begin
        @at = DateTime.new(at)
      rescue Exception => e
        raise "at must be compatible with DateTime.new: #{e}"
      end
    end
  end
  def key
    @key.to_sym
  end
end

class ToselfLocalStore
  def initialize(file = 'log.json')
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
    @log[params.key].last.push({at: params.at, msg: params.msg })
  end
  def elapsed(key)
    log = @log[key]
    elapsed = 0
    log.each do |period|
      if period.length > 0
        elapsed += period.last[:at] - period.first[:at]
      end
    end
    elapsed
  end
end

class ToselfService
  def initialize(datastore = ToselfLocalStore.new)
    @datastore = datastore
  end
  def reset!
    @datastore.reset!
  end
  def start(params)
    @datastore.start(params)
    @datastore.persist!
  end
  def stop(params)
    @datastore.stop(params)
    @datastore.persist!
  end
  def log(params) 
    @datastore.log(params)
    @datastore.persist!
  end
  def periods(params)
    @datastore.periods(params.key)
  end
  def events(params)
    @datastore.events(params.key)
  end
  def elapsed(params)
    (@datastore.elapsed(params.key) * 24 * 60).to_i
  end
end
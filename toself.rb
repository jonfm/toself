require 'date'

class ToselfServiceParams
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

  def msg
    @msg
  end

  def at
    @at
  end
end

class ToselfService
  def initialize(data)
    @log = data
  end
  def start(params)
    if @log[params.key.to_sym].last && @log[params.key.to_sym].last.length > 0
      log(params)
    else
      @log[params.key.to_sym].push([ { at: params.at, msg: params.msg } ])
    end
  end
  def stop(params)
    log(params)
    @log[params.key.to_sym].push([])
  end
  def log(params) 
    @log[params.key.to_sym].last.push({at: params.at, msg: params.msg })
  end
  def elapsed(params)
    log = @log[params.key.to_sym]
    elapsed = Rational(0)
    log.each do |period|
      if period.length > 0
        elapsed += period.last[:at] - period.first[:at]
      end
    end
    elapsed * 24 * 60
  end
end
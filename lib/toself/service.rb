class Toself
  class Service
    def initialize(datastore = Toself::Store::Local.new)
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
end
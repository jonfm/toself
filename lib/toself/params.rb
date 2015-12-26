require 'date'

class Toself
  class Params
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
end
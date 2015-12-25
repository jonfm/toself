require "rubygems"
require "test/unit"
require "toself"

class TestToselfService < Test::Unit::TestCase
  class ToselfScenario
    def initialize(testcase)
      @testcase = testcase
      @now = DateTime.now
    end
    def given_a_toself()
      given_a_log(Hash.new { |h, k| h[k] = [] })
    end
    def given_a_log(data)
      @toself = ToselfService.new(data)
    end
    def when_i_check_elapsed(key)
      @elapsed = @toself.elapsed(ToselfServiceParams.new(key: key))
    end
    def then_it_should_report(expected)
      @testcase.assert_equal( expected, @elapsed )
    end
    def i_start(key, at_in_words = nil)
      at = at_from_words(at_in_words)
      @toself.start(ToselfServiceParams.new(key: key, msg: "some message", at: at))
    end
    def i_stop(key, at_in_words = nil)
      at = at_from_words(at_in_words)
      @toself.stop(ToselfServiceParams.new(key: key, msg: "some message", at: at))
    end
    def at_from_words(at_in_words = nil)
      case at_in_words
      when :one_minute_later
        return DateTime.parse("2015-12-25T08:01:00")
      when :one_hour_later
        return DateTime.parse("2015-12-25T09:00:00")
      when :two_hours_later
        return DateTime.parse("2015-12-25T10:00:00")
      else # also :now
        return DateTime.parse("2015-12-25T08:00:00")
      end
    end

  end

  def test_start_stop_elapsed
    scenario = ToselfScenario.new(self)
    scenario.given_a_toself
    scenario.i_start(:foo, :now)
    scenario.i_stop(:foo, :one_minute_later)
    scenario.i_start(:foo, :one_hour_later)
    scenario.i_stop(:foo, :two_hours_later)
    scenario.when_i_check_elapsed(:foo)
    scenario.then_it_should_report(60 + 1)
  end
end
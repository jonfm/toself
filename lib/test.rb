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
      @toself = Toself::Service.new(Toself::Store::Local.new('test.log'))
      @toself.reset!
    end
    def when_i_check_elapsed(key)
      @elapsed = @toself.elapsed(Toself::Params.new(key: key))
    end
    def then_it_should_report(expected)
      @testcase.assert_equal( expected, @elapsed )
    end
    def i_start(key, at_in_words = nil)
      at = at_from_words(at_in_words)
      @toself.start(Toself::Params.new(key: key, msg: "some message", at: at))
    end
    def i_stop(key, at_in_words = nil)
      at = at_from_words(at_in_words)
      @toself.stop(Toself::Params.new(key: key, msg: "some message", at: at))
    end
    def it_should_have_periods_for_key(num, key)
      @testcase.assert_equal(num, @toself.periods(Toself::Params.new(key: key)).length)
    end
    def it_should_have_events_for_key(num, key)
      @testcase.assert_equal(num, @toself.events(Toself::Params.new(key: key)).length)
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
    scenario.it_should_have_events_for_key(1, :foo)
    scenario.i_stop(:foo, :one_minute_later)
    scenario.it_should_have_events_for_key(2, :foo)
    scenario.it_should_have_periods_for_key(1, :foo)
    scenario.i_start(:foo, :one_hour_later)
    scenario.it_should_have_events_for_key(3, :foo)
    scenario.it_should_have_periods_for_key(2, :foo)
    scenario.i_stop(:foo, :two_hours_later)
    scenario.it_should_have_events_for_key(4, :foo)
    scenario.it_should_have_periods_for_key(2, :foo)
    scenario.when_i_check_elapsed(:foo)
    scenario.then_it_should_report(60 + 1)
  end
end
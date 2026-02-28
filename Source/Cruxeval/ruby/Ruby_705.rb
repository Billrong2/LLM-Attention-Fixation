def f(cities, name)
    if name.nil?
        return cities
    end
    if name && name != 'cities'
        return []
    end
    cities.map { |city| name + city }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call(["Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"], "Somewhere "))
  end
end

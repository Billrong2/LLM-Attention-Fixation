def f(zoo)
  Hash[zoo.map { |k, v| [v, k] }]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"fr" => "AAA"}, candidate.call({"AAA" => "fr"}))
  end
end

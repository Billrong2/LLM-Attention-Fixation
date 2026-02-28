def f(text)
    string_a, string_b = text.split(',')
    -(string_a.length + string_b.length)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-6, candidate.call("dog,cat"))
  end
end

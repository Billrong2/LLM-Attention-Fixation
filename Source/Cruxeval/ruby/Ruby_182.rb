def f(dic)
  dic.sort_by { |key, value| key }
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([["a", 2], ["b", 1]], candidate.call({"b" => 1, "a" => 2}))
  end
end

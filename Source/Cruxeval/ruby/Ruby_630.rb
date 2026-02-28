def f(original, string)
    temp = original.dup
    string.each { |a, b| temp[b] = a }
    temp
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => -9, 0 => -7, 2 => 1, 3 => 0}, candidate.call({1 => -9, 0 => -7}, {1 => 2, 0 => 3}))
  end
end

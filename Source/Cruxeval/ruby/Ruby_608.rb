def f(a_dict)
  a_dict.invert
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({1 => 1, 2 => 2, 3 => 3}, candidate.call({1 => 1, 2 => 2, 3 => 3}))
  end
end

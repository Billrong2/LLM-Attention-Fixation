def f(array)
    d = Hash[array]
    d.each do |key, value|
        return nil if value < 0 || value > 9
    end
    return d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({8 => 2, 5 => 3}, candidate.call([[8, 5], [8, 2], [5, 3]]))
  end
end

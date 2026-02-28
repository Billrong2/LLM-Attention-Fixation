def f(array)
    output = array.dup
    output.values_at(*output.each_index.select(&:even)).reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end

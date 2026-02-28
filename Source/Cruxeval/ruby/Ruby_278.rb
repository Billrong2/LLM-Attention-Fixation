def f(array1, array2)
  result = {}
  array1.each do |key|
    result[key] = array2.select { |el| key * 2 > el }
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({0 => [], 132 => [5, 32]}, candidate.call([0, 132], [5, 991, 32, 997]))
  end
end

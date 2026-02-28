def f(n, array)
  final = [array.dup]
  n.times do
    arr = array.dup
    arr.concat(final[-1])
    final << arr
  end
  final
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([[1, 2, 3], [1, 2, 3, 1, 2, 3]], candidate.call(1, [1, 2, 3]))
  end
end

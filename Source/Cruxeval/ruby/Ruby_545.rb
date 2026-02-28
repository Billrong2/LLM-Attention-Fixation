def f(array)
    result = []
    index = 0
    while index < array.length
        result.push(array.pop)
        index += 2
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([8, -1, 8], candidate.call([8, 8, -4, -9, 2, 8, -1, 8]))
  end
end

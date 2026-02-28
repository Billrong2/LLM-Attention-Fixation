def f(array, elem)
  result = array.dup
  until result.empty?
    key, value = result.shift
    if elem == key || elem == value
      result.update(array)
    end
    result.delete(key)
  end
  result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({}, candidate.call({}, 1))
  end
end

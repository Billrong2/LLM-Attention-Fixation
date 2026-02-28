def f(array, values)
    array.reverse
    values.each do |value|
        array.insert(array.length / 2, value)
    end
    array.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([58, 92, 21], candidate.call([58], [21, 92]))
  end
end

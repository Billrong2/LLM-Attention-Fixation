def f(array)
    array_2 = []
    array.each do |i|
        if i > 0
            array_2 << i
        end
    end
    array_2.sort.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([89, 43, 17, 14, 8, 4], candidate.call([4, 8, 17, 89, 43, 14]))
  end
end

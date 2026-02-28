def f(array)
    a = []
    array.reverse
    array.each do |num|
        if num != 0
            a << num
        end
    end
    a.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end

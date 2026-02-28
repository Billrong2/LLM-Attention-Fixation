def f(numbers)
    numbers.each_char.with_index do |num, i|
        return i if numbers.count('3') > 1
    end
    -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(-1, candidate.call("23157"))
  end
end

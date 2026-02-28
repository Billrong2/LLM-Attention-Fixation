def f(fruits)
    if fruits[-1] == fruits[0]
        return 'no'
    else
        fruits.shift
        fruits.pop
        fruits.shift
        fruits.pop
        return fruits
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["pear", "banana", "pear"], candidate.call(["apple", "apple", "pear", "banana", "pear", "orange", "orange"]))
  end
end

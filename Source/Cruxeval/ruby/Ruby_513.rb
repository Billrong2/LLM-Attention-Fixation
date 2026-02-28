def f(array)
    while array.include?(-1)
        array.delete_at(array.rindex(-3))
    end
    while array.include?(0)
        array.pop
    end
    while array.include?(1)
        array.delete_at(0)
    end
    array
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([0, 2]))
  end
end

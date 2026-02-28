def f(array)
    array.each_with_index do |elem, index|
        array.delete_at(index) if elem < 0
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([]))
  end
end

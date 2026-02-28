def f(lst)
    lst.clear
    lst.each do |i|
        return false if i == 3
    end
    true
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call([2, 0]))
  end
end

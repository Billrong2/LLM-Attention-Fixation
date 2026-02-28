def f(mylist)
    revl = mylist.dup
    revl.reverse
    mylist.sort { |a, b| b <=> a }
    mylist == revl
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call([5, 8]))
  end
end

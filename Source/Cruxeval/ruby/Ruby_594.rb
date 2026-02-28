def f(file)
    file.index("\n")
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(33, candidate.call("n wez szize lnson tilebi it 504n.
"))
  end
end

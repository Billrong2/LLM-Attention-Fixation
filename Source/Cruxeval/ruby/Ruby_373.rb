def f(orig)
    copy = orig
    copy.push(100)
    orig.pop
    copy
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([1, 2, 3], candidate.call([1, 2, 3]))
  end
end

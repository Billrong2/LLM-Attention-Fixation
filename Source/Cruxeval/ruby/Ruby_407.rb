def f(s)
    while s.length > 1
        s.clear
        s.push(s.length)
    end
    s.pop
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call([6, 1, 2, 3]))
  end
end

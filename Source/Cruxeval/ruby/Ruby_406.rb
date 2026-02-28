def f(text)
    ls = text.split('')
    ls[0], ls[-1] = ls[-1].upcase, ls[0].upcase
    ls.join('').capitalize == ls.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("Josh"))
  end
end

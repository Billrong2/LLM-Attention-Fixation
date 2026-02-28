def f(s)
    s.split.map { |word| word.capitalize == word }.count(true)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("SOME OF THIS Is uknowN!"))
  end
end

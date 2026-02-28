def f(letters, maxsplit)
  letters.split.last(maxsplit).join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("elrts,SSee", candidate.call("elrts,SS ee", 6))
  end
end

def f(a)
    a.split.join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("h e l l o w o r l d!", candidate.call(" h e l l o   w o r l d! "))
  end
end

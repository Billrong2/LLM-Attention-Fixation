def f(a, b)
    if a.include?(b)
        a.partition(a[a.index(b) + 1]).join(b)
    else
        a
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("sieriizzizam", candidate.call("sierizam", "iz"))
  end
end

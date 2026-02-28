def f(t)
    a, sep, b = t.rpartition('-')
    if b.length == a.length
        return 'imbalanced'
    end
    return a + b.gsub(sep, '')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("fubarbaz", candidate.call("fubarbaz"))
  end
end

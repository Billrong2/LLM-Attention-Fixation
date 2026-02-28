def f(s1, s2)
  (0..s2.length + s1.length).each do |k|
    s1 += s1[0]
    if s1.index(s2) != nil
      return true
    end
  end
  false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("Hello", ")"))
  end
end

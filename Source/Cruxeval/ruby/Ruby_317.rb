def f(text, a, b)
    text.gsub(a, b).gsub(b, a)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" vap a zwwo oihee amawaaw! ", candidate.call(" vup a zwwo oihee amuwuuw! ", "a", "u"))
  end
end

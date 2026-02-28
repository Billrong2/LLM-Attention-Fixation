def f(text, prefix)
    text[prefix.length..-1]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("23x John z", candidate.call("123x John z", "z"))
  end
end

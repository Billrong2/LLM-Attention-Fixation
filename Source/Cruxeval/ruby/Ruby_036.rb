def f(text, chars)
    text.rstrip.chars.reject { |char| chars.include?(char) }.join
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("ha", candidate.call("ha", ""))
  end
end

def f(text, comparison)
  length = comparison.length
  if length <= text.length
    (0..length-1).each do |i|
      if comparison[length - i - 1] != text[text.length - i - 1]
        return i
      end
    end
  end
  return length
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(0, candidate.call("managed", ""))
  end
end

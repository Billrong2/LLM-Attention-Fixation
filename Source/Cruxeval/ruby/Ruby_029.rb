def f(text)
    nums = text.chars.select { |c| c.match?(/\d/) }
    raise 'AssertionError' if nums.empty?
    nums.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("123314", candidate.call("-123   	+314"))
  end
end

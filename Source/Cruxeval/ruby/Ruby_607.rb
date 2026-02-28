def f(text)
    ['.', '!', '?'].each do |i|
        return true if text.end_with?(i)
    end
    false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call(". C."))
  end
end

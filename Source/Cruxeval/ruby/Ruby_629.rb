def f(text, dng)
    if text.index(dng).nil?
        text
    elsif text.end_with?(dng)
        text[0...-dng.length]
    else
        text[0...-1] + f(text[0...-2], dng)
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("cat", candidate.call("catNG", "NG"))
  end
end

def f(text)
    result = ''
    mid = (text.length - 1) / 2
    (0...mid).each do |i|
        result += text[i]
    end
    (mid...text.length-1).each do |i|
        result += text[mid + text.length - 1 - i]
    end
    result.ljust(text.length, text[-1])
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("e!t!", candidate.call("eat!"))
  end
end

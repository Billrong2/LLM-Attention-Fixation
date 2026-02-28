def f(text, size)
    counter = text.length
    (size - (size % 2)).times do |i|
        text = ' ' + text + ' '
        counter += 2
        return text if counter >= size
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("     7     ", candidate.call("7", 10))
  end
end

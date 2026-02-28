def f(value, char)
    total = 0
    value.each_char do |c|
        if c == char || c == char.downcase
            total += 1
        end
    end
    total
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("234rtccde", "e"))
  end
end

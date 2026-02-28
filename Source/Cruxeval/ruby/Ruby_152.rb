def f(text)
    n = 0
    text.each_char do |char|
        if char == char.upcase and char != char.downcase
            n += 1
        end
    end
    n
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(20, candidate.call("AAAAAAAAAAAAAAAAAAAA"))
  end
end

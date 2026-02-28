def f(text)
    text.each_char.with_index do |char, i|
        if char == char.upcase && i > 0 && text[i-1] == text[i-1].downcase
            return true
        end
    end
    false
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(true, candidate.call("jh54kkk6"))
  end
end

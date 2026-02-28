def f(text)
    odd = ''
    even = ''
    text.each_char.with_index do |c, i|
        if i % 2 == 0
            even += c
        else
            odd += c
        end
    end
    return even + odd.downcase
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Mmohamt", candidate.call("Mammoth"))
  end
end

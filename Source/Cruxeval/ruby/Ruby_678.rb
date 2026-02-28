def f(text)
    freq = {}
    text.downcase.each_char do |c|
        if freq.key?(c)
            freq[c] += 1
        else
            freq[c] = 1
        end
    end
    return freq
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"h" => 1, "i" => 1}, candidate.call("HI"))
  end
end

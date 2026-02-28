def f(phrase)
    ans = 0
    phrase.split.each do |w|
        w.each_char do |ch|
            if ch == "0"
                ans += 1
            end
        end
    end
    ans
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("aboba 212 has 0 digits"))
  end
end

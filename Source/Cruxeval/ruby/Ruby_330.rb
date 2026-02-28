def f(text)
    ans = []
    text.each_char do |char|
        if char.match?(/\d/)
            ans << char
        else
            ans << ' '
        end
    end
    ans.join('')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(" 4 2 ", candidate.call("m4n2o"))
  end
end

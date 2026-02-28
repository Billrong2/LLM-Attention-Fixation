def f(s)
    count = 0
    digits = ""
    s.each_char do |c|
        if c.match?(/\d/)
            count += 1
            digits += c
        end
    end
    [digits, count]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["3291223", 7], candidate.call("qwfasgahh329kn12a23"))
  end
end

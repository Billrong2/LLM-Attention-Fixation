def f(s, separator)
    (0..s.length-1).each do |i|
        if s[i] == separator
            new_s = s.chars
            new_s[i] = '/'
            return new_s.join(' ')
        end
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("h / g r a t e f u l   k", candidate.call("h grateful k", " "))
  end
end

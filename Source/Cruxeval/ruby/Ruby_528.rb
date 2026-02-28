def f(s)
    b = ''
    c = ''
    s.each_char do |i|
        c = c + i
        if s.rindex(c) > -1
            return s.rindex(c)
        end
    end
    return 0
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("papeluchis"))
  end
end

def f(s)
    count = 0
    s.split('').each do |c|
        if s.rindex(c) != s.index(c)
            count += 1
        end
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(10, candidate.call("abca dea ead"))
  end
end

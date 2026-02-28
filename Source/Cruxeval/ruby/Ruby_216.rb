def f(letters)
    count = 0
    letters.each_char do |l|
        if l.match?(/\d/)
            count += 1
        end
    end
    count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call("dp ef1 gh2"))
  end
end

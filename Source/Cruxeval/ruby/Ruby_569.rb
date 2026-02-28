def f(txt)
    coincidences = {}
    txt.each_char do |c|
        if coincidences[c]
            coincidences[c] += 1
        else
            coincidences[c] = 1
        end
    end
    coincidences.values.sum
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(6, candidate.call("11 1 1"))
  end
end

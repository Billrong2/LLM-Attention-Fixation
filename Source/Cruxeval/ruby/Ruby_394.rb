def f(text)
    k = text.split("\n")
    i = 0
    k.each do |j|
        if j.length == 0
            return i
        end
        i += 1
    end
    return -1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call("2 m2 

bike"))
  end
end

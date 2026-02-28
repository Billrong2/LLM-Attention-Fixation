def f(selfie)
    lo = selfie.length
    (lo-1).downto(0) do |i|
        if selfie[i] == selfie[0]
            selfie.delete_at(lo-1)
        end
    end
    selfie
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([4, 2, 5, 1, 3, 2], candidate.call([4, 2, 5, 1, 3, 2, 6]))
  end
end

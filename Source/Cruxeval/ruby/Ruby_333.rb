def f(places, lazy)
    places.sort!
    lazy.each do |l|
        places.delete(l)
    end
    return 1 if places.length == 1
    places.each_with_index do |place, i|
        return i + 1 if places.count(place + 1) == 0
    end
    return i + 1
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(1, candidate.call([375, 564, 857, 90, 728, 92], [728]))
  end
end

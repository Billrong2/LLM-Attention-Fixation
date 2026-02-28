def f(years)
    a10 = years.count { |x| x <= 1900 }
    a90 = years.count { |x| x > 1910 }
    if a10 > 3
        return 3
    elsif a90 > 3
        return 1
    else
        return 2
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(2, candidate.call([1872, 1995, 1945]))
  end
end

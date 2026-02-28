def f(a, split_on)
    t = a.split()
    a = []
    t.each do |i|
        i.each_char do |j|
            a << j
        end
    end
    if a.include?(split_on)
        return true
    else
        return false
    end
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(false, candidate.call("booty boot-boot bootclass", "k"))
  end
end

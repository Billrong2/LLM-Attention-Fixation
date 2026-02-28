def f(s)
  count = {}
  s.each_char do |i|
    if i.match?(/[a-z]/)
      count[i.downcase] = s.count(i.downcase) + count.fetch(i.downcase, 0)
    else
      count[i.downcase] = s.count(i.upcase) + count.fetch(i.downcase, 0)
    end
  end
  count
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"f" => 1, "s" => 1, "a" => 1}, candidate.call("FSA"))
  end
end

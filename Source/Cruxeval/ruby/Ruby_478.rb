def f(sb)
  d = {}
  sb.each_char do |s|
    d[s] = d[s].to_i + 1
  end
  d
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"m" => 2, "e" => 2, "o" => 2, "w" => 2, " " => 1}, candidate.call("meow meow"))
  end
end

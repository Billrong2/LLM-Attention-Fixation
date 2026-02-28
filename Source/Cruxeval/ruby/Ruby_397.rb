require 'set'

def f(ls)
  Hash[ls.map { |x| [x, 0] }]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"x" => 0, "u" => 0, "w" => 0, "j" => 0, "3" => 0, "6" => 0}, candidate.call(["x", "u", "w", "j", "3", "6"]))
  end
end

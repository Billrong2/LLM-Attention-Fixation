def f(a)
  a = a.gsub('/', ':')
  z = a.rpartition(':')
  [z[0], z[1], z[2]]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["", ":", "CL44     "], candidate.call("/CL44     "))
  end
end

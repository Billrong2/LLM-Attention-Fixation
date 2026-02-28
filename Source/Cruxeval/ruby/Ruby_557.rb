def f(s)
    d = s.rpartition('ar')
    return [d[0], d[1], d[2]].join(' ')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("xxxarmm ar xx", candidate.call("xxxarmmarxx"))
  end
end

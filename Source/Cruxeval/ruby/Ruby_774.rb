def f(num, name)
    f_str = 'quiz leader = %s, count = %d'
    f_str % [name, num]
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("quiz leader = Cornareti, count = 23", candidate.call(23, "Cornareti"))
  end
end

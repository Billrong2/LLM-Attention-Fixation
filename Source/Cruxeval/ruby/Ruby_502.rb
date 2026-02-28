def f(name)
    name.split(' ').join('*')
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal("Fred*Smith", candidate.call("Fred Smith"))
  end
end

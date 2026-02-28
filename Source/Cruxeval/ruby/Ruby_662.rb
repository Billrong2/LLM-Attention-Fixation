def f(values)
    names = ['Pete', 'Linda', 'Angela']
    names.concat(values)
    names.sort
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal(["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"], candidate.call(["Dan", "Joe", "Dusty"]))
  end
end

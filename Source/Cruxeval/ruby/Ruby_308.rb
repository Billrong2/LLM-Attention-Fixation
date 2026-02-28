def f(strings)
  occurances = {}
  strings.each do |string|
    occurances[string] = strings.count(string) unless occurances.include?(string)
  end
  occurances
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal({"La" => 3, "Q" => 1, "9" => 1}, candidate.call(["La", "Q", "9", "La", "La"]))
  end
end

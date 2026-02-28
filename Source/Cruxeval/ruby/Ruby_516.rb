def f(strings, substr)
    list = strings.select { |s| s.start_with?(substr) }
    list.sort_by(&:length)
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call(["condor", "eyes", "gay", "isa"], "d"))
  end
end

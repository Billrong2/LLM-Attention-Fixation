def f(names, winners)
  ls = names.each_index.select { |index| winners.include?(names[index]) }
  ls.sort.reverse
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call(["e", "f", "j", "x", "r", "k"], ["a", "v", "2", "im", "nb", "vj", "z"]))
  end
end

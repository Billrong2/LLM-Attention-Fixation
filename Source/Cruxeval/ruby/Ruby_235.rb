def f(array, arr)
    result = []
    arr.each do |s|
        result += s.split(array[arr.index(s)]).reject { |l| l.empty? }
    end
    result
end
require 'test/unit'
class TestHumanEval < Test::Unit::TestCase
  def test_f
    candidate = method(:f)
    assert_equal([], candidate.call([], []))
  end
end
